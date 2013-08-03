ECHO OFF
ECHO -                                                 
ECHO -                                                 
ECHO -                                                 
ECHO =======================================================================
ECHO ================== Restart farmComm SYSTEM service ====================
ECHO -----------------------------------------------------------------------
ECHO -
ECHO  . . . . . . . . . . . . . . Restarting . . . . . . . . . . . . . . . .
ECHO -
ECHO -----------------------------------------------------------------------
ECHO =======================================================================
ECHO =======================================================================
ECHO -                                                 
ECHO -                                                 
ECHO -  
TIMEOUT /T 7
ECHO Attempting stop of farmComm SYSTEM service . . .
NET STOP farmComm
ECHO Terminating all associated processes . . .
START terminateAll.bat
TIMEOUT /T 7
ECHO Starting farmComm SYSTEM service again . . .
NET START farmComm
ECHO DONE.
TIMEOUT /T 15
EXIT