ECHO OFF
REM Pass this batch a number <n>, which is the number of minutes you wish to mine.
REM I would ordinarily do this via mineall.bat; pass mineall.bat <n> hours, and it will convert them to <x> minutes and call this with those calculated minutes.
REM See also notes for mineall.bat.

REM See the notes for the IF . . . IF IF ELSE block at the start of mineall.bat

IF [%1] EQU [] SET SECONDS=0 && GOTO BEGIN

SET SECONDS=%1

IF DEFINED 1 (
	IF %1 GTR 99999 (SET SECONDS=99999) ELSE (
		IF %1 LSS 1 SET SECONDS=0
		)
)

GOTO BEGIN

:BEGIN

REM The following spawns and closes a ridiculous number of windows, but it works, for the purpose of closing miners more gracefully (without momentarily hanging the video driver) where possible . . .
TIMEOUT /T %SECONDS%
ECHO ON
ECHO Terminating processes . . .
FOR /F "delims=" %%A IN (processSpawnList.txt) DO (
START _processCloser.bat %%A
)

EXIT