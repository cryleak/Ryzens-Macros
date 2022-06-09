#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
#Persistent
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Process, Priority, , L
#IfWinActive ahk_class grcWindow
#MaxThreadsPerHotkey 2
#IfWinActive Grand Theft Auto V
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1

F4::
Toggle := !Toggle
loop
{
    If not Toggle
        break
send t{shift up}
sendinput shut up
send {enter}
}
return