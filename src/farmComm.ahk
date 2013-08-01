#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
#Persistent

;========= SET GLOBALS
EnvGet, runUserName, USERNAME
;===== NOTE: Possibly, invisible padding (a newline?) in runUserName variable was giving false checks where I wanted true . . . drove me mad for longer than I care to confess . . . auto-trimming the varaible simply by assigning it to itself is the solution. Re: http://stackoverflow.com/questions/15028932/strip-excess-padding-from-a-string
;Do that with ALL string variables, as you go . . .
runUserName = %runUserName%
PROCSPAWN = 0
PROCSPAWN = %PROCSPAWN%
KILLEDPROC = 0
KILLEDPROC = %KILLEDPROC%
; User must be idle for 8.5 minutes (510,000 milliseconds) for this script to spawn processes.
IdleTimeout = 510000
	; FOR TESTING ONLY:
	;IdleTimeout = 3500

;========= MAIN EXECUTION
SetTimer, IdleTimeoutCheck, 12000
SetTimer, ResumeFromIdleCheck, 1275
if (%PROCSPAWN% == 1)	{
	SetTimer, IdleTimeoutCheck, Off
						}
	else
						{
	SetTimer, IdleTimeoutCheck, On
						}
return

;========== IDLE TIMEOUT CHECK (AND SPAWN PROCESSES IF APPROPRIATE) ============
IdleTimeoutCheck:
if (A_TimeIdlePhysical > IdleTimeout)	{
	if (%PROCSPAWN% == 0)			{
			;MsgBox, 0, IDLE!, User idle past limit. Supposedly no process spawned. Will spawn. A_TimeIdlePhysical is %A_TimeIdlePhysical%. IdleTimeout is %IdleTimeout%., 6
		; RESET VARIABLES UPON WHICH TIMERS DEPEND
		PROCSPAWN = 1
		PROCSPAWN = %PROCSPAWN%
		KILLEDPROC = 0
		KILLEDPROC = %KILLEDPROC%

			; ==== START SECTION: CHECK WHETHER PROCESSES MAY RUN, RUN THEM IF SO
			;Check for our exec., and don't create a duplicate run if the process is running.
			;Moreover, do not run any of the exec. in question unless NONE of them are already running (or in other words, if ALL of the below checks for running processes return false)!

				;TESTING ONLY, just to verify this loop is working:
				;MsgBox, 0, Message, Hello world! The username for the account running this task is %runUserName%. . . ., 5

			;INITIALIZE (OR REINITIALIZE) BOOLEAN TEST VALUE TO ZERO
			PIDBOOL = 0

				Loop
				{
					FileReadLine, line, %A_WorkingDir%\processSpawnList.txt, %A_Index%
					if ErrorLevel
						break
					;MsgBox, Line #%A_Index% is %line%. Checking for running process %line%.exe . . .
					Process, Exist, %line%.exe
						if (%ErrorLevel% == 0)
							{
							;MsgBox, 0, Check for Process, value of ErrorLevel is %ErrorLevel% [if all runs correctly that value will be 0] meaning the process %line%.exe was not found to be running. We are using a boolean value PIDBOOL to reflect whether a check for an exec. ever returns TRUE. As we just found a check to be false if we set PIDBOOL to FALSE (0) in the program logic that would nullify any checks which return TRUE which we do not want to do. In fact in the control block where this testing message appears IN PRODUCTION WE WANT TO DO NOTHING. Sorry to shout but that makes it easier to cut to the chase when this message box briefly appears and then auto-times-out. We will only leave this control block here for testing (and comment out this message box clode block when we know through testing that its working properly. I am also sorry that this message is so poorly unpuctuated its just that this message box will break if its punctuated., 7
							}
						else
							{
							PIDBOOL = 1
							;MsgBox, 0, Check for process, value of ErrorLevel is %ErrorLevel% [if all runs correctly that value will be nonzero] meaning the process %line%.exe was found to be running. SETTING PIDBOOL TO 1 (ONE) to reflect that we found an exec. of concern to be running . . . indeed also to be geronding . . . sorry this message bo is poorly punctuated its just that it will not work if punctuated, 7
							}
				}
				Sleep, 250

			;The following will only check TRUE if ALL of the %ErrorLevel% checks above returned zero, or in other words, NONE of our exec. were found to be running:
			if (%PIDBOOL% != 0)
				{
				;MsgBox, 0, Our exec. were found to be running (or so we assume as PIDBOOL was found to be %PIDBOOL% [if all runs correctly that value will be 1] so we will *not* spawn any new processes. This message box is only useful to verify this in testing. For production comment out this message box., 7
				}
			else
				{
					;Read batch commands from text file into variables, then execute the commands. Why from AutoHotkey and not a batch? A batch pops up on the screen obnoxiously. AutoHotkey can run without showing a console, and spawn "invisible" commands.
					;MsgBox, 0, Processes not found, No our exec. were found to be running (or PIDBOOL was found to be %PIDBOOL% [if all runs correctly that value will be 0] will spawn them . . . but ONLY after double-checking that this run of the exe is in an active session!, 7
				SysGet, isConsoleBool, 4096
				if (isConsoleBool == 0)
					{
					Run, %A_WorkingDir%\runProcesses.exe, %A_WorkingDir%, hide UseErrorLevel, runProcessesProcessID
					Sleep, 375
					}
				}
			; ==== END SECTION: CHECK WHETHER PROCESSES MAY RUN, RUN THEM IF SO

									}
										}
return
;========== END SECTION: IDLE TIMEOUT CHECK (AND SPAWN PROCESSES IF APPROPRIATE) ============

;========== RESUME FROM IDLE CHECK ========
ResumeFromIdleCheck:
if (A_TimeIdlePhysical < 3000)	{
	if (%KILLEDPROC% == 0)	{
			;MsgBox, 0, RESUME!, User active past limit. Any spawned process have not been killed. Will check for and kill processes. A_TimeIdlePhysical is %A_TimeIdlePhysical%., 6
		PROCSPAWN = 0
		PROCSPAWN = %PROCSPAWN%
		KILLEDPROC = 1
		KILLEDPROC = %KILLEDPROC%
		killSpawns()
							}
								}
return
;======== END RESUME FROM IDLE CHECK ======



;FUNCTION TO KILL ANY SPAWNED PROCESSES
killSpawns()
{
	; ==== BEGIN LOOP which reads text file list of processes, checks for them, and kills any.
	Loop
	{
		FileReadLine, line, %A_WorkingDir%\processSpawnList.txt, %A_Index%
		if ErrorLevel
			break
			;For testing:
			;MsgBox, Line #%A_Index% is %line%. Will attempt close of, then termination of, process %line%, via commands (and executable) <Process.exe -q %line%.exe> and <Process.exe -k %line%.exe>, respectively . . .
		Process, Exist, %line%.exe
		NewPID = %ErrorLevel%  ; Save the value immediately since ErrorLevel is often changed.
		if NewPID = 0
			{
			;MsgBox The specified process was not found.
			}
		else
			{
			;MsgBox, A matching process was found (Process ID is %NewPID%).
			Run, %A_WorkingDir%\Process.exe -q %line%.exe, %A_WorkingDir%, hide UseErrorLevel
			Sleep, 1250
			Run, %A_WorkingDir%\Process.exe -k %line%.exe, %A_WorkingDir%, hide UseErrorLevel
			Sleep, 2500

			;Special runs to terminate undely meddlesome, unhelpful debugger applications.
			Run, %A_WorkingDir%\Process.exe -k Werfault.exe, %A_WorkingDir%, hide UseErrorLevel
			Sleep, 750

			Run, %A_WorkingDir%\Process.exe -k dwm.exe, %A_WorkingDir%, hide UseErrorLevel
			Sleep, 750
			}
	}
	; ==== END LOOP that kills any spawned processes.
return
}