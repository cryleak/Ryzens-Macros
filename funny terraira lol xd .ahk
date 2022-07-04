#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 25, 25
SetBatchLines, -1

F6::
Send {Blind}{enter}{space}{enter}