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
#Requires AutoHotkey >=1.1.36.02 Unicode <1.2

LauncherVersion := "1.1.1.5"
ConfigDirectory = %A_MyDocuments%\Ryzen's Macros
FileDelete, %A_MyDocuments%\AutoHotkey.ahk
Goto, CheckHWID ; Checks your PC's UUID. Shitty but it works
Back:
   IniRead, Read_GTAVersion, %ConfigDirectory%\GTA Binds.ini,Misc,Selected GTA Version
   IfNotExist, %ConfigDirectory%
      FileCreateDir, %ConfigDirectory%
   IfNotExist, %ConfigDirectory%\assets
      FileCreateDir, %ConfigDirectory%\assets
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\assets\image.jpg, %ConfigDirectory%\assets\image.jpg, 1
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\DynamicScript.ahk, %ConfigDirectory%\DynamicScript.ahk, 0
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\GTAHaXUI.exe, %ConfigDirectory%\GTAHaXUI.exe, 1
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\assets\crosshair.png, %ConfigDirectory%\assets\crosshair.png, 1
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\assets\pending.wav, %ConfigDirectory%\assets\pending.wav, 0
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\assets\sweeped.wav, %ConfigDirectory%\assets\sweeped.wav, 0
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\Lyrics.txt, %ConfigDirectory%\Lyrics.txt, 0
   FileInstall, Reload.exe, %A_MyDocuments%\Reload.exe, 1
   IniRead, GTALocationEpic, %ConfigDirectory%\FileLocationData.ini, Epic Games Launcher, Location, %A_Space%
   IniRead, GTALocationRockstar, %ConfigDirectory%\FileLocationData.ini, Rockstar Games Launcher, Location, %A_Space%
   Gui, 1:New
   Gui, Add, Picture, x0 y0 w400 h-1 +0x4000000, %ConfigDirectory%/assets/image.jpg
   Gui,Font, s10,
   Gui, Add, Button, gCopyOldConfig, Move old config to the new location
   Gui, Add, Button, gOpenDirectory, Open Local Directory of Ryzen's Macros
   Gui, Add, Button, gDirectoryWipe, Wipe Local Directory
   Gui, Add, Button, gEditDynamicScript, Edit Dynamic Script
   Gui, Add, Button, gQuitLauncher, Quit Launcher
   Gui, Add, Button, gLaunchGTA, Launch GTA!
   Gui, Add, Button, gChangeGTALocation, Change GTA Location!
   Gui, Add, DropDownList, gGTAVersion vGTAVersion w190, Epic Games|Steam|Rockstar Games Launcher
   Gui, Add, Text,vText w400 R3, Current GTA Directory: Empty!
   
   Gui,Font, s20,
   Gui, Add, Button, gLaunchMacros y675 x43, Launch Ryzen's Macros!
   
   GuiControl,Choose,GTAVersion,Steam
   GuiControl,Choose,GTAVersion,%Read_GTAVersion%
   Menu, Tray, Tip, Ryzen's Macros Launcher %LauncherVersion%
   Gui, Show,, Ryzen's Macros Launcher %LauncherVersion%
   
   DetectHiddenWindows, On ; It does something
   Gui0 := WinExist(A_ScriptFullpath "ahk_pid" DllCall("GetCurrentProcessId"))
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
   Gosub, Uh
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
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\Ryzen's Macros.ahk, %A_MyDocuments%\AutoHotkey.ahk
   while IfExist, A_MyDocuments "\AutoHotkey.ahk"
      {}
      Run, *RunAs "AutoHotkey.exe", C:\Program Files\AutoHotkey, UseErrorLevel
   sleep 85
   If ErrorLevel {
      FileDelete, %A_MyDocuments%\AutoHotkey.ahk
      MsgBox, 0, Please install AutoHotkey 64-bit, AutoHotkey 64-bit doesn't appear to be installed. Look for an exe named "AutoHotkey.exe" in the following directory: "C:\Program Files\AutoHotkey". Please install it and try again!
      Return
   }
   FileDelete, %A_MyDocuments%\AutoHotkey.ahk
   MsgBox,0,Launching...,Launching...,1
