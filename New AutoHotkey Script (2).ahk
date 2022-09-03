#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode InputThenPlay
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F6::
SetKeyDelay, 500, 500
SetKeyDelay, 999, 999, Play
SendMode InputThenPlay
Send test
sleep 1000
MsgBox, %A_SendMode%
return
