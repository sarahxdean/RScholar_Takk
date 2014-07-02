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


//g++ -o executable TakkTile.cpp CoM.cpp -lusb-1.0 to compile
int main() {

        unsigned char dc1[2];
        unsigned char dc2[2];
        double arrayX[] = {-20.0480,-22.4280,-20.0480,-22.4280,-20.0480,-14.0480,-16.4280,-14.0480,-16.4280,-14.0480,-8.0480,-10.4280,-8.0480,-10.4280,-8.0480,-2.0480,-4.4280,-2.0480,-4.4280,-2.0480,3.9520,1.5720,3.9520,1.5720,3.9520,9.9520,7.5720,9.9520,7.5720,9.9520,15.9520,13.5720,15.9520,13.5720,15.9520,21.9520,19.5720,21.9520, 19.5720, 21.9520};

// {4.76, 2.38, 4.76, 2.38, 4.76, 10.76, 8.38, 10.76, 8.38, 10.76, 16.76, 14.38, 16.76, 14.38, 16.76, 22.76,20.38,22.76, 20.38, 22.76,28.76, 26.38,28.76, 26.38, 28.76, 34.76, 32.38, 34.76, 32.38, 34.76, 40.76, 38.38, 40.76, 38.38, 40.76, 46.76, 44.38, 46.76, 44.38, 46.76};
	double arrayY[] = { 12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12};

//{27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3};
	double weight[] = {0.0013, -0.0028, -0.0087, -0.0045, -0.0004, -0.0077, 0.0045, 0.0107, 0.0001, -0.0039, 0.0044, 0.0166, 0.0188, -0.0016, 0.0013, -0.0057, 0.0059, -0.0937,-0.0076, 0.0063, -0.0158, 0.0059, -0.0056, 0.0267, -0.0095, 0.0070, -0.0015, 0.0176, 0.0212,0.0027, 0.0057, 0.0013, -0.0101, 0.0150, -0.0105, -0.0041, -0.0022, -0.0026, -0.0030, 0.0012};


	//dynamixel initialization stuff
	int baudnum = 1;
	int limits[2] = {0, 1024};
        int index = 0;
        int deviceIndex = 0;
        int Moving, PresentPos;
        int CommStatus;

	if( dxl_initialize(deviceIndex, baudnum) == 0 ) {
                printf( "Failed to open USB2Dynamixel!\n" );
	} 
	int turnValue = 512;
        dxl_write_word( MOTOR, 32, 100); //sets the speed for turning
        dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue );


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
		if(takktile.getData(data)==0){ std::cout<< "error :(" <<std::endl; }

		double sumx=0;
		double sumy=0;
		double sum=0;
      		for (int i = 0; i < 40; i++) {
               		sumx += (double)(data.pressures[i]-baseline[i])*arrayX[i]*weight[i];
                	sumy += (double)(data.pressures[i]-baseline[i])*arrayY[i]*weight[i];
                	sum += (double)(data.pressures[i]-baseline[i])*weight[i];
        	}
        
		double CoMx = (double)(sumx)/(double)(sum);
		double CoMy = (double)(sumy)/(double)(sum);

//		std::cout<<CoMx<<"\t"<<CoMy<<std::endl;

		turnValue = turnValue + CoMx/5;

		dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue ); 

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
   
