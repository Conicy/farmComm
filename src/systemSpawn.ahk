#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

;Wait a good minute and half before even attempting, then give PaExec *plenty* of time to run these tasks (shorter wait times showed that it failed):
;Sleep, 90000

Run, %A_WorkingDir%\PaExec.exe -s -x -d -i 0 %A_WorkingDir%\killCheck.exe, %A_WorkingDir%, hide UseErrorLevel, systemKillCheckProcessID
Sleep, 15000

Run, %A_WorkingDir%\PaExec.exe -s -x -d -i 0 %A_WorkingDir%\spawnCheck.exe, %A_WorkingDir%, hide UseErrorLevel, systemSpawnCheckProcessID
Sleep, 15000

;DEVELOPERS: See the DEVELOPER NOTES section of README.md about PaExec usage quirks.