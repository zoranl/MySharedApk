@echo off

setlocal enabledelayedexpansion

set monitor_file[0]=D:\androidWorkspace\MyMath\app\build\outputs\apk\debug\com.zoranl.mymath-v1(1.0b)-debug.apk
set monitor_file[1]=D:\androidWorkspace\NfcApp\app\build\outputs\apk\debug\com.zoranl.nfcapp-v1(0.1b)-debug.apk
set monitor_file[2]=D:\androidWorkspace\MyApp\app\build\outputs\apk\debug\com.zoranl.myapp-v1(0.1a)-debug.apk
set monitor_file[3]=D:\androidWorkspace\BTapp\app\build\outputs\apk\debug\com.zoranl.btapp-v2(0.9b)-debug.apk
set monitor_file[4]=D:\androidWorkspace\WiFIApp\app\build\outputs\apk\debug\com.zoranl.wifiapp-v1(0.8)-debug.apk
set monitor_file[5]=D:\androidWorkspace\MySmartHome\app\build\outputs\apk\debug\com.zoranl.mysmarthome-v1(0.1)-debug.apk
set monitor_file[6]=D:\androidWorkspace\MyParkingMap\app\build\outputs\apk\debug\com.zoranl.myparkingmap-v1(0.1)-debug.apk

echo:
echo monitoring file: %monitor_file[0]% change
echo monitoring file: %monitor_file[1]% change
echo monitoring file: %monitor_file[2]% change
echo monitoring file: %monitor_file[3]% change
echo monitoring file: %monitor_file[4]% change
echo monitoring file: %monitor_file[5]% change
echo monitoring file: %monitor_file[6]% change
echo:

set lastT[0]=
set lastT[1]=
set lastT[2]=
set lastT[3]=
set lastT[4]=
set lastT[5]=
set lastT[6]=
:retry

for /L %%i in (0,1,6) do (
	for /f "delims=" %%a in ('powershell (Get-Item "'!monitor_file[%%i]!'"^).LastWriteTime') do (
		if not defined lastT[%%i] set lastT[%%i]="%%a"
		if not "%%a" == !lastT[%%i]! (
			echo "'!monitor_file[%%i]!'" was modified at %%a
			set lastT[%%i]="%%a"
			call :copy_file "!monitor_file[%%i]!"
	   )
	)
)

timeout /t 1 /nobreak >nul
goto retry
:copy_file
	copy /Y %~1 "H:\My Drive"
	echo:
	echo %date% %time%
	echo:
	for /L %%i in (0,1,6) do (
		echo waiting for file: !monitor_file[%%i]! change
	)
	rundll32.exe cmdext.dll,MessageBeepStub
goto retry