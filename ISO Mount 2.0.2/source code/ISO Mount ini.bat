REM Author: Brad Herring 
REM Email: brad@bherville.com
REM Website: www.bherville.com
REM Organization: Bherville
REM Copyright 2010 Brad Herring

REM This program is free software: you can redistribute it and/or modify
REM    it under the terms of the GNU General Public License as published by
REM    the Free Software Foundation, either version 3 of the License, or
REM    (at your option) any later version.

REM    This program is distributed in the hope that it will be useful,
REM    but WITHOUT ANY WARRANTY; without even the implied warranty of
REM    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM    GNU General Public License for more details.

REM    You should have received a copy of the GNU General Public License
REM    along with this program.  If not, see <http://www.gnu.org/licenses/>.



@echo off
set count=0
goto ArgLoop
 
set wait="ping 1.0.0.0 -n 1 -w 0"


REM Turns on echo, so that everything this script
REM 	does is echoed to the screen
:processDebug
   if %debug% == "on" set debug=on
   echo debug: %debug%
   @echo %debug%
   SHIFT 
   SHIFT
   goto ArgLoop

REM Main loop to proccess the command line 
REM 	arguments
:ArgLoop
   echo. Reading in arguments for %1 which is: %2!
   echo.
	
   if %1 EQU "-useIni" ( 
   set iniLocation=%2 
   set /a count=count+1
   set processIni=1
   )
   
   if %1 EQU "-debug" (
   set debug=%2
   goto processDebug
   )
   
   if %1 EQU "-iso" (
   set isoLocation=%2
   goto getFPS
   )
   
   if %1 EQU "-vcd" set vcdmountLocation=%2
		
   if %1 EQU "-driveNum" set driveNum=%2
		
   if %1 EQU "-bd" set tmtLocation=%2
		
   if %1 EQU "-driveLet" set driveLetter=%2
		
   if %1 EQU "-dc" set dcLocation=%2
		
   if %1 EQU "-refresh" set refreshRate=%2

   if %1 EQU "-width" set width=%2
   
   if %1 EQU "-height" set height=%2
   
   if %1 EQU "-depth" set depth=%2
   
   if %1 EQU "-wait" set wait=%2
   
	SHIFT 
	SHIFT
	if [%1]==[] goto Continue
	set /a count=count+1
	goto ArgLoop

	
	
	
REM If the user has, as an argument, the -useIni, then this 
REM 	lable will proccess the ini file.
REM	The path after the -useIni must be the containing directory
REM		of the .txt file named ISOMount.txt.
:iniLoop	
	
   for /F "tokens=1 delims=:" %%a in (%iniLocation%) do (
	set iniDriveLocale=%%a
   )
   
   %iniDriveLocale%:
   cd %iniLocation%

   for /F "usebackq tokens=1,2* delims=^=" %%a in (%iniLocation%) do (
   echo. Reading in arguments for %%a which is: %%b!
   echo.
   
   if "%%a" EQU "vcd" set vcdmountLocation=%%b
		
   if "%%a" EQU "driveNum" set driveNum=%%b
		
   if "%%a" EQU "bd" set tmtLocation=%%b
		
   if "%%a" EQU "driveLet" set driveLetter=%%b
		
   if "%%a" EQU "dc" set dcLocation=%%b
		
   if "%%a" EQU "refresh" set refreshRate=%%b

   if "%%a" EQU "width" set width=%%b
   
   if "%%a" EQU "height" set height=%%b
   
   if "%%a" EQU "depth" set depth=%%b
   
   if "%%a" EQU "wait" set wait=%%b
)

 set processIni=0

 
REM After either the ArgLoop or the iniProccess
REM		loop has completed this label will be 
REM		executed to determain the next label to 
REM		goto.
:Continue
	echo.
	if [%processIni%]==[1] goto iniLoop
	if [%count%]==[0] goto HELP
	if [%dcLocation%]==[] goto KeepRefresh

	goto ChangeRefresh


REM This uses the getFPS.vbs script, that is 
REM		included with in this iso mount ini.exe,
REM		that uses a regular expression to 
REM		extract the fps from the iso's file
REM		name so that it can be used to set the 
REM		refresh rate of the monitor.
:getFPS
	cscript //Nologo getFPS.vbs %isoLocation% > temp.txt
	set /p refreshAwn= < temp.txt
	del temp.txt
	SHIFT 
	SHIFT
	if [%1]==[] goto Continue
	set /a count=count+1
	goto ArgLoop
	

