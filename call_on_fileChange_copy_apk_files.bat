@echo off

setlocal enabledelayedexpansion

set monitor_file1=D:\androidWorkspace\NfcApp\app\build\outputs\apk\debug\com.zoranl.nfcapp-v1(0.1b)-debug.apk
set monitor_file2=D:\androidWorkspace\MyApp\app\build\outputs\apk\debug\com.zoranl.myapp-v1(0.1a)-debug.apk
set monitor_file3=D:\androidWorkspace\BTapp\app\build\outputs\apk\debug\com.zoranl.btapp-v2(0.9b)-debug.apk
set monitor_file4=D:\androidWorkspace\WiFIApp\app\build\outputs\apk\debug\com.zoranl.wifiapp-v1(0.8)-debug.apk

set "lastT1="
set "lastT2="
set "lastT3="
set "lastT4="
:retry
for /f "delims=" %%a in ('powershell (Get-Item "'%monitor_file1%'"^).LastWriteTime') do (
    if not defined lastT1 set "lastT1=%%a"
    if not "%%a" == "!lastT1!" (
        echo "'%monitor_file1%'" was modified at %%a
        set "lastT1=%%a"
		copy "%monitor_file1%" "H:\My Drive"
		goto print_reminder
   )
)

for /f "delims=" %%a in ('powershell (Get-Item "'%monitor_file2%'"^).LastWriteTime') do (
    if not defined lastT2 set "lastT2=%%a"
    if not "%%a" == "!lastT2!" (
        echo "'%monitor_file2%'" was modified at %%a
        set "lastT2=%%a"
		copy "%monitor_file2%" "H:\My Drive"
		goto print_reminder
   )
)
for /f "delims=" %%a in ('powershell (Get-Item "'%monitor_file3%'"^).LastWriteTime') do (
    if not defined lastT3 set "lastT3=%%a"
    if not "%%a" == "!lastT3!" (
        echo "'%monitor_file3%'" was modified at %%a
        set "lastT3=%%a"
		copy "%monitor_file3%" "H:\My Drive"
		goto print_reminder
   )
)
for /f "delims=" %%a in ('powershell (Get-Item "'%monitor_file4%'"^).LastWriteTime') do (
    if not defined lastT4 set "lastT4=%%a"
    if not "%%a" == "!lastT4!" (
        echo "'%monitor_file4%'" was modified at %%a
        set "lastT4=%%a"
		copy "%monitor_file4%" "H:\My Drive"
		goto print_reminder
   )
)

timeout /t 1 /nobreak >nul
goto retry
:print_reminder
	echo:
	echo waiting for file: %monitor_file1% change
	echo waiting for file: %monitor_file2% change
	echo waiting for file: %monitor_file3% change
	echo waiting for file: %monitor_file4% change
	rundll32.exe cmdext.dll,MessageBeepStub
goto retry