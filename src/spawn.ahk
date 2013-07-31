#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

;KILL ALL PROCESSES OF CONCERN AT INITIAL LAUNCH, AND ALSO PROCESSES THAT CONTROL THEM:
;NOTE: THE FOLLOWING TWO LINES SHOULD ONLY BE COMMENTED OUT FOR TESTING OF PROPER FUNCTIONALITY WHEN THE ACTIVE SESSION CHANGES (WHEN USERS CHANGE).
Run, %A_WorkingDir%\killControllerProcesses.exe, %A_WorkingDir%, hide UseErrorLevel, killSpawnsProcessID
Sleep, 1250
Run, %A_WorkingDir%\killSpawns.exe, %A_WorkingDir%, hide UseErrorLevel, killSpawnsProcessID
Sleep, 7000

;=====GLOBALS
EnvGet, runUserName, USERNAME
	;NOTE: Invisible padding (a newline?) in this variable was giving false checks where I wanted true . . . drove me mad for longer than I care to confess . . . auto-trimming the varaible simply by assigning it to itself is the solution. Re: http://stackoverflow.com/questions/15028932/strip-excess-padding-from-a-string
	;Do that with ALL string variables, as you go . . .
runUserName = %runUserName%

	;As this is designed to only launch on user logon, we will interfere with the logic below (which would not spawn processes if we had last written the user's name to user.txt), by writing the username secretNinja5603 to user.txt. This will ensure it always spawns processes when a user logs in. However, if your username is SecretNinja5603, this will mean that no processes are spawned :( Sorry, SecretNinja5603. No, I will not be merciful and write an exception case to change this if your username happens to match. Or perhaps that is a mercy if you do now wish to spawn those processes . . .
	
Run, %comspec% /k ECHO SecretNinja5603 > %A_WorkingDir%\user.txt, %A_WorkingDir%, hide UseErrorLevel, writeUserTXTProcessID


loop ;======LOOP START
{

	;TESTING ONLY, just to verify this loop is working:
	;MsgBox, 0, Message, Hello world! The username for the account running this task is %runUserName%. . . ., 5

;NOTES: The following isConsoleBool check will only return true, or isConsoleBool will only equal 0 (I hope, and my tests seem to confirm) on any run through this loop during which the user who executed this script is in an "active" (connected) user session. In other words, if there are other users logged in, but they are not connected to their sessions (because just this one user is using the computer), isConsoleBool will return 1 for any instances of this process which run under other user accounts--which we want, because when that value returns 1, we do *not* want to run any tasks. We only want to run tasks under the credentials (and user environment--including most probably the desktop and graphics card access) of the current, active user.

SysGet, isConsoleBool, 4096
if (isConsoleBool == 0)
	{
		;IN TESTING, UNCOMMENT ALL OF THE LINES BELOW AT THIS INDENT LEVEL:
		;MsgBox, 4, , isConsoleBool value is %isConsoleBool% [or, if this is executing as hoped, zero], which indicates that this script runs from a console session. It would be more difficult to execute this script otherwise, but there are ways . . . see the comments of testIfConsoleSession.ahk to read about one way. Continue this test (if you continue, this message will reappear in 17 seconds)?
		;IfMsgBox No
		;return

	;==========REINITIALIZE wroteUsername bool check variable before check.
	wroteUsername = 0
	;==========CHECK WHETHER user.txt REPORTS THAT PROCESSES OF CONCERN WERE SPAWNED BY THE USER EXECUTING THIS SCRIPT, AND STORE THE RESULT IN A BOOLEAN, wroteUsername.

	FileReadLine, activeSessionUserName, %A_WorkingDir%\user.txt, 1
	;SEE PROMINENTLY DEMARKED NOTE ON AUTOTRIM, NEAR THE BEGINNING OF THIS SCRIPT . . .
	activeSessionUserName = %activeSessionUserName%
		;MsgBox, line read from user.txt was %activeSessionUserName%
		;Logically, the following IfEqual statement and conditional execution block could be deleted, and the else clause below it (with its conditional execution block) could be altered to use the same logical check as the IfEqual, but changing the IfEqual to IfNotEqual (if that function exists), however, it's nice to have the feedback of the case wherein I should do nothing, for debug purposes.
	IfEqual, runUserName, %activeSessionUserName%
		{
			;MsgBox, 0, Previous run executed by active user, activeSessionUserName %activeSessionUserName% or purportedly the previous user to execute this program as recorded in user.txt is the same as runUserName %runUserName% the user who (now) executed this program. I should do nothing and therefore shall not do anything other than speak in oddly imperative terms . . . please dont fault the lack of punctuation in this its just that the message box will not work if its punctuated, 4
		}
		else
		{
			;MsgBox, 0, Previous run not executed by active user, activeSessionUserName %activeSessionUserName% or purportedly the previous user to execute this program as recorded in user.txt is NOT the same as runUserName %runUserName% the user who (now) executed this program. Killing and re-spawning processes of concern (as the currently active user (or the user in a console session--this block of execution is only reached *if* it is first verified that the user executing this program is in an active session--oy vay this explanation is too wordy!) as we want those processes to run under the current active user . . . I am about to terminate processes of concern (if they exist) . . . Im sorry this is unpuntuated its just that the message box will not work if its punctuated, 4
		;If the following special controller process killer isn't used, controlling processes can double up under the same login. Ergo kill them before we now respawn them.
		Run, %A_WorkingDir%\killControllerProcesses.exe, %A_WorkingDir%, hide UseErrorLevel, killSpawnsProcessID
		Sleep, 1250
		;Kill any/all processes spawned by the controller processes.
		Run, %A_WorkingDir%\killSpawns.exe, %A_WorkingDir%, hide UseErrorLevel, killSpawnsProcessID
		Sleep, 7000
		;MAYBE That can work well in less than than 7000 milliseconds (7 seconds)?
		Run, %comspec% /k DEL %A_WorkingDir%\user.txt, %A_WorkingDir%, hide UseErrorLevel, writeUserTXTProcessID
			;MsgBox, I just deleted user.txt, in preparation to write the value of runUserName, %runUserName%, to a new copy of it . . .
		Sleep, 3000
		Run, %comspec% /k ECHO %runUserName% > %A_WorkingDir%\user.txt, %A_WorkingDir%, hide UseErrorLevel, writeUserTXTProcessID
			;MsgBox, I just wrote the value of runUserName, %runUserName% to, user.txt . . .
		Sleep, 3000
		;*Check again* that the executor (user) of this process is still in an active session before executing controlling processes. *Don't* run the following control block if the user is *not* in an active session.
		SysGet, isConsoleBool, 4096
		if (isConsoleBool == 0)
			{
			Run, %A_WorkingDir%\spawnCheck.exe, %A_WorkingDir%, hide UseErrorLevel, killCheckProcessID
				;MsgBox, I just executed the task spawnCheck.exe . . .
			Run, %A_WorkingDir%\killCheck.exe, %A_WorkingDir%, hide UseErrorLevel, killCheckProcessID
				;MsgBox, I just executed the task killCheck.exe, and I will now wait, then jump back to the start of this task via Goto . . .
			}
		}
	}

;Wait 6.785 seconds at the end of each iteration of this loop (in other words, re-check and/or redo everything this loop does every ~7 seconds.
Sleep, 6785
} ;======LOOP END