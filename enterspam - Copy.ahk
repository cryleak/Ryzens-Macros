if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#SingleInstance, force
#MaxThreadsPerHotkey 1
#MaxThreads 99999
#MaxThreadsBuffer On
#MaxHotkeysPerInterval 99000000
#KeyHistory 0
#HotkeyInterval 99000000
#Persistent
ListLines Off
SetTitleMatchMode, 2
SetDefaultMouseSpeed, 0
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1
SetWorkingDir %A_ScriptDir%
global paused = false

SetTimer, Yes, 1
Return

Yes:
	if GetKeyState("F6", "P")
	{
		if (!paused)
		{
			Send {Blind}{enter up}
			global paused = true
		} Else
			global paused = false
	}
	If WinActive("ahk_class grcWindow") && (!paused)
		Send {Blind}{enter down}
	If WinActive("ahk_class grcWindow") && (paused)
		Send {Blind}{enter up}
return