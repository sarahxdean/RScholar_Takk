#include "TakkTile.h"
//g++ -o executable TakkTile.cpp CoM.cpp -lusb-1.0 to compile
/*int main() {
	double arrayX[] = {4.76, 2.38, 4.76, 2.38, 4.76, 10.76, 8.38, 10.76, 8.38, 10.76, 16.76, 14.38, 16.76, 14.38, 16.76, 22.76,20.38,22.76, 20.38, 22.76,28.76, 26.38,28.76, 26.38, 28.76, 34.76, 32.38, 34.76, 32.38, 34.76, 40.76, 38.38, 40.76, 38.38, 40.76, 46.76, 44.38, 46.76, 44.38, 46.76};
	double arrayY[] = {27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3};

//	Data calibration;
        unsigned char dc1[2];
        unsigned char dc2[2];

        TakkTile takktile = TakkTile();
        takktile.startSampling(200,dc2);

	Data baseline;
	std::cout<< "calibrating..." <<std::endl;
	//if(takktile.calibrate(baseline,10)==0) { 
	//	std::cout<< "error!" <<std::endl;
	//	goto exit;
	//}

	if(takktile.getData(baseline)==0){ std::cout<<"error :("<<std::endl; }

	std::cout<< "done...5s delay" <<std::endl;
	for (int i=0; i<100000000;i++);
	std::cout<< "going" <<std::endl;
        
	for (int i=0; i<1; i++) { //args instead of 5
        	Data data;
		takktile.getData(data);

		double sumx=0;
		double sumy=0;
		double sum=0;
      	for (int i = 0; i < 40; i++) {
               	sumx += (double)(data.pressures[i]-baseline.pressures[i])*arrayX[i];
                	sumy += (double)(data.pressures[i]-baseline.pressures[i])*arrayY[i];
                	sum += (double)data.pressures[i]-baseline.pressures[i];
        	}
        
		double CoMx = (double)(sumx)/(double)(sum);
		double CoMy = (double)(sumy)/(double)(sum);

		std::cout<< CoMx <<std::endl;
		std::cout<< CoMy <<std::endl;
	}//time how long this takes
//	takktile.getCoM(1,arrayX,arrayY);	
	exit:
	takktile.stopSampling(dc1);
        takktile.TakkClose();
        return 1;
};
*/
int main() {
        unsigned char dc1[2];
        unsigned char dc2[2];
        double arrayX[] = {4.76, 2.38, 4.76, 2.38, 4.76, 10.76, 8.38, 10.76, 8.38, 10.76, 16.76, 14.38, 16.76, 14.38, 16.76, 22.76,20.38,22.76, 20.38, 22.76,28.76, 26.38,28.76, 26.38, 28.76, 34.76, 32.38, 34.76, 32.38, 34.76, 40.76, 38.38, 40.76, 38.38, 40.76, 46.76, 44.38, 46.76, 44.38, 46.76};
	double arrayY[] = {27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3};



        TakkTile takktile = TakkTile();
        takktile.startSampling(200,dc2);
        
	double baseline[40];
	std::cout<< "calibrating..." <<std::endl;
	if(takktile.calibrate(baseline,10)==0) { 
		std::cout<< "error!" <<std::endl;
		goto exit;
	}



	for (int i=0; i<100000; i++) { //args instead of 5
        	Data data;
		takktile.getData(data);

		double sumx=0;
		double sumy=0;
		double sum=0;
      	for (int i = 0; i < 40; i++) {
               	sumx += (double)(data.pressures[i]-baseline[i])*arrayX[i];
                	sumy += (double)(data.pressures[i]-baseline[i])*arrayY[i];
                	sum += (double)data.pressures[i]-baseline[i];
        	}
        
		double CoMx = (double)(sumx)/(double)(sum);
		double CoMy = (double)(sumy)/(double)(sum);

		if (CoMx < 11) { std::cout<< "move motor away USB "<< CoMx <<std::endl; }
		if (CoMx > 30) { std::cout<< "move motor to USB "<< CoMx <<std::endl; }

	//	std::cout<< CoMx << " " << CoMy <<std::endl;
	}//time how long this takes
//	/for (int i = 0; i<100000000;i++); 
	/*for (int j = 0; j < 5; j++){
        Data raw;
        takktile.getData(raw);
        
        for (int i = 0; i < 40; i++) {
                std::cout<< raw.pressures[i]-baseline[i] << std::endl;
        }
        }*/
       
	exit:
        takktile.stopSampling(dc1);
        takktile.TakkClose();
        return 0;
};
   
