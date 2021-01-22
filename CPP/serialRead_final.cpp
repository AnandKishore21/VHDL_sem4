#include <iostream>
#include <ctime>
#include <windows.h>

using namespace std;

const int X_max = 10;  // number of maximum allowed people

int main()
{
    int comPort = 5;    // Enter the com port number here
    char ComP_num[9] = "\\\\.\\COM5";       //COM port address
    cout<<" Opening the COM port number : "<<comPort<<"\n";

    HANDLE serialHandle;
    serialHandle = CreateFileA(ComPorts, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);

    cout<<"---------CONNECTING TO SERIAL PORT-----------------"<<"\n";

    if (serialHandle == INVALID_HANDLE_VALUE)   //Checks for the connection
        cout << "Error in opening serial port\n";

    else
         cout<<"---------OPENING SERIAL PORT IS SUCCESSFULL-----------------"<<"\n";


    //SETTING THE BASIC SETTINGS FOR THE PORT
    DCB serialParams = { 0 };
    serialParams.DCBlength = sizeof(serialParams);
    GetCommState(serialHandle, &serialParams);
    serialParams.BaudRate = 9600;       //Setting the Boudrate 
    serialParams.ByteSize = 8;      //size of the data
    serialParams.StopBits = ONESTOPBIT;     //Setting to one stop bit 
    serialParams.Parity = NOPARITY;         //Setting to no parity bit 
    SetCommState(serialHandle, &serialParams);

    //SETTING THE TIMEOUTS 
    COMMTIMEOUTS timeout = { 0 };
    timeout.ReadIntervalTimeout = 50;
    timeout.ReadTotalTimeoutConstant = 50;
    timeout.ReadTotalTimeoutMultiplier = 50;
    timeout.WriteTotalTimeoutConstant = 50;
    timeout.WriteTotalTimeoutMultiplier = 10;
    SetCommTimeouts(serialHandle, &timeout);

    //RECEIVING THE DATA
    byte TempChar = 0; //Temporary character used for reading
    DWORD NoBytesRead;
    byte OLD = TempChar;

    while (true) {
        ReadFile(serialHandle,           //Object of the serial port
            &TempChar,       //the number of people transmitted from FPGA
            sizeof(TempChar),//Size of TempChar
            &NoBytesRead,    //Number of bytes read
            NULL);

        if (TempChar != OLD) {  //coparing the value with the previous one 
            
            if (OLD > TempChar) {
                cout << "Someone LEFT the room\n";
                cout <<" The current number of persons in room at "<< time(0) << "  is:  " << (int)TempChar << "\n";    
            }
            else if (OLD < TempChar) {
                cout << "Someone ENTERED the room \n";
                cout <<" The current number of persons in room at "<< time(0) << "  is:  " << (int)TempChar << "\n";
               
            }
            if (TempChar >= X_max) {
                cout << "Max. number of People is reached\n";
               
            }
        }
        OLD = TempChar;     //Save current number
    }

    CloseHandle(serialHandle);//Closing the Serial Port

    return EXIT_SUCCESS;
}