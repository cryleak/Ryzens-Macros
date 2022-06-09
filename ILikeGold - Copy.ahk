if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
#MaxThreadsPerHotkey 2
#Persistent
#IFWinActive ahk_exe NMS.exe
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Process, Priority, , L
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1

F6::
 {
   Toggle:=!Toggle

   While, Toggle
    {
		Send {e down}
		Sleep 1000
		Send {e up}
		Loop, 3 {
		Send {lbutton 10}
		Sleep 250
		}
		Send 1
		Loop, 10 {
			Send {lbutton}
			sleep 250
		}
		sleep 500
    }
 }
Return