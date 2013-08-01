#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

;SET GLOBALS
IdleTimeout = 4000
PROCSPAWN = 0
;Always reassaign varaibles intended to be checks to themselves. Re: http://stackoverflow.com/questions/15028932/strip-excess-padding-from-a-string
PROCSPAWN = %PROCSPAWN%
KILLEDPROC = 0
KILLEDPROC = %KILLEDPROC%

;MAIN EXECUTION
IdleTimeout = 4000
SetTimer, IdleTimeoutCheck, 12000
SetTimer, ResumeFromIdleCheck, 1000
if (%PROCSPAWN% == 1)	{
	SetTimer, IdleTimeoutCheck, Off
						}
	else
						{
	SetTimer, IdleTimeoutCheck, On
						}
return

;========== IDLE TIMEOUT CHECK ============
IdleTimeoutCheck:
if (A_TimeIdlePhysical > IdleTimeout)	{
	if (%PROCSPAWN% == 0)	{
		MsgBox, 0, IDLE!, User idle past limit. Supposedly no process spawned. Will spawn. A_TimeIdlePhysical is %A_TimeIdlePhysical%., 6
		PROCSPAWN = 1
		PROCSPAWN = %PROCSPAWN%
		KILLEDPROC = 0
		KILLEDPROC = %KILLEDPROC%
							}
										}
return
;========== IDLE TIMEOUT CHECK END ========

;========== RESUME FROM IDLE CHECK ========
ResumeFromIdleCheck:
if (A_TimeIdlePhysical < 3000)	{
	if (%KILLEDPROC% == 0)	{
		MsgBox, 0, RESUME!, User active past limit. Any spawned process have not been killed. Will check for and kill processes. A_TimeIdlePhysical is %A_TimeIdlePhysical%., 6
		PROCSPAWN = 0
		PROCSPAWN = %PROCSPAWN%
		KILLEDPROC = 1
		KILLEDPROC = %KILLEDPROC%
							}
								}
return
;======== END RESUME FROM IDLE CHECK ======