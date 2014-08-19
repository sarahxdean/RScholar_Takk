#include "TakkTile.h"
#include <time.h> 
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
	double CoMavg;
	double sumns = 0;
        unsigned char dc1[2];
        unsigned char dc2[2];
        double arrayX[] =  {-19.7398362542710,-22.0842752737594,-19.5587619130889,-22.2504311216853,-19.7475822244161,-13.6144904808494,-15.9750828754188,-13.8606549896841,-16.1988882916664,-13.7348678347053,-7.63878891901859,-10.1413459225566,-7.56958430540076,-10.1724359863076,-7.86862558649712,-1.93810849293437,-4.20817044311362,-1.92157040023101,-4.29307523219895,-2.02678051235801,4.11183495973308,1.57713931157227,3.83027476396957,1.56427701821819,3.91337901024631,9.77108172011982,7.34061039793151,9.79944515587702,7.39342175567596,9.70463332720993,15.7649460741183,13.0789105480106,15.6221043421840,13.0764765129857,15.4708110553768,21.5010417025109,19.1576200443065,21.5443774995847,19.0990197726162,21.2219520879138};


//{-20.0480,-22.4280,-20.0480,-22.4280,-20.0480,-14.0480,-16.4280,-14.0480,-16.4280,-14.0480,-8.0480,-10.4280,-8.0480,-10.4280,-8.0480,-2.0480,-4.4280,-2.0480,-4.4280,-2.0480,3.9520,1.5720,3.9520,1.5720,3.9520,9.9520,7.5720,9.9520,7.5720,9.9520,15.9520,13.5720,15.9520,13.5720,15.9520,21.9520,19.5720,21.9520, 19.5720, 21.9520};

// {4.76, 2.38, 4.76, 2.38, 4.76, 10.76, 8.38, 10.76, 8.38, 10.76, 16.76, 14.38, 16.76, 14.38, 16.76, 22.76,20.38,22.76, 20.38, 22.76,28.76, 26.38,28.76, 26.38, 28.76, 34.76, 32.38, 34.76, 32.38, 34.76, 40.76, 38.38, 40.76, 38.38, 40.76, 46.76, 44.38, 46.76, 44.38, 46.76};
	//double arrayY[] = { 12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12,12,6,0,-6,-12};

//{27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3, 27, 21, 15, 9, 3};
	double weight[] = {0,3.18670526713336,0.018059566484752,1.63345913028369,0.0114212539311614,2.34452064857763,0,0,0,1.02645954493606,1.30012156939981,22.5082453832537,4.53751311138122,4.52580427655027,0.224489995179782,16.2286113839077,4.90649488754318,52.9630665669678,45.5281656311407,2.46431944772075,19.2988688989141,0,0,133.309778066995,0,9.37889123087710,0.0788583024504119,0,8.26237616137681,8.28957869046568,11.7041987402650,0,0,0,2.31098974107709,0,3.47376057893762,1.13058421213262,0,0.449329478231110}; 
	//dynamixel initialization stuff
	int baudnum = 1;
	int limits[2] = {0, 1024};
        int index = 0;
        int deviceIndex = 0;
        int Moving, PresentPos;
        int CommStatus;
	int ns = 10;
	double CoMhist[ns];
	if( dxl_initialize(deviceIndex, baudnum) == 0 ) {
                printf( "Failed to open USB2Dynamixel!\n" );
	} 
	int turnValue = 512;
//        dxl_write_word( MOTOR, 32, 50); //sets the speed for turning
//        dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue );


        TakkTile takktile = TakkTile();
        takktile.startSampling(200,dc2);
        
	double baseline[40];
	std::cout<< "calibrating..." <<std::endl;
	if(takktile.calibrate(baseline,10)==0) { 
		std::cout<< "error!" <<std::endl;
		goto exit;
	}


	for (int i=0; i<100000; i++) { //args instead of 5
auto begin = std::chrono::high_resolution_clock::now();


		if (i > ns) sumns = sumns - CoMhist[i%ns];
		Data data;
		if(takktile.getData(data)==0){ std::cout<< "error :(" <<std::endl; }
		
		double sumx=0;
//		double sumy=0;
		double sum=0;
      		for (int j = 0; j < 40; j++) {//change to 40 for array
               		sumx += (double)(data.pressures[j]-baseline[j])*arrayX[j]*weight[j];
  //              	sumy += (double)(data.pressures[i]-baseline[i])*arrayY[i]*weight[i];
                	sum += (double)(data.pressures[j]-baseline[j])*weight[j];
        	}
        
		double CoMx = (double)(sumx)/(double)(sum);
//		double CoMy = (double)(sumy)/(double)(sum);
		CoMhist[i % ns] = CoMx;
		sumns = sumns + CoMhist[i%ns];
		CoMavg = sumns / ns;
		if (i > 500){
		std::cout<<CoMx<<"\t"<<CoMavg<<std::endl;

		if(turnValue > 700) {
			turnValue = 700;}
		else if (turnValue < 350) { turnValue = 350;}
		else turnValue = turnValue + (int)(CoMavg/2);//plus for arry
		std::cout<<turnValue<<std::endl;
		}

//		dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue ); 

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
auto end = std::chrono::high_resolution_clock::now();
std::cout << std::chrono::duration_cast<std::chrono::nanoseconds>(end-begin).count() << "ns" << std::endl;	
}//time how long this takes
//	/for (int i = 0; i<100000000;i++); 
	
	exit: //note: doesn't quit very well
        takktile.stopSampling(dc1);
        takktile.TakkClose();
	dxl_terminate();
        return 0;
};
   
