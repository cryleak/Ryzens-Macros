if (!A_IsAdmin) ; Runs the script as an admin.
    Run *RunAs "%A_ScriptFullPath%"
#MaxThreadsPerHotkey 1 ; Doesn't really matter
#SingleInstance Force
#MaxThreads 99999 ; Sets the maximum amount of active threads to practically infinity.
#MaxThreadsBuffer On ; Makes hotkeys buffer if you hold it down or something.
#MaxHotkeysPerInterval 99000000 ; Doesn't matter but AHK may give you an error if you spam hotkeys really really fast otherwise.
#HotkeyInterval 99000000 ; Same as the other hotkey interval setting
#Requires AutoHotkey >=1.1.36.02 Unicode <1.2

DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ; yes
SetTitleMatchMode, 2 ; I forgor :dead_skull:
SetDefaultMouseSpeed, 0 ; Something
SetKeyDelay, -1, -1 ; Sets key delay to the lowest possible, there is still delay due to the keyboard hook in GTA, but this makes it excecute as fast as possible WITHOUT skipping keystrokes. Set this a lot higher if you uninstalled the keyboard hook using mods.
SetWinDelay, -1 ; After any window modifying command, the script has a built in delay. Fuck delays.
SetMouseDelay, -1
SetControlDelay, 0 ; After any control modifying command, for example; ControlSend, there is a built in delay. Set to 0 instead of -1 because having a slight delay may improve reliability, and is unnoticable anyways.
MacroText := "Ryzen's Global Searcher Made In AutoHotkey"
i = 0

Gui,Font,s10 q5,Segoe UI Semibold ; Sets font to something
Gui, Add, Link,x+5 y10, Base Global to search from:
Gui, Add, Link,, Number of globals to search through:
Gui, Add, Link,, Value to find:
Gui, Add, Link,, Time between Globals (ms)

Gui, Add, Edit, x+80 y10 +Number,
Gui, Add, UpDown, vbaseGlobalToSearchFrom Range0-2147483647, 0
Gui, Add, Edit, +Number
Gui, Add, UpDown, viterationCount Range1-10000, 1
Gui, Add, Edit, +Number
Gui, Add, UpDown, vvalueToFind Range0-2147483647, 0
Gui, Add, Edit, +Number
Gui, Add, UpDown, vdelay Range0-1000, 100

Gui,Font,s20 q5,Segoe UI Semibold ; Sets font to something
Gui, Add, Button, gStart h100 x125 y140,Start Search!

Gui, Show,, %MacroText%
Return

Start:
    Gui, Submit, NoHide
    Run, *RunAs GTAHaXUI.exe, %A_ScriptDir%,,Gay
    WinWait, ahk_pid %Gay%
    ControlSend, Edit1, {down}{backspace}%baseGlobalToSearchFrom%, ahk_pid %Gay%
    Loop %iterationCount%
    {
        i++
        ControlSetText, Edit2,%i%, ahk_pid %Gay%
        Sleep %delay%
        ControlGet, currentValue,Line,1,Edit7,ahk_pid %Gay%
        if (currentValue = valueToFind)
        {
            TrayTip, Process completed, Global with matching value found!, 30, 32
            MsgBox, 4, %MacroText%,
            (
                Global with matching value found!
                Global Offset 1: %baseGlobalToSearchFrom%
                Global Offset 2: %i%
                Would you like me to continue searching beyond this global?
            )
            IfMsgbox No
            {
                i = 0
                Process, Close, ahk_pid %Gay%
                Return
            }
            IfMsgBox Yes
            {
                i++
                Continue
            }
        }
        if not ProcessExist(ahk_pid Gay)
            break
    }
    i = 0
    Process, Close, ahk_pid %Gay%
Return

GuiClose:
ExitApp

ProcessExist(Name) ; For convenience sake
{
   Process, Exist, %Name%
   Return ErrorLevel
}