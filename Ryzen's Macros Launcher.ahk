#SingleInstance Ignore
if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"
SetBatchLines, -1 ; Removes the built in 10ms sleep that happens after every line of code normally. It should never sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.

TrayButtonInfo = 1
; Debug:
/*
ListLines Off ; Removes line history, makes the script slightly more secret.
#KeyHistory 0 ; Removes key history, makes the script slightly more secret.
TrayButtonInfo = 0
*/
#MaxThreadsPerHotkey 1 ; Doesn't really matter
#MaxThreads 99999 ; Sets the maximum amount of active threads to practically infinity.
#MaxThreadsBuffer On ; Makes hotkeys buffer if you hold it down or something.
#MaxHotkeysPerInterval 99000000 ; Doesn't matter but AHK may give you an error if you spam hotkeys really really fast otherwise.
#HotkeyInterval 99000000 ; Same as the other hotkey interval setting
#Persistent ; Makes the script never exit, probably unneccassary because other commands (like hotkey) already cause it to never exit.

LauncherVersion = 1.00-RC1
ConfigDirectory = %A_MyDocuments%\Ryzen's Macros
FileDelete, %A_Temp%\Script.ahk
Goto, CheckHWID ; Checks your PC's UUID. Shitty but it works
Back:
   IfNotExist, %ConfigDirectory%
      FileCreateDir, %ConfigDirectory%
   IfNotExist, %ConfigDirectory%\assets
      FileCreateDir, %ConfigDirectory%\assets
   FileInstall, C:\Users\theok\Desktop\Desktop Stuff\Macros\GitHub Repository\assets\image.jpg, %ConfigDirectory%\assets\image.jpg, 1
   FileInstall, C:\Users\theok\Desktop\Desktop Stuff\Macros\GitHub Repository\DynamicScript.ahk, %ConfigDirectory%\DynamicScript.ahk, 0
   FileInstall, C:\Users\theok\Desktop\Desktop Stuff\Macros\GitHub Repository\GTAHaXUI.exe, %ConfigDirectory%\GTAHaXUI.exe, 1
   FileInstall, C:\Users\theok\Desktop\Desktop Stuff\Macros\GitHub Repository\assets\crosshair.png, %ConfigDirectory%\assets\crosshair.png, 1
   FileInstall, Reload.exe, %ConfigDirectory%\Reload.exe, 1
   Gui, Add, Picture, x0 y0 w400 h-1 +0x4000000, %ConfigDirectory%/assets/image.jpg
   Gui,Font, s10,
   Gui, Add, Button, gCopyOldConfig, Move old config to the new location
   Gui, Add, Button, gOpenDirectory, Open Local Directory of Ryzen's Macros
   Gui, Add, Button, gDirectoryWipe, Wipe Local Directory
   Gui, Add, Button, gEditDynamicScript, Edit Dynamic Script
   Gui, Add, Button, gQuitLauncher, Quit Launcher
   Gui, Add, Button, gLaunchMacros, Launch Ryzen's Macros
   
   Menu, Tray, Tip, Ryzen's Macros Launcher %LauncherVersion%
   Gui, Show,, Ryzen's Macros Launcher %LauncherVersion%
   
   DetectHiddenWindows, On ; It does something
   Gui0 := WinExist( A_ScriptFullpath " ahk_pid " DllCall( "GetCurrentProcessId" ) ) ; I forgor
   DetectHiddenWindows, Off ; It does something
   Menu, Tray, NoStandard
   If (TrayButtonInfo = 1) {
      Menu, Tray, Add, Open, StandardTrayMenu
      Menu, Tray, Add
   }
   Menu, Tray, Add, Window Spy, StandardTrayMenu
   Menu, Tray, Add, Reload This Script, StandardTrayMenu
   Menu, Tray, Add
   Menu, Tray, Add, Suspend Hotkeys, StandardTrayMenu
   Menu, Tray, Add, Pause Script, StandardTrayMenu
   Menu, Tray, Add, Exit, StandardTrayMenu
   If (TrayButtonInfo = 1)
      Menu, Tray, Default, Open
   
   Gosub, StandardTrayMenu
   
   IniWrite, %A_ScriptDir%, %ConfigDirectory%\FileLocationData.ini, Location, Location
   IniWrite, %A_ScriptName%, %ConfigDirectory%\FileLocationData.ini, Name, Name
Return

