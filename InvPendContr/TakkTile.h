#ifndef TAKKTILE_H
#define TAKKTILE_H

#include <libusb-1.0/libusb.h>
#include <stdio.h>
#include <iostream>
#include <stdlib.h> 


struct Data {
        int pressures[1000];
        int temperatures[1000];
        int length;
};

class TakkTile{
public: // make some of these private
        TakkTile();
        int TakkOpen();
        void TakkClose();
        int getAlive(unsigned char data[]); //maybe can be private
        //getCalibrationCoefficients(int index, int coefs[]);
        int getDataRaw(Data &rawdata);//maybe structure
        int getData(Data &data);
        //int[] getCalibrationData(int index);
        int startSampling(int dt,unsigned char data[]); //wth is dt
	int calibrate(double calib[],int reps);
	int getCoM(int reps,double arrayX[],double arrayY[]);
        int stopSampling(unsigned char data[]);
private:
        bool usbOpen;
        libusb_device_handle *takk;
        libusb_context *ctx;
        bool sampling;
        unsigned char alive[40];
        int calibCoef[40];
};

#endif
