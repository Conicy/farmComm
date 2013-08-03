ECHO OFF
ECHO -                                                 
ECHO -                                                 
ECHO -                                                 
ECHO =======================================================================
ECHO ============= Terminate all farmComm-related processes ================
ECHO -----------------------------------------------------------------------
ECHO -
ECHO . . . . . . . . . . . . . Terminating . . . . . . . . . . . . . . . . .
ECHO -
ECHO -----------------------------------------------------------------------
ECHO =======================================================================
ECHO =======================================================================
ECHO -                                                 
ECHO -                                                 
ECHO -  

setup\service\LaunchServ.exe -stop

FOR /F "delims=" %%A IN (allProcessesList.txt) DO (
START Process.exe -k %%A.exe
)

ECHO If farmComm is installed as a service, and you wish to restart it,
ECHO run systemSpawnServiceRestart.bat
TIMEOUT /T 7
EXIT