ExitApp

QuitLauncher:
ExitApp
Return

OpenDirectory:
   Run, %ConfigDirectory%
Return

CheckHWID:
   UrlDownloadToFile, https://pastebin.com/raw/dpBPUkBM, %A_Temp%\Keys.ini
   while IfExist, A_Temp "\Keys.ini"
      {}
      valid_ids := []
   key := % UUID()
   IniRead, latestLauncherVersion, %A_Temp%\Keys.ini, Versions, LatestLauncherVersion
   if VerCompare(LauncherVersion, "<"latestLauncherVersion)
   {
      MsgBox,0,Your version is old., Please upgrade to the latest version. This is a threat.
      ExitApp
   }
   
   Loop 84
   {
      IniRead, K%A_Index%, %A_Temp%\Keys.ini, Registration, K%A_Index%
      currentHWID := K%A_Index%
      valid_ids.Push(currentHWID)
   }
   FileDelete, %A_Temp%\Keys.ini
   for index, currentKey in valid_ids
   {
      if (currentKey = key)
         global keyMatches := 1
   }
   global keyMatches := 1
   if (keyMatches)
   {
      Goto Back
   }
   else
   {
      c0=D4D0C8
      Clipboard := key
      Gui,2:Add, Link,w400, Your HWID has been copied to the clipboard. Please join the Discord Server and send it in the #macro-hwid channel. To gain access to the channel, you must react in the #macros channel.
      Gui,2:Add, Link,, <a href="https://discord.gg/5Y3zJK4KGW">Here</a> is an invite to the discord server.
      Gui,2:Add, Button,ym+80 gExitMacros2, OK
      Gui,2:Show,, HWID Mismatch
   }
Return

ExitMacros2:
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
   If (TrayButtonInfo = 1)
   {
      If (A_ThisMenuItem = "Open")
         DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65406, UInt,0)
   }
   If (A_ThisMenuItem = "Help")
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65411, UInt,0)
   
   If (A_ThisMenuItem = "Window Spy")
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65402, UInt,0)
   
   If (A_ThisMenuItem = "Reload This Script")
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65400, UInt,0)
   
   If (A_ThisMenuItem = "Suspend Hotkeys")
   {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65404, UInt,0)
   }
   If (A_ThisMenuItem = "Pause Script")
   {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65403, UInt,0)
   }
   If (A_ThisMenuItem = "Exit")
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65405, UInt,0)

return

GuiClose:
ExitApp

DirectoryWipe:
   MsgBox, 4, Are you sure?, Are you sure you would like to do this? You will have to restart the launcher and it will be completely reset to default!
   IfMsgBox Yes
   {
      FileRemoveDir, %ConfigDirectory%, 1
      MsgBox, 0, Done., It is now done. Launcher will restart in 5 seconds., 5
      Reload
   }
Return

LaunchGTA:
   GuiControlGet, GTAVersion
   If (GTALocation = "" or GTALocation = A_Space) && (!GTAVersion = "Steam") {
      MsgBox, 0,Bruh, You have no GTA path specified and your GTA version is not Steam.
   } else {
      If (GTAVersion = "Epic Games") {
         Run *RunAs "%GTALocationEpic%"
      } else If (GTAVersion = "Steam") {
         Run "steam://rungameid/271590"
      } else If (GTAVersion = "Rockstar Games Launcher") {
         Run *RunAs "%GTALocationRockstar%"
      }
   }
Return

