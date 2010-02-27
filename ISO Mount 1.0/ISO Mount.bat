@echo off
set vcdmountLocation=%2
set isoLocation=%1
set driveNum=%3
set tmtLocation=%4
set help=""
set dcLocation=%5
set width=%6
set height=%7
set depth=%8
set refreshRate=%9

if [%1]==[] goto HELP

if [%5]==[] goto KeepRefresh

else goto ChangeRefresh

:ChangeRefresh
	%vcdmountLocation% /d=%driveNum% %isoLocation%
	%dcLocation% -quiet -width=%width% -height=%height% -depth=%depth% -refresh=%refreshRate% %tmtLocation%
	%vcdmountLocation% /u /d=%driveNum%
	exit /B 0
	
:KeepRefresh
	%vcdmountLocation% /d=%driveNum% %isoLocation%
	%tmtLocation%
	%vcdmountLocation% /u /d=%driveNum%
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