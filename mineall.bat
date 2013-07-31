ECHO OFF
REM pass this batch a variable <n> which is the number of hours to mine (maximum 27). If you pass nothing, it defaults to one hour. If you pass it an out-of-range or indecipherable value, it will assume a maxium or minimum value.

REM ================STARTUP DELAY=================
REM if you set this to run at user login or system startup, you may wish to have it delay four minutes before execution (to allow the system and other processes to load up first), by uncommenting the following line:
TIMEOUT /T 240

REM dang non-value check solution found here: http://stackoverflow.com/questions/731332/check-for-null-variable-in-windows-batch

IF [%1] EQU [] SET HOURS=1 && ECHO No value for hours passed to script. I'll assume a value of 1. && GOTO BEGIN

REM Set this regardless of what %1 may be; if it needs correcting, the below above IF or the below IF IF ELSE block will correct it. If it doesn't need correcting, it will remain as-is.
SET HOURS=%1

IF DEFINED 1 (
	IF %1 GTR 27 (SET HOURS=27 && ECHO Hours %1 passed to script are too many or indecipherable. I'll assume the maximum possible, which is 27) ELSE (
		IF %1 LSS 1 SET HOURS=1 && ECHO I either can't decipher the value passed to the script or cannot mine %1 hours backward through time, as awesome as that would be. I'll assume a value of 1.
		)
)

GOTO BEGIN

:BEGIN
SET /A MINS=%HOURS%*3600
ECHO I will mine for %HOURS% hours, or %MINS% minutes . . .

REM GLOBAL VARIABLE: WORKING DIRECTORY
SET CURRDIR=%CD%

REM ==================TERMINATION=================
REM Comment out the following line if you want this to run virtually forever.
REM START /C delayed-killmine.bat %MINS%

REM =================EXECUTE MINERS===============

REM ===================SCRYPT=====================
REM ===UNCOMMENT AND COMMENT PER DESIRED MINING===

CD %CURRDIR%\cpuminer
START mineScrypt.bat %HOURS%
REM START %CURRDIR%\cgminer\mineScryptCGMiner.bat

REM ===================GPU-BASED===================

CD %CURRDIR%\cudaminer
START mineCudaminer.bat

ECHO The console that hosts this batch is no longer needed. It will exit in seven seconds.
TIMEOUT /T 7
EXIT