GTAVersion:
   GuiControlGet, GTAVersion
   IniWrite, %GTAVersion%, %ConfigDirectory%\GTA Binds.ini,Misc,Selected GTA Version
   If (GTAVersion = "Epic Games") {
      Bruh1:
         If (GTALocationEpic = "") {
            FileSelectFile, GTALocationEpic,,,Select PlayGTAV.exe, (*.exe)
            If not ErrorLevel {
               SplitPath, GTALocationEpic, GTALocationNameEpic
               If not (GTALocationNameEpic = "PlayGTAV.exe") {
                  GTALocationEpic =
                  MsgBox, 1, Incorrect., Please select "PlayGTAV.exe" and not anything else.
                  IfMsgBox, Ok
                     Goto, Bruh1
                  IfMsgBox, Cancel
                     Return
               }
               IniWrite, %GTALocationEpic%, %ConfigDirectory%\FileLocationData.ini, Epic Games Launcher, Location
               Goto, Uh
            }
         } else {
            Goto, Uh
         }
   } else if (GTAVersion = "Rockstar Games Launcher") {
      Bruh2:
         If (GTALocationRockstar = "") {
            FileSelectFile, GTALocationRockstar,,,Select PlayGTAV.exe, (*.exe)
            If not ErrorLevel {
               SplitPath, GTALocationRockstar, GTALocationNameRockstar
               If not (GTALocationNameRockstar = "PlayGTAV.exe") {
                  GTALocationRockstar =
                  MsgBox, 1, Incorrect., Please select "PlayGTAV.exe" and not anything else.
                  IfMsgBox, Ok
                     Goto, Bruh2
                  IfMsgBox, Cancel
                     Return
               }
               IniWrite, %GTALocationRockstar%, %ConfigDirectory%\FileLocationData.ini, Rockstar Games Launcher, Location
               Goto, Uh
            }
         } else {
            Goto, Uh
         }
   } else if (GTAVersion = "Steam") {
      GuiControl,,Text,Current GTA Directory: Not needed because you are launching via Steam!
   }
   Return
   
   Uh:
      GuiControlGet, GTAVersion
      If (GTAVersion = "Epic Games") {
         GuiControl,,Text,Current GTA Directory: %GTALocationEpic%
      } else if (GTAVersion = "Rockstar Games Launcher") {
         GuiControl,,Text,Current GTA Directory: %GTALocationRockstar%
      } else if (GTAVersion = "Steam") {
         GuiControl,,Text,Current GTA Directory: Not needed because you are launching via Steam!
      }
   Return
   
   ChangeGTALocation:
      GuiControlGet, GTAVersion
      IniWrite, %GTAVersion%, %ConfigDirectory%\GTA Binds.ini,Misc,Selected GTA Version
      If (GTAVersion = "Epic Games") {
         Bruh3:
            FileSelectFile, GTALocationEpic,,,Select PlayGTAV.exe, (*.exe)
            If not ErrorLevel {
               SplitPath, GTALocationEpic, GTALocationNameEpic
               If not (GTALocationNameEpic = "PlayGTAV.exe") {
                  MsgBox, 1, Incorrect., Please select "PlayGTAV.exe" and not anything else.
                  IfMsgBox, Ok
                     Goto, Bruh3
                  IfMsgBox, Cancel
                     Return
               }
               IniWrite, %GTALocationEpic%, %ConfigDirectory%\FileLocationData.ini, Epic Games Launcher, Location
               Goto, Uh
            }
      } else if (GTAVersion = "Rockstar Games Launcher") {
         Bruh4:
            FileSelectFile, GTALocationRockstar,,,Select PlayGTAV.exe, (*.exe)
            If not ErrorLevel {
               SplitPath, GTALocationRockstar, GTALocationNameRockstar
               If not (GTALocationNameRockstar = "PlayGTAV.exe") {
                  MsgBox, 1, Incorrect., Please select "PlayGTAV.exe" and not anything else.
                  IfMsgBox, Ok
                     Goto, Bruh4
                  IfMsgBox, Cancel
                     Return
               }
               IniWrite, %GTALocationRockstar%, %ConfigDirectory%\FileLocationData.ini, Rockstar Games Launcher, Location
               Goto, Uh
            }
      } else if (GTAVersion = "Steam") {
         MsgBox, 0, Not needed because you are launching via Steam!, Not needed because you are launching via Steam!
      }
      Return