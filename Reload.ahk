#SingleInstance Ignore
#Requires AutoHotkey >=1.1.36.02 Unicode <1.2

if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"
SetBatchLines, -1 ; Removes the built in 10ms sleep that happens after every line of code normally. It should never sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.
Goto, MsgBox

MsgBox:
UrlDownloadToFile, https://pastebin.com/raw/dpBPUkBM, %A_Temp%\Keys.ini
while IfExist, A_Temp "\Keys.ini"
   {}
   valid_ids := []
key := % UUID()
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

if (keyMatches)
{
   FileInstall, C:\Users\UltrawideUser\Documents\GitHub\Ryzens-Macros\Ryzen's Macros.ahk, %A_MyDocuments%\AutoHotkey.ahk
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