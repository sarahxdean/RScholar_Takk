#include "TakkTile.h"
#include <stdio.h>
#include <termio.h>
#include <unistd.h>
#include <dynamixel.h>
#include <termios.h>
#include <ostream>

#define DEFAULT_ID 2
#define MOTOR      2 
#define P_GOAL_POSITION_L 30
#define P_GOAL_POSITION_H 31
#define P_PRESENT_POSITION_L 36
#define P_PRESENT_POSITION_H 37
#define P_MOVING 46
#include <cstring>
#include <sstream>
//g++ -o executable TakkTile.cpp CoM.cpp -lusb-1.0 to compile
int main() {

        unsigned char dc1[2];
        unsigned char dc2[2];

	//dynamixel initialization stuff
	int baudnum = 1;
	int limits[2] = {0, 1024};
        int index = 0;
        int deviceIndex = 0;
       // int Moving, PresentPos;
        int PresentPos;
	int CommStatus;

	if( dxl_initialize(deviceIndex, baudnum) == 0 ) {
                printf( "Failed to open USB2Dynamixel!\n" );
	} 
	int turnValue = 512;

        TakkTile takktile = TakkTile();
        takktile.startSampling(200,dc2);
        
       	Data data;
	if(takktile.getData(data)==0){ 
		std::cout<< "error :(" <<std::endl; 
//		goto exit;
	}
	PresentPos = dxl_read_word( MOTOR, P_PRESENT_POSITION_L );

	//array to string
	char str[1000]={0};
	//strcat(str,"\t");	
	for (int i=0; i<data.length; i++) {
		char buffer[50];
		sprintf(buffer,"%d\t",data.pressures[i]);
		strcat(str, buffer);
	}
	for (int i=0; i<data.length; i++) {
		char buffer[50];
		sprintf(buffer,"%d\t",data.temperatures[i]);
		strcat(str, buffer);
	}
//	std::string str="";
//	for (int i=0; i<data.length; i++) {
//		std::stringstream ss;
//		ss << data.pressures[i];
//		str = str + ss.str(); + "\t";
//	}
//	std::cout<<str;
	printf("%s%d\n",str,PresentPos);
//	printf("%d\n",PresentPos);

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
	//time how long this takes
//	/for (int i = 0; i<100000000;i++); 
	
	exit: //note: doesn't quit very well
        takktile.stopSampling(dc1);
        takktile.TakkClose();
	dxl_terminate();
        return 0;
};
   
