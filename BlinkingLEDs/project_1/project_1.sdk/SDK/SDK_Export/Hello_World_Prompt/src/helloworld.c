/*
* Copyright (c) 2009 Xilinx, Inc. All rights reserved.
*
* Blink the MIO7 LED
*
*/

#include <stdio.h>
#include "platform.h"
#include "xil_types.h"
#include "xgpio.h"
#include "xtmrctr.h"
#include "xparameters.h"
#include "xgpiops.h"
#include "xil_io.h"
#include "xil_exception.h"
#include "xscugic.h"
static XGpioPs psGpioInstancePtr;
extern XGpioPs_Config XGpioPs_ConfigTable[XPAR_XGPIOPS_NUM_INSTANCES];
static int iPinNumber = 7; /*Led LD9 is connected to MIO pin 7*/
extern char inbyte(void);


int main()
{
	static XGpio GPIOInstance_Ptr;
	XGpioPs_Config*GpioConfigPtr;
	int xStatus;
	// Input Pin
	// Pin direction
	u32 uPinDirection = 0x1;
	init_platform();
	print("##### Application Starts #####\n\r");
	print("\r\n");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-1 :AXI GPIO Initialization
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	xStatus = XGpio_Initialize(&GPIOInstance_Ptr,XPAR_AXI_GPIO_0_DEVICE_ID);
	if(XST_SUCCESS != xStatus)
		print("GPIO INIT FAILED\n\r");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-2 :AXI GPIO Set the Direction
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XGpio_SetDataDirection(&GPIOInstance_Ptr, 1,1);
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-7 :PS GPIO Intialization
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	GpioConfigPtr = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
	if(GpioConfigPtr == NULL)
		return XST_FAILURE;
	xStatus = XGpioPs_CfgInitialize(&psGpioInstancePtr,
	GpioConfigPtr,
	GpioConfigPtr->BaseAddr);
	if(XST_SUCCESS != xStatus)
		print(" PS GPIO INIT FAILED \n\r");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-8 :PS GPIO pin setting to Output
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XGpioPs_SetDirectionPin(&psGpioInstancePtr, iPinNumber,uPinDirection);
	XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumber,1);
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-11 : Execute LEDs
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	int cont = 1;
	int Delay;
	int state = 1;
	while(cont < 100)
	{
		for(Delay=0; Delay<1000000; Delay++);
		XGpioPs_WritePin(&psGpioInstancePtr,iPinNumber,state);
		if(state == 0)
			state = 1;
		else
			state = 0;
		cont++;
	}
	print("\r\n");
	print("***********\r\n");
	print("BYE \r\n");
	print("***********\r\n");
	cleanup_platform();
	return 0;
}
