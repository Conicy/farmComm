#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

;This demonstrates how to assign more than one return value from a function to variables, by reference. This may seem simple, but it had been lost on me, so I'm keeping this here for history . . . re http://www.autohotkey.com/board/topic/46677-returning-multiple-values-from-a-function/

var1 = 5
var2 = 35

MsgBox, var1 has the value %var1% and var2 has the value %var2%.

func(var1,var2)

MsgBox, var1 has the value %var1% and var2 has the value %var2%.

q::exitApp

func(byref var1, byref var2)
{
var1 *= 5
var2 *= 100
return var1, var2
}

