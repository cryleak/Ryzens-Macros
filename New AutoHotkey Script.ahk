if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#SingleInstance, force
#IfWinActive ahk_class grcWindow
#IfWinActive Grand Theft Auto V
#MaxThreadsPerHotkey 1
#MaxThreads 99999
#MaxThreadsBuffer On
#MaxHotkeysPerInterval 99000000
#KeyHistory 0 
#HotkeyInterval 99000000
ListLines Off
SetTitleMatchMode, 2
SetDefaultMouseSpeed, 0
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1
SetMouseDelay, -1
Process, Priority, , N
SetWorkingDir %A_ScriptDir%

*X::
send {blind}{enter 2}
sleep 5500
send {e 10}{u 600}
return