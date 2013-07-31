REM Pass this batch a number <n>, which is the number of minutes you wish to mine.
REM This can be done via mineall.bat; only mineall accepts a parameter of hours,
REM and converts that to minutes (*60) and passes that in turn to this.

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

killCheck.exe
TIMEOUT /T 7
killControllerProcesses.exe

EXIT