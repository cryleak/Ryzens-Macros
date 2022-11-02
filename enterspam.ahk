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
Process, Priority, , H
Process, Priority, GTA5.exe, H
SetWorkingDir %A_ScriptDir%

X::
Pause

Z::
loop {
If WinActive("ahk_class grcWindow") {
send {enter}
sleep 300
}
}
return