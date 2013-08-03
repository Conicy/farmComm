ECHO OFF
REM You may probably need to run this batch at an elevated command prompt. It will remove any/all auto-startup configurations of farmComm. Read the comment on the next line, please.

REM This batch terminates any processes that might be running (and which may prevent installation), and removes and previous startup/setup items which may be in place from previous installs. It will probably throw errors about not being able to terminate processes that weren't found, or delete tasks that don't exist (etc). That's fine; it won't do any harm. Because if any of the processes and tasks etc. are running or do exist, they may interfere and/or be from a previous install, and you certainly want them killed/deleted.

REM ======= BEGIN =======

REM OPTIONAL: Uncomment the following line to disable Wake On Lan (doesn't work for every computer):
REM CTRLWOL.vbs ENABLE

FOR /F "delims=" %%A IN (uninstallKillTaskList.txt) DO (
..\Process.exe -k %%A.exe
)

SET CURRDIR=%CD%
START service\Uninstall-farmCommSysServe.bat %CURRDIR%\service
ECHO Please wait for the window which opened to do its work (of uninstalling any instance of the farmComm service), and then . . .
TIMEOUT /T 15

REG IMPORT noFarmComm.reg
SCHTASKS /END /TN "killCheck"
SCHTASKS /DELETE /TN "killCheck" /F
SCHTASKS /END /TN "runCheck"
SCHTASKS /DELETE /TN "runCheck" /F
SCHTASKS /END /TN "systemSpawn"
SCHTASKS /DELETE /TN "systemSpawn" /F

ECHO Any necessary termination of processes, and/or uninstall of (any) prior setup, is complete. This batch will exit in . . .
TIMEOUT /T 15
EXIT