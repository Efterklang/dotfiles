@ECHO OFF
:BEGIN
ECHO.
ECHO.
ECHO ^|----------------------Powering Off-------------------------^|
ECHO ^|   ^>Press 1 to shutdown the computer.                      ^|
ECHO ^|   ^>Press 2 to restart the computer.                       ^|
ECHO ^|   ^>Press Q to quit.                                       ^|
ECHO ^|-----------------------------------------------------------^|
ECHO.
CHOICE /N /C 12"q" /M ">Input: "%1
IF ERRORLEVEL ==3 GOTO QUIT
IF ERRORLEVEL ==2 GOTO RESTART
IF ERRORLEVEL ==1 GOTO SHUTDOWN

GOTO QUIT
:SHUTDOWN
shutdown.exe /f /p
GOTO QUIT
:RESTART
shutdown.exe /r
:QUIT
exit