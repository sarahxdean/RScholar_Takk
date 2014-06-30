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
        double arrayX[] = {4.76, 2.38, 4.76, 2.38, 4.76, 10.76, 8.38, 10.76, 8.38, 10.76, 16.76, 14.38, 16.76, 14.38, 16.76, 22.76,20.38,22.76, 20.38, 22.76,28.76, 26.38,28.76, 26.38, 28.76, 34.76, 32.38, 34.76, 32.38, 34.76, 40.76, 38.38, 40.76, 38.38, 40.76, 46.76, 44.38, 46.76, 44.38, 46.76};
	double arrayY[] = {27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3};

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

	bool washigh1, washigh2, waslow1, waslow2;

	for (int i=0; i<100000; i++) { //args instead of 5
        	Data data;
		if(takktile.getData(data)==0){ std::cout<< "error :(" <<std::endl; }

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

		if (CoMx < 16) {
			waslow1 = false;
			waslow2 = false;
			std::cout<< "move motor away USB "<< CoMx <<std::endl;
			if((turnValue >= limits[0]) && washigh1 && washigh2) turnValue -= 1;
			else if (washigh1) washigh2 = true;
			else washigh1 = true;
		} else {
			if (CoMx > 25) { 
				washigh1 = false;
				washigh2 = false;
				std::cout<< "move motor to USB "<< CoMx <<std::endl; 
				if((turnValue <= limits[1]) && waslow1 && waslow2) turnValue += 1;
				else if (waslow1) waslow2 = true;
				else waslow1 = true;
			} else {
				washigh1 = false;
				washigh2 = false;
				waslow1 = false;
				waslow2 = false;
			}
		}

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
   