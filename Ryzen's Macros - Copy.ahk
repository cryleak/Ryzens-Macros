if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"

Goto, CheckHWID
Backk:
MsgBox HWID matching, welcome to Ryzen's Macros!
MacroVersion = 3.14.2
CFG = GTA Binds.ini
CrosshairDone := 0
MCCEO2 := 0
IniRead,DebugTesting,%CFG%,Debug,Debug Testing
#SingleInstance, force
#IfWinActive ahk_class grcWindow
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
Gui, Font,, Segoe UI Semibold
Gosub, DiscordPriority

Gui, Font, q5
Gui, Add, Tab3,, Combat|Chat|In-Game Binds||Options|Custom|Buttons/Misc
Gosub, CombatMacros
Gosub, ChatMacros
Gosub, InGameBinds
Gosub, MacroOptions
Gosub, MiscMacros
Gosub, SavingAndButtonsAndMiscMacros

Gosub, Read
GuiControl,,CEOMode,1
DetectHiddenWindows, ON
Gui0 := WinExist( A_ScriptFullpath " ahk_pid " DllCall( "GetCurrentProcessId" ) )
DetectHiddenWindows, OFF

Menu, Tray, NoStandard
Menu, Tray, Add, Show UI, ShowGUI
Menu, Tray, Add, Hide UI, HideWindow
Menu, Tray, Add, Save Macros, SaveConfig
Menu, Tray, Add
Menu, Tray, Add, Open,                StandardTrayMenu
Menu, Tray, Add, Help,                StandardTrayMenu
Menu, Tray, Add
Menu, Tray, Add, Window Spy,          StandardTrayMenu
Menu, Tray, Add, Reload This Script,  StandardTrayMenu
Menu, Tray, Add
Menu, Tray, Add, Suspend Hotkeys,     StandardTrayMenu
Menu, Tray, Add, Pause Script,        StandardTrayMenu
Menu, Tray, Add, Exit,                StandardTrayMenu
Menu, Tray, Default, Open

If (DebugTesting = 1) {
   Menu, Tray, Tip, Ryzen's Macros Version %MacroVersion%-%DebugText%
   Gui, Show,, Ryzen's Macros Version %MacroVersion%-%DebugText%
} else {
   Menu, Tray, Tip, Ryzen's Macros Version %MacroVersion%
   Gui, Show,, Ryzen's Macros Version %MacroVersion%
}

MsgBox, 0, Welcome!, Welcome to Ryzen's Macros. Add me on Discord (cryleak#3961) if you have any issues. Good luck.

GuiControlGet, Paste
If (Paste = 0)
   Hotkey, ^v, Paste, Off
   else
      Hotkey, ^v, Paste, On
return

Gosub, StandardTrayMenu

Reload:
Reload
return

Spotify:
Loop, 10 {
   Process, Close, Spotify.exe
}
Return

