#include <stdio.h>
#include <termio.h>
#include <unistd.h>
#include <dynamixel.h>
#include <termios.h>

int getch(void)
{
  int ch;
  struct termios oldt;
  struct termios newt;
  tcgetattr(STDIN_FILENO, &oldt); /*store old settings */
  newt = oldt; /* copy old settings to new settings */
  newt.c_lflag &= ~(ICANON | ECHO); /* make one change to old settings in new settings */
  tcsetattr(STDIN_FILENO, TCSANOW, &newt); /*apply the new settings immediatly */
  ch = getchar(); /* standard getchar call */
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt); /*reapply the old settings */
  return ch; /*return received char */
}

// Control table address
#define P_GOAL_POSITION_L 30
#define P_GOAL_POSITION_H 31
#define P_PRESENT_POSITION_L 36
#define P_PRESENT_POSITION_H 37
#define P_MOVING 46

/** Motor IDs of all three motors motors */
#define MOTOR	   3 

// Id of the currently connected dynamixel
#define DEFAULT_BAUDNUM 1 // 1Mbps
#define DEFAULT_ID 3
void PrintCommStatus(int CommStatus);
void PrintErrorCode(void);

int main()
{
        int baudnum = 1;
        /*
         * One digit of motor represents 0.3515625 degrees.
         * One degree represents 2.8444444 values of motor turn
         */
        int limits[2] = {0, 1024};
        int index = 0;
        int deviceIndex = 0;
        int Moving, PresentPos;
        int CommStatus;

        printf( "\n\nRead/Write position\n\n" );
        ///////// Open USB2Dynamixel ////////////
        if( dxl_initialize(deviceIndex, baudnum) == 0 )
        {
                printf( "Failed to open USB2Dynamixel!\n" );
                printf( "Press Enter key to terminate...\n" );
                getchar();
                return 0;
        }
        else
                printf( "Succeed to open USB2Dynamixel!\n" );
        int turnValue = 512;
	dxl_write_word( MOTOR, 32, 100); //sets the speed for turning
        dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue );

        while(1)
        {
                printf( "Press Enter key to continue!(press ESC and Enter to quit)\n" );
                char c = getch();
                if(c == 0x1b)
                     break;
                if(c == 'a') //eventually here i will check CoM instead
                    turnValue-=3;
                if(c == 'd')
                    turnValue+=3;

                 printf("Turn value - %d\n", turnValue);
                // Write goal position
		
		
		if(turnValue >= limits[0] && turnValue <= limits[1]) 
		{ 
			dxl_write_word( MOTOR, P_GOAL_POSITION_L, turnValue );
                }

		do
                {
                        // Read present position
                        PresentPos = dxl_read_word( MOTOR, P_PRESENT_POSITION_L );
                        CommStatus = dxl_get_result();

                        if( CommStatus == COMM_RXSUCCESS )
                        {
                               // printf( "%d   %d\n",turnValue, PresentPos );
                                PrintErrorCode();
                        }
                        else
                        {
                                PrintCommStatus(CommStatus);
				break;
                        }

                        // Check moving done
                        Moving = dxl_read_byte( MOTOR, P_MOVING );
                        CommStatus = dxl_get_result();
                        if( CommStatus == COMM_RXSUCCESS )
                        {

                                PrintErrorCode();
                        }
                        else
                        {
                                PrintCommStatus(CommStatus);
                                break;
                        }
                }while(Moving == 1);
        	//
                PresentPos = dxl_read_word( MOTOR, P_PRESENT_POSITION_L );
		printf("%d\n",PresentPos );
	}

        // Close device
        dxl_terminate();
        printf( "Press Enter key to terminate...\n" );
        getchar();
        return 0;
}

/** Printing communication result */
void PrintCommStatus(int CommStatus)
{
        switch(CommStatus)
        {
        case COMM_TXFAIL:
                printf("COMM_TXFAIL: Failed transmit instruction packet!\n");
                break;

        case COMM_TXERROR:
                printf("COMM_TXERROR: Incorrect instruction packet!\n");
                break;

        case COMM_RXFAIL:
                printf("COMM_RXFAIL: Failed get status packet from device!\n");
                break;

        case COMM_RXWAITING:
                printf("COMM_RXWAITING: Now recieving status packet!\n");
                break;

        case COMM_RXTIMEOUT:
                printf("COMM_RXTIMEOUT: There is no status packet!\n");
                break;

        case COMM_RXCORRUPT:
                printf("COMM_RXCORRUPT: Incorrect status packet!\n");
                break;

        default:
                printf("This is unknown error code!\n");
                break;
        }
}

/** Print error bit of status packet */
void PrintErrorCode()
{
        if(dxl_get_rxpacket_error(ERRBIT_VOLTAGE) == 1)
                printf("Input voltage error!\n");

        if(dxl_get_rxpacket_error(ERRBIT_ANGLE) == 1)
                printf("Angle limit error!\n");

        if(dxl_get_rxpacket_error(ERRBIT_OVERHEAT) == 1)
                printf("Overheat error!\n");

        if(dxl_get_rxpacket_error(ERRBIT_RANGE) == 1)
                printf("Out of range error!\n");

        if(dxl_get_rxpacket_error(ERRBIT_CHECKSUM) == 1)
                printf("Checksum error!\n");

        if(dxl_get_rxpacket_error(ERRBIT_OVERLOAD) == 1)
                printf("Overload error!\n");

        if(dxl_get_rxpacket_error(ERRBIT_INSTRUCTION) == 1)
                printf("Instruction code error!\n");
}