REM If the user has givin the location of 
REM		Display Changer then this label will
REM 	be excecuted.
:ChangeRefresh
	if not [%driveNum%]==[] (
		echo. Mounting ISO: %isoLocation% to drive: %driveNum%
			start /wait /i "Mount ISO" %vcdmountLocation% /d=%driveNum% %isoLocation%
	)
	
	if [%driveNum%]==[] (
	echo. Mounting ISO: %isoLocation% to drive: %driveLetter%
	start /wait /i "Mount ISO" %vcdmountLocation% /l=%driveLetter% %isoLocation%
	)
	
	ping 1.0.0.0 -n 1 -w %wait% >NUL
	
	REM If the file name of the iso contained a manually set frame rate
	REM		this will set it to the variable refreshRate that is used
	REM		by Display Changer to set the refresh rate of the moniter.
	if not [%refreshAwn%]==[] (
		set refreshRate=%refreshAwn%
	)
	
	if "%refreshRate%" EQU "24p" ( 
	echo.
	echo.
	echo. Running External Player using DisplayChanger 
	echo. 	to change refresh rate only.
	set refreshRate=24 
	%dcLocation% -force -refresh=%refreshRate% %tmtLocation% %driveLetter% 
	echo.
	echo.
	echo. Returning monitar to original refresh rate
	echo.
	echo.
	 )
	 
	if not [%height%]==[] ( 
	echo.
	echo.
	echo. Running External Player using DisplayChanger 
	echo. 	to change resolution and refresh rate to
	echo.	%width%x%height% and refresh rate: %refreshRate%.
	echo.
	echo. 
	%dcLocation% -force -width=%width% -height=%height% -refresh=%refreshRate% %tmtLocation% %driveLetter%)
	echo.
	echo.
	echo. Returning monitar to original resolution and refresh rate
	echo.	
	echo.
	echo. Unmounting ISO: %isoLocation% from drive: %driveLetter%
	
	if [%driveNum%]==[] (
		%vcdmountLocation% /u /l=%driveLetter%
	)
	
	if not [%driveNum%]==[] (
		%vcdmountLocation% /u /d=%driveNum%
	)
	
	echo.
	echo.
	exit /B 0
	
:KeepRefresh
	echo.
	echo.
	echo.
	echo.
	if [%driveNum%]==[] (
		echo. Mounting ISO: %isoLocation% to drive: %driveLetter%
		
		start /wait /i "Mount ISO" %vcdmountLocation% /l=%driveLetter% %isoLocation% 
	)
	
	if not [%driveNum%]==[] (
		echo. Mounting ISO: %isoLocation% to drive: %driveNum%
	
		start /wait /i "Mount ISO" %vcdmountLocation% /d=%driveNum% %isoLocation% 
	)
	ping 1.0.0.0 -n 1 -w %wait% >NUL
	%tmtLocation% %driveLetter%
	
	if [%driveNum%]==[] (
		%vcdmountLocation% /u /l=%driveLetter%
	)
	
	if not [%driveNum%]==[] (
		%vcdmountLocation% /u /d=%driveNum%
	)	
	
	echo.
	echo.
	echo. Unmounting ISO: %isoLocation% from drive: %driveLetter%
	echo.
	echo.
	exit /B 0
	
:HELP
	
	echo.--------------------------------------------
	echo. This batch script/exe was written by:
	echo.	Brad Herring of http://www.bherville.com
	echo.	and is freely avaliable to anyone 
	echo.	individual to use.
	echo.	For any corprate interaset please contact
	echo.	me at bher20@mac.com with the subject line
	echo.	Blu-ray mount app. Corp License or something
	echo.	similar.
	echo.
	echo. To use this program you must have 
	echo.	TotalMedia Theater or another bluray 
	echo.	playing software installed and SlySoft's 
	echo.	Virtual CloneDrive installed.
	echo.
	echo. You must also supply the following 
	echo.	arguments without the commas, 
	echo.	The iso's location with double quoates 
	echo.	surrounding it, 
	echo.	VirtualClone VCDmount.exe location 
	echo.	with double quoates surrounding it, 
	echo.	the drive number of one of the 
	echo.   Virtual CloneDrive's that you setup 
	echo.	in the setup menu (staring with drive 0),
	echo. 	and the bluray players location 
	echo.	with double quoates surrounding it.
	echo. 
	echo. An exmaple of this for the extenal 
	echo.	player commands with XBMC would be: 
	echo.	mount "{1}" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\Daemon.exe" 0 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe"
	echo.
	echo. Another normal exmaple of this: 
	echo.	mount "C:\Batman Begins.iso" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\Daemon.exe" 0 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe"
	echo. 
	echo. If along with mounting the iso and 
	echo. 	playing it you would like to change 
	echo. 	the resolution and refresh rate 
	echo. 	you will have to download and 
	echo.	install 12noon display changer 
	echo.	which is free @ 
	echo.	http://www.12noon.com, 
	echo. 	an example with xbmc would be:
	echo. 	mount "{1}" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\Daemon.exe" 0 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe" "F:\Program Files\Program Files (x86)\12noon Display Changer\dc64cmd.exe" 1866 1056 32 24
	echo. 	where "F:\Program Files\Program Files (x86)\12noon Display Changer\dc64cmd.exe" is the location of the exe for display changer,
	echo.	where 1866 1056 32 24 is the width, heigth, depth, and refresh rate respectivly.
	echo. --------------------------------------------
	echo.
	PAUSE
	exit /B 0