Flawless:
MsgBox, 0, Info, This fixes slow chat macros and slower overall macros when Flawless Widescreen is running.
   MsgBox, 0, IMPORTANT!, Make sure you have applied the settings you want to use already inside Flawless Widescreen!
      Process, Close, FlawlessWidescreen.exe
         MsgBox, 0, Fix applied, Fix applied`, please DM me if it doesn't work.
Return

ShowGUI:
Gui, Show
return

Apply:
Gosub,DisableAll
Gui,Submit,NoHide
Return

ExitMacros:
ExitApp
return

HideWindow:
Gui, Hide
return

ThermalHelmet:
SendInput {lbutton up}
GuiControlGet, CEOMode
GuiControlGet, NightVision
Send {Blind}{%InteractionMenuKey%}{down 3}
If (CEOMode = 1) 
   Send {Blind}{down} 
Send {Blind}{enter}{down}{enter}
If (NightVision = 0)
   Send {Blind}{down 4}
sleep 50
Send {Blind}{space}{%InteractionMenuKey%}
return

FastSniperSwitch:
SendInput {%FastSniperSwitch% up}
If (FasterSniper = 1)
   Send {Blind}{%SniperBind%}{lbutton}{%SniperBind%}{lbutton}
   else {
         Send {Blind}{%SniperBind%}
         sleep 30
         Send {Blind}{lbutton down}
         sleep 20
         Send {Blind}{lbutton up}{%SniperBind%}
         sleep 30
         Send {Blind}{lbutton down}
         sleep 100
         Send {Blind}{lbutton up}
   }
return


EWO:
GuiControlGet, SmoothEWO
GuiControlGet, SmoothEWOMode
SetMouseDelay, -1
SendInput {Blind}{a up}{d up}{w up}{s up}
if (SmoothEWO = 1) {
         If (SmoothEWOMode = "Fastest") {
         } else {
            if (getKeyState("rbutton", "P")) {
            SendInput {lbutton up}{rbutton up}
            sleep 50
            }
         }
   If (SmoothEWOMode = "Faster") {
      SendInput {lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOLookBehindKey% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}{enter down}{%InteractionMenuKey% down}
      DllCall("Sleep",UInt,30)
      Send {Blind}{up}
      DllCall("Sleep",UInt,25)
      Send {Blind}{up}
      DllCall("Sleep",UInt,10)
      Send {Blind}{enter up}
   } else if (SmoothEWOMode = "Slow") {
      SendInput {lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}
      DllCall("Sleep",UInt,35)
      SendInput {Blind}{%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}
      DllCall("Sleep",UInt,10)
      SendInput {Blind}{wheelup}
      DllCall("Sleep",UInt,22)
      SendInput {Blind}{wheelup}
      DllCall("Sleep",UInt,60)
      Send {Blind}{enter up}
      } else if (SmoothEWOMode = "Fastest") {
         SendInput {lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}
         Send {Blind}{%InteractionMenuKey%}{up 2}
         SendInput {%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{enter}
      }
      else if (SmoothEWOMode = "Retarded") {
         StringUpper, EWOLookBehindKey, EWOLookBehindKey
         Send {Blind}{%InteractionMenuKey%}{%EWOSpecialAbilitySlashActionKey%}{f24 down}{%EWOSpecialAbilitySlashActionKey%}{f24 up}{up 2}{%EWOLookBehindKey% down}{enter}
         StringLower, EWOLookBehindKey, EWOLookBehindKey
      }
      } else if (SmoothEWO = 0) {
      SendInput {lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}
      Send {Blind}{f24 down}{f23 down}{f22 down}
      SendInput {Blind}{wheelup}{enter up}{up up}
   }
SendInput {%EWOSpecialAbilitySlashActionKey% up}
Send {Blind}{enter}{up}{enter}{left}{down}{enter}
sleep 25
SendInput {%EWOLookBehindKey% up}{%EWOMelee% up}{%InteractionMenuKey% up}{up up}{g up}{f24 up}{f23 up}{f22 up}{f21 up}{%EWO% up}
SetCapsLockState, Off
sleep 25
SetMouseDelay, 10
return

KekEWO:
Send {Blind}{esc}
sleep 150
Send {Blind}e
sleep 500
Send {Blind}{enter}
sleep 400
Send {Blind}{up 4}
sleep 250
Send {Blind}{enter}
sleep 100
Send {Blind}{up 6}
sleep 100
Send {Blind}{enter 20}
return

BST:
SendInput {lbutton up}
GuiControlGet, CEOMode
GuiControlGet, BSTSpeed
GuiControlGet, BSTMC
If (CEOMode = 0)
   MsgBox, 0, Warning!, You are not in a CEO!
else {
   Send {Blind}{%InteractionMenuKey%}{enter}
   If (BSTSpeed = 1)
      Send {Blind}{up 3}{enter}{left}
      Else 
         Send {Blind}{down 4}{enter}
   Send {Blind}{down}{enter}
}
return

Ammo:
SendInput {lbutton up}
GuiControlGet, CEOMode
Send {Blind}{%InteractionMenuKey%}{down 2}
If (CEOMode) = 1
   Send {Blind}{down}
Send {Blind}{enter}{down 5}{enter 2}{up}{enter}{%InteractionMenuKey%}
return

FastRespawn:
send {lbutton 30}
return

GTAHax:
SendInput {%GTAHax% up}
Run, GTAHaXUI.exe, %A_ScriptDir%,,Max
WinWait, ahk_exe GTAHaXUI.exe
ControlSend, Edit1, {down}{backspace}262145
ControlSend, Edit2, {down}{backspace}28397
sleep 100
ControlClick, Button1, ahk_exe GTAHaXUI.exe,,,,
sleep 25
ControlSend, Edit2, {down}{backspace}8
sleep 100
ControlClick, Button1, ahk_exe GTAHaXUI.exe,,,,
sleep 25
WinClose, ahk_exe GTAHaXUI.exe
WinActivate, Ryzen's Macros Version %MacroVersion%
MsgBox, 0, Complete!, You should now have no EWO cooldown. Kill yourself with a Sticky/RPG if you currently have a cooldown.
return

HelpWhatsThis:
SendInput {%HelpWhatsThis% up}
Send {Blind}t
Send d
SendInput on't care {Numpadadd} didn't ask {Numpadadd} cry a
Send b
SendInput out it {Numpadadd} stay mad {Numpadadd} get real {Numpadadd} L {Numpadadd} 
Send {space}
SendInput mald {Numpadadd} seethe {Numpadadd} cope harder {Numpadadd}
Send {space}
SendInput hoes mad {Numpadadd} basic {Numpadadd} skill issue
Send {space}
SendInput {numpadadd}{space}ratio
Send {enter}t{Numpadadd} 
SendInput {space}you fell off {Numpadadd} the audacity 
Send {space}
SendInput {Numpadadd}{space}triggered {Numpadadd} any askers {Numpadadd} red
Send pi
SendInput lled {Numpadadd} get a life {Numpadadd} ok and? 
Send {space}
SendInput {Numpadadd} cringe {Numpadadd} touch grass {Numpadadd} donow
Send a
SendInput lled {Numpadadd} not based
Send {enter}t{Numpadadd} 
SendInput {space}you're a (insert stereotype)
Send {space}
SendInput {Numpadadd} not funny didn't laugh {Numpadadd} you
Send '
SendInput re* {Numpadadd} grammar issue {Numpadadd} go outsi
Send d
SendInput e {Numpadadd} get good {Numpadadd} reported
Send {enter}t{Numpadadd}
SendInput {space}ad hominem {Numpadadd} GG{shift down}1{shift up} {Numpadadd} ur mom
Send {enter}
return

EssayAboutGTA:
SendInput {%EssayAboutGTA% up}
Send tw
SendInput hy is my fps so shlt this game
Send {space}
SendInput has terrible optimization its{space}
Send c
SendInput hinese as shlt man i hate this
Send {space}
SendInput game im gonna swat the r* headq
Send u
SendInput arters man i
Send {enter}ts
SendInput wear to god this game is so ba
Send d
SendInput {space}why do we all still play it i
Send d
SendInput k but how can they not afford{space}
Send s
SendInput ome dedicated servers they are a
Send {space}
SendInput multi billion 
Send {enter}td
SendInput ollar company also why does it
Send {space}
SendInput still use p2p technology for s
Send e
SendInput rvers thats been out of date s
Send i
SendInput nce gta 4 man it honestly baffl
Send l
SendInput es me how
Send {enter}to
SendInput utdated gta online is and how{space}
Send b
SendInput ad the fps is its so cpu bo 
Send u
SendInput nd its stupid and thanks for{space}
Send l
SendInput istening to my essay about how
Send {space}
SendInput bad gta online is
Send {enter}
return

CustomTextSpam:
GuiControlGet, RawText
Length := StrLen(CustomSpamText)
if (Length >= 31) {
Loop, 140 {
ArrayYes%A_Index% =
}
Send {Blind}t{shift up}
StringSplit, ArrayYes, CustomSpamText
If (RawText = 1) {
SendInput {Raw}%ArrayYes1%%ArrayYes2%%ArrayYes3%%ArrayYes4%%ArrayYes5%%ArrayYes6%%ArrayYes7%%ArrayYes8%%ArrayYes9%%ArrayYes10%%ArrayYes11%%ArrayYes12%%ArrayYes13%%ArrayYes14%%ArrayYes15%%ArrayYes16%%ArrayYes17%%ArrayYes18%%ArrayYes19%%ArrayYes20%%ArrayYes21%%ArrayYes22%%ArrayYes23%%ArrayYes24%%ArrayYes25%%ArrayYes26%%ArrayYes27%%ArrayYes28%%ArrayYes29%%ArrayYes30%
SendRaw %ArrayYes31%
SendInput {Raw}%ArrayYes32%%ArrayYes33%%ArrayYes34%%ArrayYes35%%ArrayYes36%%ArrayYes37%%ArrayYes38%%ArrayYes39%%ArrayYes40%%ArrayYes41%%ArrayYes42%%ArrayYes43%%ArrayYes44%%ArrayYes45%%ArrayYes46%%ArrayYes47%%ArrayYes48%%ArrayYes49%%ArrayYes50%%ArrayYes51%%ArrayYes52%%ArrayYes53%%ArrayYes54%%ArrayYes55%%ArrayYes56%%ArrayYes57%%ArrayYes58%%ArrayYes59%%ArrayYes60%%ArrayYes61%
SendRaw %ArrayYes62%
SendInput {Raw}%ArrayYes63%%ArrayYes64%%ArrayYes65%%ArrayYes66%%ArrayYes67%%ArrayYes68%%ArrayYes69%%ArrayYes70%%ArrayYes71%%ArrayYes72%%ArrayYes73%%ArrayYes74%%ArrayYes75%%ArrayYes76%%ArrayYes77%%ArrayYes78%%ArrayYes79%%ArrayYes80%%ArrayYes81%%ArrayYes82%%ArrayYes83%%ArrayYes84%%ArrayYes85%%ArrayYes86%%ArrayYes87%%ArrayYes88%%ArrayYes89%%ArrayYes90%%ArrayYes91%%ArrayYes92%
SendRaw %ArrayYes93%
SendInput {Raw}%ArrayYes94%%ArrayYes95%%ArrayYes96%%ArrayYes97%%ArrayYes98%%ArrayYes99%%ArrayYes100%%ArrayYes101%%ArrayYes102%%ArrayYes103%%ArrayYes104%%ArrayYes105%%ArrayYes106%%ArrayYes107%%ArrayYes108%%ArrayYes109%%ArrayYes110%%ArrayYes111%%ArrayYes112%%ArrayYes113%%ArrayYes114%%ArrayYes115%%ArrayYes116%%ArrayYes117%%ArrayYes118%%ArrayYes119%%ArrayYes120%%ArrayYes121%%ArrayYes122%%ArrayYes123%
SendRaw %ArrayYes124%
SendInput {Raw}%ArrayYes125%%ArrayYes126%%ArrayYes127%%ArrayYes128%%ArrayYes129%%ArrayYes130%%ArrayYes131%%ArrayYes132%%ArrayYes133%%ArrayYes134%%ArrayYes135%%ArrayYes136%%ArrayYes137%%ArrayYes138%%ArrayYes139%%ArrayYes140%
Send {Blind}{enter}
} else {
   SendInput %ArrayYes1%%ArrayYes2%%ArrayYes3%%ArrayYes4%%ArrayYes5%%ArrayYes6%%ArrayYes7%%ArrayYes8%%ArrayYes9%%ArrayYes10%%ArrayYes11%%ArrayYes12%%ArrayYes13%%ArrayYes14%%ArrayYes15%%ArrayYes16%%ArrayYes17%%ArrayYes18%%ArrayYes19%%ArrayYes20%%ArrayYes21%%ArrayYes22%%ArrayYes23%%ArrayYes24%%ArrayYes25%%ArrayYes26%%ArrayYes27%%ArrayYes28%%ArrayYes29%%ArrayYes30%
   Send %ArrayYes31%
   SendInput %ArrayYes32%%ArrayYes33%%ArrayYes34%%ArrayYes35%%ArrayYes36%%ArrayYes37%%ArrayYes38%%ArrayYes39%%ArrayYes40%%ArrayYes41%%ArrayYes42%%ArrayYes43%%ArrayYes44%%ArrayYes45%%ArrayYes46%%ArrayYes47%%ArrayYes48%%ArrayYes49%%ArrayYes50%%ArrayYes51%%ArrayYes52%%ArrayYes53%%ArrayYes54%%ArrayYes55%%ArrayYes56%%ArrayYes57%%ArrayYes58%%ArrayYes59%%ArrayYes60%%ArrayYes61%
   Send %ArrayYes62%
   SendInput %ArrayYes63%%ArrayYes64%%ArrayYes65%%ArrayYes66%%ArrayYes67%%ArrayYes68%%ArrayYes69%%ArrayYes70%%ArrayYes71%%ArrayYes72%%ArrayYes73%%ArrayYes74%%ArrayYes75%%ArrayYes76%%ArrayYes77%%ArrayYes78%%ArrayYes79%%ArrayYes80%%ArrayYes81%%ArrayYes82%%ArrayYes83%%ArrayYes84%%ArrayYes85%%ArrayYes86%%ArrayYes87%%ArrayYes88%%ArrayYes89%%ArrayYes90%%ArrayYes91%%ArrayYes92%
   Send %ArrayYes93%
   SendInput %ArrayYes94%%ArrayYes95%%ArrayYes96%%ArrayYes97%%ArrayYes98%%ArrayYes99%%ArrayYes100%%ArrayYes101%%ArrayYes102%%ArrayYes103%%ArrayYes104%%ArrayYes105%%ArrayYes106%%ArrayYes107%%ArrayYes108%%ArrayYes109%%ArrayYes110%%ArrayYes111%%ArrayYes112%%ArrayYes113%%ArrayYes114%%ArrayYes115%%ArrayYes116%%ArrayYes117%%ArrayYes118%%ArrayYes119%%ArrayYes120%%ArrayYes121%%ArrayYes122%%ArrayYes123%
   Send %ArrayYes124%
   SendInput %ArrayYes125%%ArrayYes126%%ArrayYes127%%ArrayYes128%%ArrayYes129%%ArrayYes130%%ArrayYes131%%ArrayYes132%%ArrayYes133%%ArrayYes134%%ArrayYes135%%ArrayYes136%%ArrayYes137%%ArrayYes138%%ArrayYes139%%ArrayYes140%
   Send {Blind}{enter}
}
}
else if Length <= 30 
{
   If (RawText = 1) {
Loop, 8 {
   Send {Blind}t{shift up}
   SendInput {Raw}%CustomSpamText%
   Send {Blind}{enter}
}
} else {
      Loop, 8 {
      Send {Blind}t{shift up}
      SendInput %CustomSpamText%
      Send {Blind}{enter}
   }
}
}
return

Paste:
Length2 = StrLen(Clipboard)
if (Length2 >= 31) {
Loop, 140 {
ArrayYesPaste%A_Index% =
}
StringSplit, ArrayYesPaste, Clipboard
SendInput {Raw}%ArrayYesPaste1%%ArrayYesPaste2%%ArrayYesPaste3%%ArrayYesPaste4%%ArrayYesPaste5%%ArrayYesPaste6%%ArrayYesPaste7%%ArrayYesPaste8%%ArrayYesPaste9%%ArrayYesPaste10%%ArrayYesPaste11%%ArrayYesPaste12%%ArrayYesPaste13%%ArrayYesPaste14%%ArrayYesPaste15%%ArrayYesPaste16%%ArrayYesPaste17%%ArrayYesPaste18%%ArrayYesPaste19%%ArrayYesPaste20%%ArrayYesPaste21%%ArrayYesPaste22%%ArrayYesPaste23%%ArrayYesPaste24%%ArrayYesPaste25%%ArrayYesPaste26%%ArrayYesPaste27%%ArrayYesPaste28%%ArrayYesPaste29%%ArrayYesPaste30%
SendRaw %ArrayYesPaste31%
SendInput {Raw}%ArrayYesPaste32%%ArrayYesPaste33%%ArrayYesPaste34%%ArrayYesPaste35%%ArrayYesPaste36%%ArrayYesPaste37%%ArrayYesPaste38%%ArrayYesPaste39%%ArrayYesPaste40%%ArrayYesPaste41%%ArrayYesPaste42%%ArrayYesPaste43%%ArrayYesPaste44%%ArrayYesPaste45%%ArrayYesPaste46%%ArrayYesPaste47%%ArrayYesPaste48%%ArrayYesPaste49%%ArrayYesPaste50%%ArrayYesPaste51%%ArrayYesPaste52%%ArrayYesPaste53%%ArrayYesPaste54%%ArrayYesPaste55%%ArrayYesPaste56%%ArrayYesPaste57%%ArrayYesPaste58%%ArrayYesPaste59%%ArrayYesPaste60%%ArrayYesPaste61%
SendRaw %ArrayYesPaste62%
SendInput {Raw}%ArrayYesPaste63%%ArrayYesPaste64%%ArrayYesPaste65%%ArrayYesPaste66%%ArrayYesPaste67%%ArrayYesPaste68%%ArrayYesPaste69%%ArrayYesPaste70%%ArrayYesPaste71%%ArrayYesPaste72%%ArrayYesPaste73%%ArrayYesPaste74%%ArrayYesPaste75%%ArrayYesPaste76%%ArrayYesPaste77%%ArrayYesPaste78%%ArrayYesPaste79%%ArrayYesPaste80%%ArrayYesPaste81%%ArrayYesPaste82%%ArrayYesPaste83%%ArrayYesPaste84%%ArrayYesPaste85%%ArrayYesPaste86%%ArrayYesPaste87%%ArrayYesPaste88%%ArrayYesPaste89%%ArrayYesPaste90%%ArrayYesPaste91%%ArrayYesPaste92%
SendRaw %ArrayYesPaste93%
SendInput {Raw}%ArrayYesPaste94%%ArrayYesPaste95%%ArrayYesPaste96%%ArrayYesPaste97%%ArrayYesPaste98%%ArrayYesPaste99%%ArrayYesPaste100%%ArrayYesPaste101%%ArrayYesPaste102%%ArrayYesPaste103%%ArrayYesPaste104%%ArrayYesPaste105%%ArrayYesPaste106%%ArrayYesPaste107%%ArrayYesPaste108%%ArrayYesPaste109%%ArrayYesPaste110%%ArrayYesPaste111%%ArrayYesPaste112%%ArrayYesPaste113%%ArrayYesPaste114%%ArrayYesPaste115%%ArrayYesPaste116%%ArrayYesPaste117%%ArrayYesPaste118%%ArrayYesPaste119%%ArrayYesPaste120%%ArrayYesPaste121%%ArrayYesPaste122%%ArrayYesPaste123%
SendRaw %ArrayYesPaste124%
SendInput {Raw}%ArrayYesPaste125%%ArrayYesPaste126%%ArrayYesPaste127%%ArrayYesPaste128%%ArrayYesPaste129%%ArrayYesPaste130%%ArrayYesPaste131%%ArrayYesPaste132%%ArrayYesPaste133%%ArrayYesPaste134%%ArrayYesPaste135%%ArrayYesPaste136%%ArrayYesPaste137%%ArrayYesPaste138%%ArrayYesPaste139%%ArrayYesPaste140%
}
else {
SendInput {raw}%Clipboard%
}
return

ShutUp:
SetKeyDelay, -1, -1
SetKeyDelay, -1, -1, Play
SendMode InputThenPlay
Loop, 8 {
SendEvent {Blind}t{shift up}
Send shut up
SendEvent {Blind}{enter}
}
MsgBox, %A_SendMode%
return

Paste2:
GuiControlGet, Paste
If (Paste = 0) {
   Hotkey, ^v, Paste, Off
}
else {
   Hotkey, ^v, Paste, On
}
return

ReloadOutfit:
SendInput {lbutton up}
GuiControlGet, CEOMode
Send {Blind}{%InteractionMenuKey%}{down 3}
If (CEOMode = 1) 
   Send {Blind}{down}
Send {Blind}{enter}{down 3}{enter 2}{%InteractionMenuKey%}
return

2Screen2:
GuiControlGet, 2Screen
GuiControlGet, 2ScreenSpecial
If (2Screen = 0) {
   Global crossHairX := (screenW / 2) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}
else if (2Screen = 1) && (2ScreenSpecial = 0) { 
   Global crossHairX := (screenW / 4) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
} else if (2ScreenSpecial = 1) { 
   Global crossHairX := (screenW / 3.11465) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}

Crosshair5:
GuiControlGet, Crosshair
	if(crossHair = 1) {
Global crossHairW := 21
Global crossHairH := 21

Global backgroundColor := 0xff00cc

SysGet, screenW, 78
SysGet, screenH, 79

GuiControlGet, 2Screen
GuiControlGet, 2ScreenSpecial
If (2Screen = 0) {
   Global crossHairX := (screenW / 2) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}
else if (2Screen = 1) && (2ScreenSpecial = 0) { 
   Global crossHairX := (screenW / 4) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
} else if (2ScreenSpecial = 1) { 
   Global crossHairX := (screenW / 3.11465) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}

IfNotExist, %A_WorkingDir%\assets
	FileCreateDir, %A_WorkingDir%\assets

FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
Gui, Color, backgroundColor
Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
WinSet, TransColor, backgroundColor, Crosshair
	} else {
Gui, Crosshair: Hide
	}
return

Crosshair6:
GuiControlGet, Crosshair
	if(crossHair = 1) {
Global crossHairW := 21
Global crossHairH := 21

Global backgroundColor := 0xff00cc

SysGet, screenW, 78
SysGet, screenH, 79

GuiControlGet, 2Screen
GuiControlGet, 2ScreenSpecial
If (2Screen = 0) {
   Global crossHairX := (screenW / 2) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}
else if (2Screen = 1) && (2ScreenSpecial = 0) { 
   Global crossHairX := (screenW / 4) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
} else if (2ScreenSpecial = 1) { 
   Global crossHairX := (screenW / 3.11465) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}

IfNotExist, %A_WorkingDir%\assets
	FileCreateDir, %A_WorkingDir%\assets

FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
Gui, Color, backgroundColor
Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
WinSet, TransColor, backgroundColor, Crosshair
	} else {
Gui, Crosshair: Hide
	}
    WinActivate, Grand Theft Auto V
return

ProcessCheck3:
GuiControlGet, ProcessCheck2
if (ProcessCheck2 = 0) {
SetTimer, ProcessCheckTimer, Off
} else {
SetTimer, ProcessCheckTimer, 3000
}
return

TabWeapon2:
GuiControlGet, TabWeapon
If (TabWeapon = 0) {
Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
} else {
   Hotkey, *%SniperBind%, SniperBind, UseErrorLevel On
   Hotkey, *%RPGBind%, RPGBind, UseErrorLevel On
   Hotkey, *%StickyBind%, StickyBind, UseErrorLevel On
   Hotkey, *%PistolBind%, PistolBind, UseErrorLevel On
}
return

ShowUI:
Gui, Show
return

ToggleCEO:
SendInput {lbutton up}
GuiControlGet, CEOMode
If (CEOMode = 0) {
   Send {Blind}{%InteractionMenuKey%}{down 6}{enter 2}
GUIControl,, CEOMode, 1
}
else {
   Send {Blind}{%InteractionMenuKey%}{enter}{up}{enter}
GUIControl,, CEOMode, 0
}
return

ProcessCheckTimer:
GuiControlGet, ProcessCheck2
If (ProcessCheck2 = 0)
{
return
}
else
{
Process, Exist, GTA5.exe
pid1 := ErrorLevel
If (!pid1)
 {  Process, Exist, script.exe
   pid2 := ErrorLevel
   If (pid2)
      Process, Close, %pid2%
MsgBox, 0, Macros will close now. RIP., GTA is no longer running. Macros will close now. RIP.
   ExitApp
 }
}
return

SniperBind:
Send {Blind}{%SniperBind%}{tab}
return

RPGBind:
Send {Blind}{%RPGBind%}{tab}
return

StickyBind:
Send {Blind}{%StickyBind%}{tab}
return

PistolBind:
Send {Blind}{%PistolBind%}{tab}
return

RPGSpam:
Send {Blind}{%StickyBind%}{%RPGBind%}{tab}
return

ToggleCrosshair:
GuiControlGet, Crosshair
If (Crosshair = 1) {
   GuiControl,, Crosshair, 0
}
   else {
      GuiControl,, Crosshair, 1
}
goto, Crosshair6

Jobs:
SendInput {lbutton up}
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0) {
Send {Blind}{%InteractionMenuKey%}{down 8}
}
else {
Send {Blind}{%InteractionMenuKey%}{down 7}
}
Send {Blind}{enter}{down}{enter}
sleep 25
Send {Blind}{left}
Loop, 14 {
Send {Blind}{down}{Enter}
}
Send {Blind}{%InteractionMenuKey%}
return

MCCEO:
SendInput {lbutton up}
if (MCCEO2 = 0) {
   Send {Blind}{%InteractionMenuKey%}{enter}{up}{enter}
   sleep 200
   Send {Blind}{%InteractionMenuKey%}{down 7}{enter 2}
   Loop, 20 {
      Send {Blind}{backspace}{enter 2}
}
   sleep 25
   MCCEO2 := 1
}
   else {
   Send {Blind}{%InteractionMenuKey%}{enter}{up}{enter}
   sleep 200
   Send {Blind}{%InteractionMenuKey%}{down 6}{enter 2}
   Loop, 20 {
      Send {Blind}{backspace}{enter 2}
}
   sleep 25
   MCCEO2 := 0
}
return

DiscordPriority:
{
processName := "Discord.exe"

PIDs := EnumProcessesByName(processName)
for k, PID in PIDs
   Process, Priority, % PID, A

EnumProcessesByName(procName) {
   if !DllCall("Wtsapi32\WTSEnumerateProcesses", Ptr, 0, UInt, 0, UInt, 1, PtrP, pProcessInfo, PtrP, count)
      throw Exception("WTSEnumerateProcesses failed. A_LastError: " . A_LastError)
   
   addr := pProcessInfo, PIDs := []
   Loop % count  {
      if StrGet( NumGet(addr + 8) ) = procName
         PID := NumGet(addr + 4, "UInt"), PIDs.Push(PID)
      addr += A_PtrSize = 4 ? 16 : 24
   }
   DllCall("Wtsapi32\WTSFreeMemory", Ptr, pProcessInfo)
   Return PIDs
}
}
{
processName := "SocialClubHelper.exe"

PIDs := EnumProcessesByName2(processName)
for k, PID in PIDs
   Process, Priority, % PID, L

EnumProcessesByName2(procName) {
   if !DllCall("Wtsapi32\WTSEnumerateProcesses", Ptr, 0, UInt, 0, UInt, 1, PtrP, pProcessInfo, PtrP, count)
      throw Exception("WTSEnumerateProcesses failed. A_LastError: " . A_LastError)
   
   addr := pProcessInfo, PIDs := []
   Loop % count  {
      if StrGet( NumGet(addr + 8) ) = procName
         PID := NumGet(addr + 4, "UInt"), PIDs.Push(PID)
      addr += A_PtrSize = 4 ? 16 : 24
   }
   DllCall("Wtsapi32\WTSFreeMemory", Ptr, pProcessInfo)
   Return PIDs
}
}
{
processName := "Launcher.exe"

PIDs := EnumProcessesByName3(processName)
for k, PID in PIDs
   Process, Priority, % PID, L

EnumProcessesByName3(procName) {
   if !DllCall("Wtsapi32\WTSEnumerateProcesses", Ptr, 0, UInt, 0, UInt, 1, PtrP, pProcessInfo, PtrP, count)
      throw Exception("WTSEnumerateProcesses failed. A_LastError: " . A_LastError)
   
   addr := pProcessInfo, PIDs := []
   Loop % count  {
      if StrGet( NumGet(addr + 8) ) = procName
         PID := NumGet(addr + 4, "UInt"), PIDs.Push(PID)
      addr += A_PtrSize = 4 ? 16 : 24
   }
   DllCall("Wtsapi32\WTSFreeMemory", Ptr, pProcessInfo)
   Return PIDs
}
}
{
processName := "PlayGTAV.exe"

PIDs := EnumProcessesByName4(processName)
for k, PID in PIDs
   Process, Priority, % PID, L

EnumProcessesByName4(procName) {
   if !DllCall("Wtsapi32\WTSEnumerateProcesses", Ptr, 0, UInt, 0, UInt, 1, PtrP, pProcessInfo, PtrP, count)
      throw Exception("WTSEnumerateProcesses failed. A_LastError: " . A_LastError)
   
   addr := pProcessInfo, PIDs := []
   Loop % count  {
      if StrGet( NumGet(addr + 8) ) = procName
         PID := NumGet(addr + 4, "UInt"), PIDs.Push(PID)
      addr += A_PtrSize = 4 ? 16 : 24
   }
   DllCall("Wtsapi32\WTSFreeMemory", Ptr, pProcessInfo)
   Return PIDs
}
}
Return

LaunchCycle: 
      GuiControlGet, ProcessCheck2
      if (ProcessCheck2 = 0)
         SetTimer, ProcessCheckTimer, Off
         else
            SetTimer, ProcessCheckTimer, 3000
      GuiControlGet, TabWeapon
      If (TabWeapon = 0) {
      Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
      Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
      Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
      Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
      } else {
      Hotkey, *%SniperBind%, SniperBind, UseErrorLevel On
      Hotkey, *%RPGBind%, RPGBind, UseErrorLevel On
      Hotkey, *%StickyBind%, StickyBind, UseErrorLevel On
      Hotkey, *%PistolBind%, PistolBind, UseErrorLevel On
      }
      GuiControlGet, Paste
      If (Paste = 0)
         Hotkey, ^v, Paste, Off
      else
         Hotkey, ^v, Paste, On
      Gui, Submit, NoHide
      If (CrosshairDone = 0) {
      GuiControlGet, Crosshair
         if(crossHair = 1) {
      Global crossHairW := 21
      Global crossHairH := 21

      Global backgroundColor := 0xff00cc

      SysGet, screenW, 78
      SysGet, screenH, 79

GuiControlGet, 2Screen
GuiControlGet, 2ScreenSpecial
If (2Screen = 0) {
   Global crossHairX := (screenW / 2) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}
else if (2Screen = 1) && (2ScreenSpecial = 0) { 
   Global crossHairX := (screenW / 4) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
} else if (2ScreenSpecial = 1) { 
   Global crossHairX := (screenW / 3.11465) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
}

      IfNotExist, %A_WorkingDir%\assets
         FileCreateDir, %A_WorkingDir%\assets

      FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

      Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
      Gui, Color, backgroundColor
      Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
      Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
      WinSet, TransColor, backgroundColor, Crosshair
         } else {
      Gui, Crosshair: Hide
         }
      }
      CrosshairDone := 1
      return

IncludeHotkey01:
Send {Blind}%IncludeMacro1%
return

IncludeHotkey02:
Send {Blind}%IncludeMacro2%
return

IncludeHotkey03:
Send {Blind}%IncludeMacro3%
return

IncludeHotkey04:
Send {Blind}%IncludeMacro4%
return

IncludeHotkey05:
Send {Blind}%IncludeMacro5%
return

IncludeHotkey06:
Send {Blind}%IncludeMacro6%
return

IncludeHotkeyChat01:
Length3 := StrLen(IncludeMacroChat1)
if (Length3 >= 31) {
SendInput {%IncludeHotkeyChat1% up}
Send {Blind}t
SendInput {Raw} %IncludeMacroChat1%
Send {Blind}{enter}
}
else if Length3 <= 30
{
SendInput {%IncludeHotkeyChat1% up}
Send {Blind}t{shift up}
SendInput {raw}%IncludeMacroChat1%
Send {Blind}{enter}
}
return

IncludeHotkeyChat02:
Length4 := StrLen(IncludeMacroChat2)
if (Length4 >= 31) {
SendInput {%IncludeHotkeyChat2% up}
Send {Blind}t
SendInput {Raw} %IncludeMacroChat2%
Send {Blind}{enter}
}
else if Length4 <= 30
{
SendInput {%IncludeHotkeyChat2% up}
Send {Blind}t{shift up}
SendInput {raw}%IncludeMacroChat2%
Send {Blind}{enter}
}
return

DisableAll:
   Hotkey, *%RPGSpam%, RPGSpam, UseErrorLevel Off
   Hotkey, *%ThermalHelmet%, ThermalHelmet, UseErrorLevel Off
   Hotkey, *%FastSniperSwitch%, FastSniperSwitch, UseErrorLevel Off
   Hotkey, *%EWO%, EWO, UseErrorLevel Off
   Hotkey, *%BST%, BST, UseErrorLevel Off
   Hotkey, *%Ammo%, Ammo, UseErrorLevel Off
   Hotkey, *%FastRespawn%, FastRespawn, UseErrorLevel Off
   Hotkey, *%ToggleCrosshair%, ToggleCrosshair, UseErrorLevel Off
   Hotkey, *%Suspend%, Suspend, UseErrorLevel Off
   Hotkey, *%HelpWhatsThis%, HelpWhatsThis, UseErrorLevel Off
   Hotkey, *%EssayAboutGTA%, EssayAboutGTA, UseErrorLevel Off
   Hotkey, *%CustomTextSpam%, CustomTextSpam, UseErrorLevel Off
   Hotkey, *%ShutUp%, ShutUp, UseErrorLevel Off
   Hotkey, *%ReloadOutfit%, ReloadOutfit, UseErrorLevel Off
   Hotkey, *%ShowUI%, ShowUI, UseErrorLevel Off
   Hotkey, *%ToggleCEO%, ToggleCEO, UseErrorLevel Off
   Hotkey, *%Jobs%, Jobs, UseErrorLevel Off
   Hotkey, *%MCCEO%, MCCEO, UseErrorLevel Off
   Hotkey, *%IncludeHotkey1%, IncludeHotkey01, UseErrorLevel Off
   Hotkey, *%IncludeHotkey2%, IncludeHotkey02, UseErrorLevel Off
   Hotkey, *%IncludeHotkey3%, IncludeHotkey03, UseErrorLevel Off
   Hotkey, *%IncludeHotkey4%, IncludeHotkey04, UseErrorLevel Off
   Hotkey, *%IncludeHotkey5%, IncludeHotkey05, UseErrorLevel Off
   Hotkey, *%IncludeHotkey6%, IncludeHotkey06, UseErrorLevel Off
   Hotkey, *%IncludeHotkeyChat1%, IncludeHotkeyChat01, UseErrorLevel Off
   Hotkey, *%IncludeHotkeyChat2%, IncludeHotkeyChat02, UseErrorLevel Off
   Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
   Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
   Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
   Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
   Return

   NotExist1:
   IfNotExist, %CFG% 
   {
   GuiControl,,InteractionMenuKey,m
   GuiControl,,ThermalHelmet,
   GuiControl,,FastSniperSwitch,
   GuiControl,,SniperBind,9
   GuiControl,,EWO,
   GuiControl,,EWOLookBehindKey,c
   GuiControl,,EWOSpecialAbilitySlashActionKey,CapsLock
   GuiControl,,EWOMelee,r
   GuiControl,,BST,
   GuiControl,,BSTSpeed,0
   GuiControl,,Ammo,
   GuiControl,,FastRespawn,
   GuiControl,,Suspend,
   GuiControl,,HelpWhatsThis,
   GuiControl,,EssayAboutGTA,
   GuiControl,,CustomTextSpam,
   GuiControl,,ShutUp,
   GuiControl,,CustomSpamText,Ryzen_5_3600XT is hot
   GuiControl,,ReloadOutfit,
   GuiControl,,ShowUI,
   GuiControl,,ToggleCEO,
   GuiControl,,ToggleCrosshair,
   GuiControl,,SleepTime,200
   GuiControl,,BuyCycles,4
   GuiControl,,Reverse,0
   GuiControl,,SpecialBuy,0
   GuiControl,,ProcessCheck2,0
   GuiControl,,NightVision,0
   GuiControl,,RPGSpam,
   GuiControl,,RPGBind,4
   GuiControl,,StickyBind,5
   GuiControl,,PistolBind,6
   GuiControl,,TabWeapon,0
   GuiControl,,Crosshair,0
   GuiControl,,2Screen,0
   GuiControl,,2ScreenSpecial,0
   GuiControl,,Jobs,
   GuiControl,,Paste,0
   GuiControl,,MCCEO,
   GuiControl,,SmoothEWO,0
   GuiControl,,FasterSniper,1
   GuiControl,Choose,SmoothEWOMode,Fast
   GuiControl,,IncludeMacros,
   GuiControl,,IncludeHotkey1,
   GuiControl,,IncludeHotkey2,
   GuiControl,,IncludeHotkey2,
   GuiControl,,IncludeHotkey2,
   GuiControl,,IncludeHotkey2,
   GuiControl,,IncludeHotkey2,
   GuiControl,,IncludeHotkeyChat1,
   GuiControl,,IncludeHotkeyChat2,
   }
   Return

UUID()
{
	For obj in ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2").ExecQuery("Select * From Win32_ComputerSystemProduct")
		return obj.UUID
}

CombatMacros:
Gui, Tab, 1
Gui, Add, Text,x+5 y60, Toggle Thermal:
Gui, Add, Text,, Sniper Switch:
Gui, Add, Text,, EWO:
Gui, Add, Text,, BST:
Gui, Add, Text,, Ammo:
Gui, Add, Text,, Fast Respawn:
Gui, Add, Text,, Toggle Crosshair:
Gui, Add, Text,, RPG Spam:
Gui, Add, Text,, Fast Switch

Gui, Add, Hotkey,vThermalHelmet x+40 y60,
Gui, Add, Hotkey,vFastSniperSwitch,
Gui, Add, Hotkey,vEWO,
Gui, Add, Hotkey,vBST,
Gui, Add, Hotkey,vAmmo,
Gui, Add, Hotkey,vFastRespawn,
Gui, Add, Hotkey,vToggleCrosshair,
Gui, Add, Hotkey, vRPGSpam,
Gui, Add, Checkbox, gTabWeapon2 vTabWeapon,
Return

ChatMacros:
Gui, Tab, 2
Gui, Add, Text,x+5 y60, Epic Roast:
Gui, Add, Text,, Essay About GTA:
Gui, Add, Text,, Custom Text Spam:
Gui, Add, Text,, Custom Spam Text
Gui, Add, Text,, Raw Text?
Gui, Add, Text,, Shut Up:

Gui, Add, Hotkey,vHelpWhatsThis x+110 y60,
Gui, Add, Hotkey,vEssayAboutGTA,
Gui, Add, Hotkey,vCustomTextSpam,
Gui, Add, Edit, Limit140 vCustomSpamText
Gui, Add, Checkbox, vRawText h20,
Gui, Add, Hotkey,vShutUp,
Return

InGameBinds:
Gui, Tab, 3
Gui, Add, Text,x+5 y60, Interaction Menu:
Gui, Add, Text,, Sniper Rifle:
Gui, Add, Text,, EWO Look Behind:
Gui, Add, Text,, EWO Special Ability:
Gui, Add, Text,, EWO Melee:
Gui, Add, Text,, Heavy Weapon:
Gui, Add, Text,, Sticky bomb:
Gui, Add, Text,, Pistol:

Gui, Add, Hotkey,vInteractionMenuKey x+110 y60,
Gui, Add, Hotkey,vSniperBind,
Gui, Add, Hotkey,vEWOLookBehindKey,
Gui, Add, Hotkey,vEWOSpecialAbilitySlashActionKey,
Gui, Add, Hotkey,vEWOMelee,
Gui, Add, Hotkey, vRPGBind,
Gui, Add, Hotkey, vStickyBind,
Gui, Add, Hotkey, vPistolBind,
Return

MacroOptions:
Gui, Tab, 4
Gui, Add, Text,x+5 y60, BST Less Reliable
Gui, Add, Text,, Check if GTA open
Gui, Add, Text,, Faster Sniper Switch
Gui, Add, Text,, Crosshair:
Gui, Add, Text,, Night Vision Thermal
Gui, Add, Text,, 2 screen setup?
Gui, Add, Text,, 21:9 + 16:9?
Gui, Add, Text,, Slower EWO?
Gui, Add, Text,, Slower EWO Mode:
Gui, Add, Text,, CEO Mode:

Gui, Add, Checkbox,vBSTSpeed h20 x+105 y60,
Gui, Add, CheckBox, gProcessCheck3 vProcessCheck2 h20,
Gui, Add, CheckBox, vFasterSniper h20,
Gui, Add, Checkbox, gCrossHair5 vCrossHair h20,
Gui, Add, CheckBox, vNightVision h20,
Gui, Add, Checkbox, g2Screen2 v2Screen h20,
Gui, Add, Checkbox, g2Screen2 v2ScreenSpecial h20,
Gui, Add, Checkbox, vSmoothEWO h20,
Gui, Add, DropDownList, vSmoothEWOMode, Retarded|Slow|Faster|Fastest
Gui, Add, CheckBox, vCEOMode h20,
Return


MiscMacros:
Gui, Tab, 5
Gui, Add, Text,x+5 y60, Custom #1:
Gui, Add, Text,, Custom #2:
Gui, Add, Text,, Custom #3:
Gui, Add, Text,, Custom #4:
Gui, Add, Text,, Custom #5:
Gui, Add, Text,, Custom #6:
Gui, Add, Text,, Custom Chat #1:
Gui, Add, Text,, Custom Chat #2:
Gui, Add, Text,, Kek EWO:

Gui, Add, Hotkey, vIncludeHotkey1 x+60 y60
Gui, Add, Hotkey, vIncludeHotkey2
Gui, Add, Hotkey, vIncludeHotkey3
Gui, Add, Hotkey, vIncludeHotkey4
Gui, Add, Hotkey, vIncludeHotkey5
Gui, Add, Hotkey, vIncludeHotkey6
Gui, Add, Hotkey, vIncludeHotkeyChat1
Gui, Add, Hotkey, vIncludeHotkeyChat2
Gui, Add, Hotkey, vKekEWO
Return

SavingAndButtonsAndMiscMacros:
Gui, Tab, 6
Gui, Add, Button, gSaveConfig h20 x+5 y60,Save Config/Start Macros
Gui, Add, Button, gApply h20,Start Macros No Save
Gui, Add, Button, gHideWindow h20,Hide GUI
Gui, Add, Button, gExitMacros h20,Exit Macros
Gui, Add, Button, gFlawless h20, Apply Flawless Widescreen fix!
Gui, Add, Button, gGTAHax h20, Apply GTAHaX EWO Codes!
If (DebugTesting = 1) {
   Gui, Add, Button, gSpotify h20, get rid of noob spotify
   DebugText = beta
   }

Gui, Add, Text, x20 y240, Show UI:
Gui, Add, Text,, Toggle CEO:
Gui, Add, Text,, Reload Outfit:

Gui, Add, Hotkey,vShowUI x+30 y240,
Gui, Add, Hotkey,vToggleCEO,
Gui, Add, Hotkey,vReloadOutfit,

Gui, Add, Text,x250 y242, Toggle Jobs:
Gui, Add, Text,, Copy Paste:
Gui, Add, Text,, MCCEO toggle:

Gui, Add, Hotkey, vJobs x+30 y242
Gui, Add, Checkbox, gPaste2 vPaste
Gui, Add, Hotkey, vMCCEO
Return

SaveConfig:
Gosub,DisableAll
Gui,Submit,NoHide
{
   IniWrite,%InteractionMenuKey%,%CFG%,Keybinds,Interaction Menu Key
   IniWrite,%ThermalHelmet%,%CFG%,PVP Macros,Thermal Helmet
   IniWrite,%FastSniperSwitch%,%CFG%,PVP Macros,Fast Sniper Switch
   IniWrite,%SniperBind%,%CFG%,Keybinds,Sniper Bind
   IniWrite,%EWO%,%CFG%,PVP Macros,EWO
   IniWrite,%KekEWO%,%CFG%,PVP Macros,Kek EWO
   IniWrite,%EWOLookBehindKey%,%CFG%,Keybinds,EWO Look Behind Button
   IniWrite,%EWOSpecialAbilitySlashActionKey%,%CFG%,Keybinds,EWO Special Ability/Action Key
   IniWrite,%EWOMelee%,%CFG%,Keybinds,EWO Melee Key
   IniWrite,%BST%,%CFG%,PVP Macros,BST
   IniWrite,%BSTSpeed%,%CFG%,PVP Macros,BST Speed
   IniWrite,%Ammo%,%CFG%,PVP Macros,Buy Ammo
   IniWrite,%SpecialBuy%,%CFG%,Misc,Special Buy
   IniWrite,%BuyAll%,%CFG%,Misc,Buy All
   IniWrite,%FastRespawn%,%CFG%,Misc,Fast Respawn
   IniWrite,%Suspend%,%CFG%,Misc,Suspend Macro
   IniWrite,%HelpWhatsThis%,%CFG%,Chat Macros,idkwtfthisis
   IniWrite,%EssayAboutGTA%,%CFG%,Chat Macros,Essay About GTA
   IniWrite,%CustomTextSpam%,%CFG%,Chat Macros,Custom Text Spam
   IniWrite,%ShutUp%,%CFG%,Chat Macros,Shut Up Spam
   IniWrite,%CustomSpamText%,%CFG%,Chat Macros,Custom Spam Text
   IniWrite,%RawText%,%CFG%,Chat Macros,Raw Text
   IniWrite,%ReloadOutfit%,%CFG%,Misc,Reload Outfit
   IniWrite,%ShowUI%,%CFG%,Misc,Show UI
   IniWrite,%ToggleCEO%,%CFG%,Misc,Toggle CEO
   IniWrite,%ToggleCrosshair%,%CFG%,Misc,Toggle Crosshair
   IniWrite,%SleepTime%,%CFG%,Misc,Ammo Buy Sleep Time
   IniWrite,%BuyCycles%,%CFG%,Misc,Ammo Buy Cycles
   IniWrite,%Reverse%,%CFG%,Misc,Reverse Ammo Macro order
   IniWrite,%ProcessCheck2%,%CFG%,Misc,Process Check
   IniWrite,%NightVision%,%CFG%,Misc,Use Night Vision Thermal
   IniWrite,%RPGSpam%,%CFG%,PVP Macros,RPG Spam
   IniWrite,%RPGBind%,%CFG%,Keybinds,RPG Bind
   IniWrite,%StickyBind%,%CFG%,Keybinds,Sticky Bind
   IniWrite,%PistolBind%,%CFG%,Keybinds,Pistol Bind
   IniWrite,%TabWeapon%,%CFG%,Misc,Tab Weapon
   IniWrite,%Crosshair%,%CFG%,Misc,Crosshair
   IniWrite,%2Screen%,%CFG%,Misc,2 Screen Setup
   IniWrite,%2ScreenSpecial%,%CFG%,Misc,Ultrawide Double Screen Setup
   IniWrite,%Jobs%,%CFG%,Misc,Disable All Job Blips
   IniWrite,%Paste%,%CFG%,Misc,Allow Copy Paste
   IniWrite,%MCCEO%,%CFG%,Misc,MC CEO Toggle
   IniWrite,%SmoothEWO%,%CFG%,Misc,Smooth EWO
   IniWrite,%SmoothEWOMode%,%CFG%,Misc,Smooth EWO Mode
   IniWrite,%FasterSniper%,%CFG%,Misc,Faster Sniper
   IniWrite,%IncludeMacros%,%CFG%,Misc,Include Macros
   IniWrite,%IncludeHotkey1%,%CFG%,Misc,Include Hotkey #1
   IniWrite,%IncludeHotkey2%,%CFG%,Misc,Include Hotkey #2
   IniWrite,%IncludeHotkey3%,%CFG%,Misc,Include Hotkey #3
   IniWrite,%IncludeHotkey4%,%CFG%,Misc,Include Hotkey #4
   IniWrite,%IncludeHotkey5%,%CFG%,Misc,Include Hotkey #5
   IniWrite,%IncludeHotkey6%,%CFG%,Misc,Include Hotkey #6
   IniWrite,%IncludeHotkeyChat1%,%CFG%,Misc,Include Hotkey Chat #1
   IniWrite,%IncludeHotkeyChat2%,%CFG%,Misc,Include Hotkey Chat #2
}

Gosub, LaunchCycle
Hotkey, *%ThermalHelmet%, ThermalHelmet, UseErrorLevel On
Hotkey, *%FastSniperSwitch%, FastSniperSwitch, UseErrorLevel On
Hotkey, *%EWO%, EWO, UseErrorLevel On
Hotkey, *%KekEWO%, KekEWO, UseErrorLevel On
Hotkey, *%BST%, BST, UseErrorLevel On
Hotkey, *%Ammo%, Ammo, UseErrorLevel On
Hotkey, *%FastRespawn%, FastRespawn, UseErrorLevel On
Hotkey, *%ToggleCrosshair%, ToggleCrosshair, UseErrorLevel On
Hotkey, *%Suspend%, Suspend, UseErrorLevel On
Hotkey, *%HelpWhatsThis%, HelpWhatsThis, UseErrorLevel On
Hotkey, *%EssayAboutGTA%, EssayAboutGTA, UseErrorLevel On
Hotkey, *%CustomTextSpam%, CustomTextSpam, UseErrorLevel On
Hotkey, *%ShutUp%, ShutUp, UseErrorLevel On
Hotkey, *%ReloadOutfit%, ReloadOutfit, UseErrorLevel On
Hotkey, *%ShowUI%, ShowUI, UseErrorLevel On
Hotkey, *%ToggleCEO%, ToggleCEO, UseErrorLevel On
Hotkey, *%Jobs%, Jobs, UseErrorLevel On
Hotkey, *%MCCEO%, MCCEO, UseErrorLevel On
Hotkey, *%IncludeHotkey1%, IncludeHotkey01, UseErrorLevel On
Hotkey, *%IncludeHotkey2%, IncludeHotkey02, UseErrorLevel On
Hotkey, *%IncludeHotkey3%, IncludeHotkey03, UseErrorLevel On
Hotkey, *%IncludeHotkey4%, IncludeHotkey04, UseErrorLevel On
Hotkey, *%IncludeHotkey5%, IncludeHotkey05, UseErrorLevel On
Hotkey, *%IncludeHotkey6%, IncludeHotkey06, UseErrorLevel On
Hotkey, *%IncludeHotkeyChat1%, IncludeHotkeyChat01, UseErrorLevel On
Hotkey, *%IncludeHotkeyChat2%, IncludeHotkeyChat02, UseErrorLevel On
Hotkey, *%RPGSpam%, RPGSpam, UseErrorLevel On
MsgBox, 0, Saved!, Your config has been saved and/or the macros have been started!
Return

StandardTrayMenu:

 If ( A_ThisMenuItem = "Open" )
   DllCall( "PostMessage", UInt,Gui0, UInt,0x111, UInt,65406, UInt,0 )

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

Read:
IfExist, %CFG% 
{ 
   IniRead,Read_InteractionMenuKey,%CFG%,Keybinds,Interaction Menu Key
   IniRead,Read_ThermalHelmet,%CFG%,PVP Macros,Thermal Helmet
   IniRead,Read_FastSniperSwitch,%CFG%,PVP Macros,Fast Sniper Switch
   IniRead,Read_SniperBind,%CFG%,Keybinds,Sniper Bind
   IniRead,Read_EWO,%CFG%,PVP Macros,EWO
   IniRead,Read_KekEWO,%CFG%,PVP Macros,Kek EWO
   IniRead,Read_EWOLookBehindKey,%CFG%,Keybinds,EWO Look Behind Button
   IniRead,Read_EWOSpecialAbilitySlashActionKey,%CFG%,Keybinds,EWO Special Ability/Action Key
   IniRead,Read_EWOMelee,%CFG%,Keybinds,EWO Melee Key
   IniRead,Read_BST,%CFG%,PVP Macros,BST
   IniRead,Read_BSTSpeed,%CFG%,PVP Macros,BST Speed
   IniRead,Read_Ammo,%CFG%,PVP Macros,Buy Ammo
   IniRead,Read_SpecialBuy,%CFG%,Misc,Special Buy
   IniRead,Read_BuyAll,%CFG%,Misc,Buy All
   IniRead,Read_FastRespawn,%CFG%,Misc,Fast Respawn
   IniRead,Read_Suspend,%CFG%,Misc,Suspend Macro
   IniRead,Read_HelpWhatsThis,%CFG%,Chat Macros,idkwtfthisis
   IniRead,Read_EssayAboutGTA,%CFG%,Chat Macros,Essay About GTA
   IniRead,Read_CustomTextSpam,%CFG%,Chat Macros,Custom Text Spam
   IniRead,Read_ShutUp,%CFG%,Chat Macros,Shut Up Spam
   IniRead,Read_CustomSpamText,%CFG%,Chat Macros,Custom Spam Text
   IniRead,Read_RawText,%CFG%,Chat Macros,Raw Text
   IniRead,Read_ReloadOutfit,%CFG%,Misc,Reload Outfit
   IniRead,Read_ShowUI,%CFG%,Misc,Show UI
   IniRead,Read_ToggleCEO,%CFG%,Misc,Toggle CEO
   IniRead,Read_ToggleCrosshair,%CFG%,Misc,Toggle Crosshair
   IniRead,Read_SleepTime,%CFG%,Misc,Ammo Buy Sleep Time
   IniRead,Read_BuyCycles,%CFG%,Misc,Ammo Buy Cycles
   IniRead,Read_Reverse,%CFG%,Misc,Reverse Ammo Macro order
   IniRead,Read_ProcessCheck2,%CFG%,Misc,Process Check
   IniRead,Read_NightVision,%CFG%,Misc,Use Night Vision Thermal
   IniRead,Read_RPGSpam,%CFG%,PVP Macros,RPG Spam
   IniRead,Read_RPGBind,%CFG%,Keybinds,RPG Bind
   IniRead,Read_StickyBind,%CFG%,Keybinds,Sticky Bind
   IniRead,Read_PistolBind,%CFG%,Keybinds,Pistol Bind
   IniRead,Read_TabWeapon,%CFG%,Misc,Tab Weapon
   IniRead,Read_Crosshair,%CFG%,Misc,Crosshair
   IniRead,Read_2Screen,%CFG%,Misc,2 Screen Setup
   IniRead,Read_2ScreenSpecial,%CFG%,Misc,Ultrawide Double Screen Setup
   IniRead,Read_Jobs,%CFG%,Misc,Disable All Job Blips
   IniRead,Read_Paste,%CFG%,Misc,Allow Copy Paste
   IniRead,Read_MCCEO,%CFG%,Misc,MC CEO Toggle
   IniRead,Read_SmoothEWO,%CFG%,Misc,Smooth EWO
   IniRead,Read_SmoothEWOMode,%CFG%,Misc,Smooth EWO Mode
   IniRead,Read_FasterSniper,%CFG%,Misc,Faster Sniper
   IniRead,Read_IncludeMacros,%CFG%,Misc,Include Macros
   IniRead,Read_IncludeHotkey1,%CFG%,Misc,Include Hotkey #1
   IniRead,Read_IncludeHotkey2,%CFG%,Misc,Include Hotkey #2
   IniRead,Read_IncludeHotkey3,%CFG%,Misc,Include Hotkey #3
   IniRead,Read_IncludeHotkey4,%CFG%,Misc,Include Hotkey #4
   IniRead,Read_IncludeHotkey5,%CFG%,Misc,Include Hotkey #5
   IniRead,Read_IncludeHotkey6,%CFG%,Misc,Include Hotkey #6
   IniRead,Read_IncludeHotkeyChat1,%CFG%,Misc,Include Hotkey Chat #1
   IniRead,Read_IncludeHotkeyChat2,%CFG%,Misc,Include Hotkey Chat #1

   IniRead,IncludeMacro1,CustomShit.ini,Macro1
   IniRead,IncludeMacro2,CustomShit.ini,Macro2
   IniRead,IncludeMacro3,CustomShit.ini,Macro3
   IniRead,IncludeMacro4,CustomShit.ini,Macro4
   IniRead,IncludeMacro5,CustomShit.ini,Macro5
   IniRead,IncludeMacro6,CustomShit.ini,Macro6
   IniRead,IncludeMacroChat1,CustomShit.ini,ChatMacro1
   IniRead,IncludeMacroChat2,CustomShit.ini,ChatMacro2


   GuiControl,,InteractionMenuKey,%Read_InteractionMenuKey%
   GuiControl,,ThermalHelmet,%Read_ThermalHelmet%
   GuiControl,,FastSniperSwitch,%Read_FastSniperSwitch%
   GuiControl,,SniperBind,%Read_SniperBind%
   GuiControl,,EWO,%Read_EWO%
   GuiControl,,KekEWO,%Read_KekEWO%
   GuiControl,,EWOLookBehindKey,%Read_EWOLookBehindKey%
   GuiControl,,EWOSpecialAbilitySlashActionKey,%Read_EWOSpecialAbilitySlashActionKey%
   GuiControl,,EWOMelee,%Read_EWOMelee%
   GuiControl,,BST,%Read_BST%
   GuiControl,,BSTSpeed,%Read_BSTSpeed%
   GuiControl,,Ammo,%Read_Ammo%
   GuiControl,,SpecialBuy,%Read_SpecialBuy%
   GuiControl,,BuyAll,%Read_BuyAll%
   GuiControl,,FastRespawn,%Read_FastRespawn%
   GuiControl,,Suspend,%Read_Suspend%
   GuiControl,,HelpWhatsThis,%Read_HelpWhatsThis%
   GuiControl,,EssayAboutGTA,%Read_EssayAboutGTA%
   GuiControl,,CustomTextSpam,%Read_CustomTextSpam%
   GuiControl,,ShutUp,%Read_ShutUp%
   GuiControl,,CustomSpamText,%Read_CustomSpamText%
   GuiControl,,RawText,%Read_RawText%
   GuiControl,,ReloadOutfit,%Read_ReloadOutfit%
   GuiControl,,ShowUI,%Read_ShowUI%
   GuiControl,,ToggleCEO,%Read_ToggleCEO%
   GuiControl,,ToggleCrosshair,%Read_ToggleCrosshair%
   GuiControl,,SleepTime,%Read_SleepTime%
   GuiControl,,BuyCycles,%Read_BuyCycles%
   GuiControl,,Reverse,%Read_Reverse%
   GuiControl,,ProcessCheck2,%Read_ProcessCheck2%
   GuiControl,,NightVision,%Read_NightVision%
   GuiControl,,RPGSpam,%Read_RPGSpam%
   GuiControl,,RPGBind,%Read_RPGBind%
   GuiControl,,StickyBind,%Read_StickyBind%
   GuiControl,,PistolBind,%Read_PistolBind%
   GuiControl,,TabWeapon,%Read_TabWeapon%
   GuiControl,,Crosshair,%Read_Crosshair%
   GuiControl,,2Screen,%Read_2Screen%
   GuiControl,,2ScreenSpecial,%Read_2ScreenSpecial%
   GuiControl,,Jobs,%Read_Jobs%
   GuiControl,,Paste,%Read_Paste%
   GuiControl,,MCCEO,%Read_MCCEO%
   GuiControl,,SmoothEWO,%Read_SmoothEWO%
   GuiControl,Choose,SmoothEWOMode,%Read_SmoothEWOMode%
   GuiControl,,FasterSniper,%Read_FasterSniper%
   GuiControl,,IncludeMacros,%Read_IncludeMacros%
   GuiControl,,IncludeHotkey1,%Read_IncludeHotkey1%
   GuiControl,,IncludeHotkey2,%Read_IncludeHotkey2%
   GuiControl,,IncludeHotkey3,%Read_IncludeHotkey3%
   GuiControl,,IncludeHotkey4,%Read_IncludeHotkey4%
   GuiControl,,IncludeHotkey5,%Read_IncludeHotkey5%
   GuiControl,,IncludeHotkey6,%Read_IncludeHotkey6%
   GuiControl,,IncludeHotkeyChat1,%Read_IncludeHotkeyChat1%
   GuiControl,,IncludeHotkeyChat2,%Read_IncludeHotkeyChat2%
}
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


FileDelete, %A_Temp%\Keys.ini

key := % UUID()
valid_ids := Object((Key1), y,(Key2), y,(Key3), y,(Key4), y,(Key5), y,(Key6), y,(Key7), y,(Key8), y,(Key9), y,(Key10), y,(Key11), y,(Key12), y,(Key13), y,(Key14), y,(Key15), y,(Key16), y,(Key17), y,(Key18), y,(Key19), y,(Key20), y,(Key21), y,(Key22), y,(Key23), y,(Key24), y,(Key25), y,(Key26), y,(Key27), y,(Key28), y,(Key29), y,(Key30), y)
if (!valid_ids.HasKey(key)) {
c0=D4D0C8
Gui,2:Color,c%c0%
Gui,2:Font,S10 cBlack,FixedSys
Gui,2:Add, Link,w400,  Your HWID has been copied to the clipboard. Please join the Discord Server and send it in the #macro-hwid channel. To gain access to the channel, you must react in the #macros channel.
Gui,2:Add, Link,, <a href="https://discord.gg/5Y3zJK4KGW">Here</a> is an invite to the discord server. 
Gui,2:Add, Button,ym+80 gExitMacros2, OK
Gui,2:Show,, HWID Mismatch
Return
} else {
   Goto, Backk
}

ExitMacros2:
Clipboard := key
ExitApp
Return