CopyOldConfig:
   If FileExist(A_ScriptDir "\GTA Binds.ini") {
      MsgBox, 4, Old configuration detected in this folder!, I have detected a configuration file in the same folder that the launcher is located. Are you sure you would like to do this though? If you have any current config there, it will get deleted!
      IfMsgBox Yes
      {
         FileCopy, %A_ScriptDir%\GTA Binds.ini, %ConfigDirectory%\GTA Binds.ini, 1
         MsgBox, 0, Complete., It is now done. Press Launch Ryzen's Macros to see it.
      }
      IfMsgBox No
      {
         MsgBox, 0, Ok. I won't., Ok. I won't. If you change your mind later, this option is always available for you.
      }
   } else {
      MsgBox, 4, I have not detected any config located in the current folder!, I have not detected any configuration file in the same folder that the launcher is located! Would you like to manually select a file to copy into the new location?
      IfMsgBox Yes
      {
         FileSelectFile, SelectedFile,, %A_ScriptDir%\GTA Binds.ini, (*.ini)
         FileCopy, %SelectedFile%, %ConfigDirectory%\GTA Binds.ini, 1
         MsgBox, 0, Complete., It is now done. Press Launch Ryzen's Macros to see it.
      }
   }
Return

LaunchMacros:
   FileInstall, Ryzen's Macros.ahk, %A_Temp%\Script.ahk
   while IfExist, A_Temp "\Script.ahk"
      {}
      Run, Script.ahk, %A_Temp%
   MsgBox,0,Launching...,Launching...,1
   sleep 400
   FileDelete, %A_Temp%\Script.ahk
Return

QuitLauncher:
   FileDelete, %ConfigDirectory%\Reload.exe
ExitApp
Return

OpenDirectory:
   Run, %ConfigDirectory%
Return

CheckHWID:
   UrlDownloadToFile, https://pastebin.com/raw/dpBPUkBM, %A_Temp%\Keys.ini
   while IfExist, A_Temp "\Keys.ini"
      {}
      IniRead, Key1, %A_Temp%\Keys.ini, Registration, Key1
   IniRead, Key2, %A_Temp%\Keys.ini, Registration, Key2
   IniRead, Key3, %A_Temp%\Keys.ini, Registration, Key3
   IniRead, Key4, %A_Temp%\Keys.ini, Registration, Key4
   IniRead, Key5, %A_Temp%\Keys.ini, Registration, Key5
   IniRead, Key6, %A_Temp%\Keys.ini, Registration, Key6
   IniRead, Key7, %A_Temp%\Keys.ini, Registration, Key7
   IniRead, Key8, %A_Temp%\Keys.ini, Registration, Key8
   IniRead, Key9, %A_Temp%\Keys.ini, Registration, Key9
   IniRead, Key10, %A_Temp%\Keys.ini, Registration, Key10
   IniRead, Key11, %A_Temp%\Keys.ini, Registration, Key11
   IniRead, Key12, %A_Temp%\Keys.ini, Registration, Key12
   IniRead, Key13, %A_Temp%\Keys.ini, Registration, Key13
   IniRead, Key14, %A_Temp%\Keys.ini, Registration, Key14
   IniRead, Key15, %A_Temp%\Keys.ini, Registration, Key15
   IniRead, Key16, %A_Temp%\Keys.ini, Registration, Key16
   IniRead, Key17, %A_Temp%\Keys.ini, Registration, Key17
   IniRead, Key18, %A_Temp%\Keys.ini, Registration, Key18
   IniRead, Key19, %A_Temp%\Keys.ini, Registration, Key19
   IniRead, Key20, %A_Temp%\Keys.ini, Registration, Key20
   IniRead, Key21, %A_Temp%\Keys.ini, Registration, Key21
   IniRead, Key22, %A_Temp%\Keys.ini, Registration, Key22
   IniRead, Key23, %A_Temp%\Keys.ini, Registration, Key23
   IniRead, Key24, %A_Temp%\Keys.ini, Registration, Key24
   IniRead, Key25, %A_Temp%\Keys.ini, Registration, Key25
   IniRead, Key26, %A_Temp%\Keys.ini, Registration, Key26
   IniRead, Key27, %A_Temp%\Keys.ini, Registration, Key27
   IniRead, Key28, %A_Temp%\Keys.ini, Registration, Key28
   IniRead, Key29, %A_Temp%\Keys.ini, Registration, Key29
   IniRead, Key30, %A_Temp%\Keys.ini, Registration, Key30
   IniRead, Key31, %A_Temp%\Keys.ini, Registration, Key31
   IniRead, Key32, %A_Temp%\Keys.ini, Registration, Key32
   IniRead, Key33, %A_Temp%\Keys.ini, Registration, Key33
   IniRead, Key34, %A_Temp%\Keys.ini, Registration, Key34
   IniRead, Key35, %A_Temp%\Keys.ini, Registration, Key35
   IniRead, Key36, %A_Temp%\Keys.ini, Registration, Key36
   IniRead, Key37, %A_Temp%\Keys.ini, Registration, Key37
   IniRead, Key38, %A_Temp%\Keys.ini, Registration, Key38
   IniRead, Key39, %A_Temp%\Keys.ini, Registration, Key39
   IniRead, Key40, %A_Temp%\Keys.ini, Registration, Key40
   IniRead, Key41, %A_Temp%\Keys.ini, Registration, Key41
   IniRead, Key42, %A_Temp%\Keys.ini, Registration, Key42
   IniRead, Key43, %A_Temp%\Keys.ini, Registration, Key43
   IniRead, Key44, %A_Temp%\Keys.ini, Registration, Key44
   IniRead, Key45, %A_Temp%\Keys.ini, Registration, Key45
   IniRead, Key46, %A_Temp%\Keys.ini, Registration, Key46
   IniRead, Key47, %A_Temp%\Keys.ini, Registration, Key47
   IniRead, Key48, %A_Temp%\Keys.ini, Registration, Key48
   IniRead, Key49, %A_Temp%\Keys.ini, Registration, Key49
   IniRead, Key50, %A_Temp%\Keys.ini, Registration, Key50
   IniRead, Key51, %A_Temp%\Keys.ini, Registration, Key51
   IniRead, Key52, %A_Temp%\Keys.ini, Registration, Key52
   IniRead, Key53, %A_Temp%\Keys.ini, Registration, Key53
   IniRead, Key54, %A_Temp%\Keys.ini, Registration, Key54
   IniRead, Key55, %A_Temp%\Keys.ini, Registration, Key55
   IniRead, Key56, %A_Temp%\Keys.ini, Registration, Key56
   IniRead, Key57, %A_Temp%\Keys.ini, Registration, Key57
   IniRead, Key58, %A_Temp%\Keys.ini, Registration, Key58
   IniRead, Key59, %A_Temp%\Keys.ini, Registration, Key59
   IniRead, Key60, %A_Temp%\Keys.ini, Registration, Key60
   
   FileDelete, %A_Temp%\Keys.ini
   
   key := % UUID()
   valid_ids := Object((Key1), y,(Key2), y,(Key3), y,(Key4), y,(Key5), y,(Key6), y,(Key7), y,(Key8), y,(Key9), y,(Key10), y,(Key11), y,(Key12), y,(Key13), y,(Key14), y,(Key15), y,(Key16), y,(Key17), y,(Key18), y,(Key19), y,(Key20), y,(Key21), y,(Key22), y,(Key23), y,(Key24), y,(Key25), y,(Key26), y,(Key27), y,(Key28), y,(Key29), y,(Key30), y,(Key31), y,(Key32), y,(Key33), y,(Key34), y,(Key35), y,(Key36), y,(Key37), y,(Key38), y,(Key39), y,(Key40), y,(Key41), y,(Key42), y,(Key43), y,(Key44), y,(Key45), y,(Key46), y,(Key47), y,(Key48), y,(Key49), y,(Key50), y,(Key51), y,(Key52), y,(Key53), y,(Key54), y,(Key55), y,(Key56), y,(Key57), y,(Key58), y,(Key59), y,(Key60), y)
   if not (valid_ids.HasKey(key)) {
      c0=D4D0C8
      Gui,2:Add, Link,w400, Your HWID has been copied to the clipboard. Please join the Discord Server and send it in the #macro-hwid channel. To gain access to the channel, you must react in the #macros channel.
      Gui,2:Add, Link,, <a href="https://discord.gg/5Y3zJK4KGW">Here</a> is an invite to the discord server.
      Gui,2:Add, Button,ym+80 gExitMacros2, OK
      Gui,2:Show,, HWID Mismatch
      Return
   } else {
      Goto, Back
   }

