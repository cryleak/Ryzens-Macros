if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, 30, 30
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1


Gui, Add, Text,,Enable the shit:
Gui, Add, Checkbox, gEnable vIsEnabled h20 ym,
Gui, Show,, gold farming simulator 2022


Enable:
loop {
	GuiControlGet, RightClick
	GuiControlGet, IsEnabled
    If (IsEnabled = 0) {
        break
	}
		else {
				Send {Enter}
		}
}
return

F6::
GuiControlGet, IsEnabled
if (IsEnabled = 1) {
GuiControl,,IsEnabled, 0 
}
else {
GuiControl,,IsEnabled, 1
}
Goto, Enable
return