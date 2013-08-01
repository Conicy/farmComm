#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

;COMMENT OUT the following in testing, uncomment it in production.
Sleep, 5000

Run, %A_WorkingDir%\PaExec.exe -s -x -d -i 0 %A_WorkingDir%\farmComm.exe, %A_WorkingDir%, hide UseErrorLevel, farmCommProcessID
Sleep, 3500

;DEVELOPERS: See the DEVELOPER NOTES section of README.md about PaExec usage quirks.