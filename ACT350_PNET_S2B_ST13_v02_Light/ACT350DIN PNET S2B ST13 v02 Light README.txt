ACT350 DIN Profinet Sample Program (Light Version)

PLC: Siemens S7-1200 
PLC Software: TIA Portal v13
Transmitter: ACT350 DIN PRNT
Transmitter firmware: ACT350 DIN PRNT_1.04.0000_4.3.0.5.mot
Transmiter GSDML: GSDML-V2.33-MT-ACT350 1P-20170822.xml

Programs:
1. Cyclic Program: 
	- Read-in all cyclical input data from ACT350
	- ACT350 Heartbeat monitoring
	- Command to test ACT350 byte order
	- Important PLC commands such as.. 
		Report Default Value, 
		Report Gross, 
		Report Tare, 
		Report Net weight,
		Tare, 
		Clear Tare, 
		Zero, 
		Preset Tare, 
		Write new Comparator values
	- Program to check ACT350 acknowledgement on every new PLC command

To simulate the program: 
- Online, go to Cyclic Input Data (DB3) to monitor all cyclical weight data
- Go to Cyclic Command (DB17) to toggel PLC commands.
 