#include "TakkTile.h"
#include <stdio.h>
#include <termio.h>
#include <unistd.h>
#include <dynamixel.h>
#include <termios.h>

#define DEFAULT_ID 2
#define MOTOR      2 
#define P_GOAL_POSITION_L 30
#define P_GOAL_POSITION_H 31
#define P_PRESENT_POSITION_L 36
#define P_PRESENT_POSITION_H 37
#define P_MOVING 46


//g++ -o CoMs.o TakkTile.cpp strip_CoMcontrol.cpp -lusb-1.0 -ldxl -lm

int main() {
	double CoMavg;
	double sumns = 0;
        unsigned char dc1[2];
        unsigned char dc2[2];
        double arrayX[] =  { -31.6190, -31.9288, -32.0040, -32.3204, -32.5042, -16.5338, -16.5530, -16.7062, -16.7277, -16.7474, 0.2290,0.1433,-0.1915,-0.4104,-0.6338,16.3727,16.4583,16.5425,16.6221,16.7002,32.8839,32.6383,32.3759,32.1024, 31.8116};

//{-20.0480,-22.4280,-20.0480,-22.4280,-20.0480,-14.0480,-16.4280,-14.0480,-16.4280,-14.0480,-8.0480,-10.4280,-8.0480,-10.4280,-8.0480,-2.0480,-4.4280,-2.0480,-4.4280,-2.0480,3.9520,1.5720,3.9520,1.5720,3.9520,9.9520,7.5720,9.9520,7.5720,9.9520,15.9520,13.5720,15.9520,13.5720,15.9520,21.9520,19.5720,21.9520, 19.5720, 21.9520};

// {4.76, 2.38, 4.76, 2.38, 4.76, 10.76, 8.38, 10.76, 8.38, 10.76, 16.76, 14.38, 16.76, 14.38, 16.76, 22.76,20.38,22.76, 20.38, 22.76,28.76, 26.38,28.76, 26.38, 28.76, 34.76, 32.38, 34.76, 32.38, 34.76, 40.76, 38.38, 40.76, 38.38, 40.76, 46.76, 44.38, 46.76, 44.38, 46.76};
	//double arrayY[] = { 12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12};

//{27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3};
	double weight[] = {0.5241, 2.2774, 0, 0.3845, 1.4690, 0.0059, 0,3.7938, 0,2.6875,323.1828,238.0930,0,0,0,7.7829,0,1.6664,0,0,0.8394,0.8289,0,1.2467,0.5905};
	//dynamixel initialization stuff
	int baudnum = 1;
	int limits[2] = {0, 1024};
        int index = 0;
        int deviceIndex = 0;
        int Moving, PresentPos;
        int CommStatus;
	int ns = 20;
	double CoMhist[ns];
	if( dxl_initialize(deviceIndex, baudnum) == 0 ) {
                printf( "Failed to open USB2Dynamixel!\n" );
	} 
	int turnValue = 512;
        dxl_write_word( MOTOR, 32, 75); //sets the speed for turning
        dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue );


        TakkTile takktile = TakkTile();
        takktile.startSampling(200,dc2);
        
	double baseline[40];
	std::cout<< "calibrating..." <<std::endl;
	if(takktile.calibrate(baseline,10)==0) { 
		std::cout<< "error!" <<std::endl;
		goto exit;
	}

	std::cout<<"done calibrating"<<std::endl;
	for (int i=0; i<100000; i++) { //args instead of 5
        	if (i > ns) sumns = sumns - CoMhist[i%ns];
		Data data;
		if(takktile.getData(data)==0){ std::cout<< "error :(" <<std::endl; }
		
		double sumx=0;
//		double sumy=0;
		double sum=0;
      		for (int j = 0; j < 25; j++) {//change to 40 for array
               		sumx += (double)(data.pressures[j]-baseline[j])*arrayX[j]*weight[j];
  //              	sumy += (double)(data.pressures[i]-baseline[i])*arrayY[i]*weight[i];
                	sum += (double)(data.pressures[j]-baseline[j])*weight[j];
        	}
        
		double CoMx = (double)(sumx)/(double)(sum);
//		double CoMy = (double)(sumy)/(double)(sum);
		CoMhist[i % ns] = CoMx;
		sumns = sumns + CoMhist[i%ns];
		CoMavg = (sumns / ns) + 1;
		if (i > 500){
		Moving = dxl_read_byte( DEFAULT_ID, P_MOVING );
		std::cout<<CoMx<<","<<CoMavg<<","<<turnValue<<"; ";

		//if (Moving){}
		//else{
		if(turnValue > 700) {
			turnValue = 700;}
		else if (turnValue < 350) { turnValue = 350;}
		else turnValue = turnValue - (int)(CoMavg/2);//plus for arry
		//std::cout<<turnValue<<std::endl;
		}

		dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue ); 
		//}
	//	do {
                        // Read present position
                        //PresentPos = dxl_read_word( MOTOR, P_PRESENT_POSITION_L );
                        //CommStatus = dxl_get_result();

                        //if( CommStatus == COMM_RXSUCCESS ) { // printf( "%d   %d\n",turnValue, PresentPos );
                                //PrintErrorCode();
                       // } else {
                                //PrintCommStatus(CommStatus);
                         //       std::cout<< "comm error" <<std::endl;
			//	break;
                        //}

                        // Check moving done
          //              Moving = dxl_read_byte( MOTOR, P_MOVING );
                        //CommStatus = dxl_get_result();
                        //if( CommStatus == COMM_RXSUCCESS ) {
                        //        //PrintErrorCode();
                        //} else {
                        //        std::cout<< "comm error 2" <<std::endl;
				//PrintCommStatus(CommStatus);
                        //        break;
                        //}
        //        } while(Moving == 1);
	//	PresentPos = dxl_read_word( MOTOR, P_PRESENT_POSITION_L );



//		std::cout<< CoMx << " " << CoMy <<std::endl;
	}//time how long this takes
//	/for (int i = 0; i<100000000;i++); 
	
	exit: //note: doesn't quit very well
        takktile.stopSampling(dc1);
        takktile.TakkClose();
	dxl_terminate();
        return 0;
};
   
