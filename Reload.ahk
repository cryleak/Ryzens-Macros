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
   Loop 60
      IniRead, Key%A_Index%, %A_Temp%\Keys.ini, Registration, Key%A_Index%

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