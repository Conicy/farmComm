#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Re: http://www.autohotkey.com/board/topic/64072-compare-file-date-to-today/
;ADAPT:

;one thing. I would do this instead

;filegettime, var1, file.ext, C

;no need for the xtra bit with outputvar.

FileGetTime, OutputVar, YourFile.txt, C ; Retrieves the creation time.
var1 = %OutputVar% ; replace file date variable with var1
var2 = %A_Now% ; replace current time variable with var2
EnvSub, var2, %var1%, days ; variables = days // subtract the two
If var2 > 90
{
	MsgBox, 4,, File is %var2%(s) old. `nDelete it now?
		IfMsgbox, Yes
		FileDelete, YourFile.txt
	
		IfMsgbox, No
		Msgbox, File deletion canceled
		return
}	
else
	MsgBox, File is only %var2%(s) old
	return