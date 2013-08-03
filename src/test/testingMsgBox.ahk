#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

LOOPSTART:

SysGet, isConsoleBool, 4096
MsgBox, 0, Session Check, isConsoleBool value is %isConsoleBool% [or if this is executing as hoped nonzero] which indicates that this script is not running from an active session. This program will self-terminate and systemSpawn.exe as designed to run as a service or at least hacked to launch as a service via the awesome! LaunchServe tool will automatically launch farmComm again into session 0 which by what magic I do not know seems to work for this setup such that it will be associated or communicate with the active session and therefore respond to user activity and note user inactivity and access graphics hardware via spawned processes if desired . . . sorry this is not punctuated well the message box breaks with commas, 25

Sleep, 27000
MsgBox, 4, Exit App?, Exit script?
	IfMsgBox Yes
		ExitApp

Sleep, 5000
Goto, LOOPSTART