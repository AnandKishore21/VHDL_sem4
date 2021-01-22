#include <iostream>
#include <ctime>
#include <windows.h>

using namespace std;

const int maxPepole = 10;

int main()
{
    // Get COM-Port
    char ComPortNum = '9';
    char ComPorts[9] = "\\\\.\\COM5";

    cout << "Enter COM-PORT Number (standard \"COM5\"): ";
    cin >> ComPortNum;
    cout << "\n";

    if ((int)ComPortNum < 48 || (int)ComPortNum > 57)
        ComPortNum = '5';

    ComPorts[7] = ComPortNum;

    cout << "Opening Port: " << ComPorts << "\n";

    // Open serial port
    HANDLE serialHandle;
    serialHandle = CreateFileA(ComPorts, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);

    cout << "--------------------------\n";

    if (serialHandle == INVALID_HANDLE_VALUE)   //Check Connection
        cout << "Error in opening serial port\n";
    else
        cout << "opening serial port successful\n";

    cout << "--------------------------\n\n";

    // Do some basic settings
    DCB serialParams = { 0 };
    serialParams.DCBlength = sizeof(serialParams);

    GetCommState(serialHandle, &serialParams);
    serialParams.BaudRate = 9600;
    serialParams.ByteSize = 8;
    serialParams.StopBits = ONESTOPBIT;
    serialParams.Parity = NOPARITY;
    SetCommState(serialHandle, &serialParams);

    // Set timeouts
    COMMTIMEOUTS timeout = { 0 };
    timeout.ReadIntervalTimeout = 50;
    timeout.ReadTotalTimeoutConstant = 50;
    timeout.ReadTotalTimeoutMultiplier = 50;
    timeout.WriteTotalTimeoutConstant = 50;
    timeout.WriteTotalTimeoutMultiplier = 10;

    SetCommTimeouts(serialHandle, &timeout);

    // Receiving Data
    byte TempChar = 0; //Temporary character used for reading
    DWORD NoBytesRead;
    byte OLD = TempChar;

    while (true) {
        ReadFile(serialHandle,           //Handle of the Serial port
            &TempChar,       //Temporary character
            sizeof(TempChar),//Size of TempChar
            &NoBytesRead,    //Number of bytes read
            NULL);

        if (TempChar != OLD) {  //Compare Current Value with Old one
            cout << time(0) << " " << (int)TempChar << "\n";
            if (OLD > TempChar) {
                cout << "Someone LEFT\n";
                
            }
            else if (OLD < TempChar) {
                cout << "Someone ENTERED\n";
               
            }
            if (TempChar >= maxPepole) {
                cout << "Max. number of People is reached\n";
               
            }
        }
        OLD = TempChar;     //Save current number
    }

    CloseHandle(serialHandle);//Closing the Serial Port

    return EXIT_SUCCESS;
}