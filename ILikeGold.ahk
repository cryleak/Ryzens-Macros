﻿if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
#MaxThreadsPerHotkey 2
#Persistent
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Process, Priority, , L
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1

Gui, Add, Text,,Enable the shit:
Gui, Add, Text,,Right click in order to eat?
Gui, Add, Checkbox, gEnable vIsEnabled h20 ym,
Gui, Add, Checkbox, gRightClick vRightClick h20,
Gui, Add, Button, gRightClick, Spara inställningar
Gui, Show,, gold farming simulator 2022
IniRead,Read_RightClick,tinyconfig.ini,OnlyThingHere,Right Click
GuiControl,,RightClick,%Read_RightClick%

RightClick:
GuiControlGet, RightClick
if (RightClick = 1) {
IniWrite,1,tinyconfig.ini,OnlyThingHere,Right Click
} else {
IniWrite,0,tinyconfig.ini,OnlyThingHere,Right Click
}
return

Enable:
loop {
	GuiControlGet, RightClick
	GuiControlGet, IsEnabled
    If (IsEnabled = 0) {
		ControlClick,,ahk_exe javaw.exe,,Right,, U
        break
	}
		else {
			If (RightClick = 1) {
				ControlClick,,ahk_exe javaw.exe,,Right,, D
			}
		sleep 1500
		ControlClick,,ahk_exe javaw.exe,,Left
		}
}
return

F4::
GuiControlGet, IsEnabled
if (IsEnabled = 1) {
GuiControl,,IsEnabled, 0 
}
else {
GuiControl,,IsEnabled, 1
}
Goto, Enable
return