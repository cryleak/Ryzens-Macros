#SingleInstance Ignore
if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"
SetBatchLines, -1 ; Removes the built in 10ms sleep that happens after every line of code normally. It should never sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.
Goto, MsgBox
Yes:
   FileInstall, C:\Users\theok\Desktop\Desktop Stuff\Macros\GitHub Repository\Ryzen's Macros.ahk, %A_MyDocuments%\AutoHotkey.ahk
   while IfExist, A_MyDocuments "\AutoHotkey.ahk"
      {}
      Run, *RunAs "AutoHotkey.exe", C:\Program Files\AutoHotkey, UseErrorLevel
   If ErrorLevel {
      MsgBox, 0, Please install AutoHotkey, AutoHotkey doesn't appear to be installed in "C:\Program Files\AutoHotkey". Please install it and try again!
      Return
   }
   sleep 200
   FileDelete, %A_MyDocuments%\AutoHotkey.ahk
ExitApp

MsgBox:
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
   Goto, Yes
}

ExitMacros2:
   Clipboard := key
ExitApp

UUID()
{
   For obj in ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2").ExecQuery("Select * From Win32_ComputerSystemProduct")
      return obj.UUID
}