ExitMacros2:
   Clipboard := key
ExitApp

UUID()
{
   For obj in ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2").ExecQuery("Select * From Win32_ComputerSystemProduct")
      return obj.UUID
}

EditDynamicScript:
   IfExist, %ConfigDirectory%\DynamicScript.ahk
   {
      MsgBox, 0, Opening..., Opening..., 0.5
      Run, DynamicScript.ahk, %ConfigDirectory%,
   } else {
      MsgBox, 0, DynamicScript.ahk doesn't appear to exist, DynamicScript.ahk doesn't appear to exist´, please try again when it exists.
   }
Return

StandardTrayMenu:
   If (TrayButtonInfo = 1) {
      If ( A_ThisMenuItem = "Open" )
         DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65406, UInt,0 )
   }
   If ( A_ThisMenuItem = "Help" )
      DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65411, UInt,0 )
   
   If ( A_ThisMenuItem = "Window Spy" )
      DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65402, UInt,0 )
   
   If ( A_ThisMenuItem = "Reload This Script" )
      DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65400, UInt,0 )
   
   If ( A_ThisMenuItem = "Suspend Hotkeys" ) {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65404, UInt,0 )
   }
   
   If ( A_ThisMenuItem = "Pause Script" ) {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65403, UInt,0 )
   }
   
   If ( A_ThisMenuItem = "Exit" )
      DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65405, UInt,0 )

return

GuiClose:
ExitApp

DirectoryWipe:
MsgBox, 4, Are you sure?, Are you sure you would like to do this? You will have to restart the launcher and it will be completely reset to default!
IfMsgBox Yes
{
   FileRemoveDir, %ConfigDirectory%, 1
   MsgBox, 0, Done., It is now done. Launcher will restart in 5 seconds.,  5
   Reload
}
Return