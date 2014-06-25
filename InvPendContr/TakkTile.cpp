#include <libusb-1.0/libusb.h>
#include <stdio.h>
#include <iostream>
//missing regular expression python import
//missing itertools
#include <stdlib.h> //atexit
#include "TakkTile.h"

#define PID 0x74C7
#define VID 0x59e3

//at end of compiting: -L -lusb-1.0

TakkTile::TakkTile() {
	sampling = false;
	// search for USB device with proper VID/PID combo
	libusb_context *ctx = NULL;
	if(TakkOpen()==0) {
		std::cout<<"Can't find TakkTileUSB interface"<<std::endl;
		TakkClose();
		return;
	}
	if(getAlive(alive)==0) { std::cout<<"didn't get alive"<<std::endl;}
	//skipping getting the XMega's serial numbeir
	//also not setting up an exit safety thing to stopSampling - atexit
};

int TakkTile::TakkOpen() { // i feel like i should be passing takk instead
	usbOpen = true;
	if(libusb_init(&ctx) < 0) {
		std::cout<<"Init Error"<<std::endl;
		return 0; //0 means error and 1 doesnt
	}
	libusb_set_debug(ctx,3); //suggested in documentation apparently
	takk = libusb_open_device_with_vid_pid(ctx,VID,PID);
	if(takk == NULL) {
		//std::cout<<"could not open device"<<std::endl;
		return 0;
	}
	return 1;
};

void TakkTile::TakkClose() {
	if(usbOpen){
		libusb_close(takk);
		libusb_exit(ctx);
	}
	usbOpen = false;
};

int TakkTile::getAlive(unsigned char data[]) {
	return libusb_control_transfer(takk,0x40|0x80,0x5c,0,0,data,40,5000);
};

//int TakkTile::getCalibrationsCoefficients(int index, int coefs[]) {	
//	return 1; //not using as of now
//}

int TakkTile::startSampling(int dt,unsigned char data[]) {
	if(usbOpen) {
		sampling = true;
		return libusb_control_transfer(takk,0x40|0x80,0xC7,dt,0xFF,data,1,5000);
	} else {
		return 0;
	}
};

int TakkTile::stopSampling(unsigned char data[]) {
	if(usbOpen) {
		sampling = false;
		return libusb_control_transfer(takk,0x40|0x80,0xC7,0,0,data,1,5000);
	} else {
		return 0;
	}
};

int TakkTile::getDataRaw(Data &rawdata) {
	unsigned char data[720];
	int transferred=0;
	unsigned char ndata[1000][4];
	
	if (sampling) {
		if(libusb_clear_halt(takk,0x81)) std::cout<<"didnt work"<<std::endl;
		libusb_bulk_transfer(takk,0x81,data,720,&transferred,1000);
	//chunking
	////std::cout<< transferred <<std::endl;
	for (int i = 0; i < transferred/4; i++) {
		for (int j = 0; j < 4; j++) {
			ndata[i][j] = data[j + 4*i];
		//	std::cout<< ndata[i][j] <<std::endl;	
		}
	}


	for (int i = 0; i < transferred/4; i++) { //could combine the two loops possibly
		rawdata.temperatures[i] = ndata[i][3] >> 6 | ndata[i][2] << 2;
		rawdata.pressures[i] = ndata[i][1] >> 6 | ndata[i][0] << 2;
//		std::cout<< rawdata.pressures[i] <<std::endl;
	}

	// for each 5 length element of data
		//data[i][3 and 2] are operated on and added to temperature
		//data[i][1 and 0] are operated on and added to pressure

	//pressures are checked for 2s complement
	//do absolute value to these guys????
	//put this into the Data struct

	}

	rawdata.length = transferred / 4;
	return transferred;
};
int TakkTile::getData(Data &data){
	Data rawdata;
	if(getDataRaw(rawdata)==0){
		return 0;
	}

	for (int i = 0; i < 40; i++) { //only to 40...
		//if(alive[i] == 1) { //should be doing this but not == 1
			data.temperatures[i] = rawdata.temperatures[i];
			if(rawdata.pressures[i] < 512) { 
				data.pressures[i] = rawdata.pressures[i];
			} else {
				data.pressures[i] = rawdata.pressures[i] - 1024;
			}
		//}
	}
	data.length = 40; //???
	return 1;
};

int TakkTile::calibrate(double calib[], int reps){ //calib must be full of 0s: important and 40 long

	for(int i = 0; i < reps; i++) {
		Data temp;
		if(getData(temp)==0){ return 0; } //error checking????
		for(int j = 0; j < 40; j++) {
			calib[j] += (double)temp.pressures[j]/(double)reps;
		}
	}
	return 1;
};

int TakkTile::getCoM(int reps,double arrayX[],double arrayY[]) {
	double baseline[40];
        std::cout<< "calibrating..." <<std::endl;
        if(calibrate(baseline,10)==0) { //change the 10 for more or less calibration
        	return 0;
	}
	std::cout<< "done...5s delay" <<std::endl;//might want to split this up more and PASS one to the other
        sleep(5);
        std::cout<< "going" <<std::endl;

	for (int i=0; i<reps; i++) { //args instead of 5
                Data data;
                getData(data);

                int sumx=0;
                int sumy=0;
                int sum=0;
                for (int i = 0; i < 40; i++) {
                        sumx += (data.pressures[i]-baseline[i])*arrayX[i];
                        sumy += (data.pressures[i]-baseline[i])*arrayY[i];
                        sum += data.pressures[i];
                }
        
                double CoMx = (double)(sumx)/(double)(sum);
                double CoMy = (double)(sumy)/(double)(sum);

                std::cout<< CoMx <<std::endl;
                std::cout<< CoMy <<std::endl;
        }//time how long this takes


	return 1;
};
/*
int main() {
	unsigned char dc1[2];
	unsigned char dc2[2];
	

	TakkTile takktile = TakkTile();
	takktile.startSampling(200,dc2);

	for (int j = 0; j < 5; j++){
	Data raw;
	takktile.getData(raw);
	
	for (int i = 0; i < 40; i++) {
		std::cout<< raw.pressures[i] << std::endl;
	}
	}
	
	takktile.stopSampling(dc1);
	takktile.TakkClose();
	return 0;
};*/
