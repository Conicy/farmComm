ECHO OFF
REM pass this batch a variable <n> which is the number of hours to mine (maximum 27). If you pass nothing, it defaults to one hour. If you pass it an out-of-range or indecipherable value, it will assume a maxium or minimum value.

REM dang non-value check solution found here: http://stackoverflow.com/questions/731332/check-for-null-variable-in-windows-batch

REM WARNING: a potential drawback of this script is that it assumes only one call of mineall.bat has been made (in the system). Likewise the batches which it invokes with START (as they also call logPID.bat). I'm not going to design around that; just make sure that doesn't happen!

REM Delete console process ID log so that the following batch will simply write the proper value to it.
REM DEL PIDs.txt
REM DEL cpuminer\PIDs.txt

REM CALL logPID.bat

IF [%1] EQU [] SET HOURS=1 && ECHO No value for hours passed to script. I'll assume a value of 1. && GOTO BEGIN

REM Set this regardless of what %1 may be; if it needs correcting, the below above IF or the below IF IF ELSE block will correct it. If it doesn't need correcting, it will remain as-is.
SET HOURS=%1

IF DEFINED 1 (
	IF %1 GTR 27 (SET HOURS=27 && ECHO Hours %1 passed to script are too many or indecipherable. I'll assume the maximum possible, which is 27) ELSE (
		IF %1 LSS 1 SET HOURS=1 && ECHO I either can't decipher the value passed to the script or cannot mine %1 hours backward through time, as awesome as that would be. I'll assume a value of 1.
		)
)

GOTO BEGIN

REM Rewrite this to not give any message about a timer for mining if no variable was passed to the script.
:BEGIN
SET /A MINS=%HOURS%*3600
ECHO Unless this batch is modified to not mine with a time limit, I will mine for %HOURS% hours, or %MINS% minutes.

REM IF LAUNCHING WALLETS AT BOOT:
REM TIMEOUT 660
REM OTHERWISE:
TIMEOUT 90

REM If you wish to mine effectively forever, comment out this next line, and also see the comments in the batches that follow it (to change them if necessary to also run forever.)
REM START delayed-killmine.bat %MINS%

REM For a setup with one core ~speed 2kh/s, comment out the following three lines--all it does is leech a little more kh/s more than that from the GPUs.
CD cpuminer
START mineScrypt.bat
CD ..

REM NOTE: _mineCGminer.bat may be set to disable one device for use in conjunction with solo mining; re-enable both devices in that batch if only pool mining (and then comment out the above line)! -- and/or alter the solo mining batch used device(s)!
	
	REM cgminer option; only uncomment any one of the following GPU miner command options . . .
CD cgminer
START _mineCGminer.bat

REM START _mineFlorinCoinSolo.bat

CD ..

	REM Phoenix option
REM CD phoenix
REM START "MINING WITH PHOENIX MINER" phoenixMine.bat

REM ECHO The console that hosts this batch is no longer needed. It will exit in seven seconds.
REM TIMEOUT /T 7

REM For perpetual mining, I suggest uncommenting the following line, to reboot the computer every 6 hours.

ECHO WILL INITIATE REBOOT AFTER SIX HOUR (21,600 SECOND) COUNTDOWN . . .
TIMEOUT /T 21600
START killWallets.bat
TIMEOUT /T 30
SHUTDOWN /T 0 /R /F

REM EXIT