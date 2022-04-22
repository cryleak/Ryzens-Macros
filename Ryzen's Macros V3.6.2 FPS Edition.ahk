CFG = GTA Binds.ini
None := F23
 := F23
if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#SingleInstance, force            ; You can't start multiple instances of the macro with this on.
#IfWinActive ahk_class grcWindow  ; Disables hotkeys when alt-tabbed or GTA is closed. Restart macro if you decide to restart GTA with this enabled.
#IfWinActive Grand Theft Auto V   ; Same as above, just makes it more reliable.
#MaxThreadsPerHotkey 1            ; Absolute cancer if above 1. Doesn't increase speed.
#MaxThreads 99999                 ; Allows you to run multiple macros at once, at least I think so...
#MaxThreadsBuffer On              ; Doesn't matter as long as MaxThreadsPerHotkey is 1, otherwise turn it off or you will get cancer.
#MaxHotkeysPerInterval 99000000   ; You will get an error message if you reach this limit, so I increased it to a ridiculously high number, so that can't happen.
#KeyHistory 0                     ; Useful for debugging, displays what keys you have pressed. Reduces performance when on though.
#HotkeyInterval 99000000          ; You will get an error message if you reach this limit, so I increased it to a ridiculously high number, so that can't happen.     
ListLines Off                     ; Useful for debugging. Improves performance with it off.
SetTitleMatchMode, 2
SetBatchLines, -1
SetDefaultMouseSpeed, 0           ; Could theoretically increase speed in some situations.
SetKeyDelay, -1, -1               ; Always increases speed. Always use, and no it won't reduce reliability by much...
SetWinDelay, -1                   ; Window delay between window commands, it helps speed sometimes.
SetControlDelay, -1               ; Control-modifying command delay, sometimes helps.
Process, Priority, GTA5.exe, H    ; Sets the task priority of GTA V to high, which in theory should improve FPS, mostly on lower end systems
SetWorkingDir %A_ScriptDir%       ; Ensures a consistent starting directory. Helps for some shit.
Goto, DiscordPriority             ; Automatically excecutes DiscordPriority when you start the script, which sets Discords's priority to High, which should make it more usable now that we increased the priority of GTA to High, and it also changes some other applications to Low.
Macro:
Gui, Font, q5
Gui, Add, Picture, x0 y0 w675 h-1 +0x4000000, %A_ScriptDir%/assets/image.png
Gui, Add, Text,ym, Interaction Menu Bind:
Gui, Add, Text,, Thermal Helmet Macro:
Gui, Add, Text,, Fast Sniper Switch Macro:
Gui, Add, Text,, Sniper Rifle (in-game) Bind:
Gui, Add, Text,, Instant EWO Macro:
Gui, Add, Text,, EWO Look Behind (in-game) Bind:
Gui, Add, Text,, EWO Special Ability (in-game) Bind:
Gui, Add, Text,, BST Macro:
Gui, Add, Text,, Ammo Macro:
Gui, Add, Text,, Ammo buy wait time (ms):
Gui, Add, Text,, Ammo weapons to buy:
Gui, Add, Text,, Fast Respawn Macro:
Gui, Add, Text,, Suspend:
Gui, Add, Text,, GTA Hax EWO Codes Macro:

Gui, Add, Hotkey,vInteractionMenuKey ym,
Gui, Add, Hotkey,vThermalHelmet,
Gui, Add, Hotkey,vFastSniperSwitch,
Gui, Add, Hotkey,vSniperBind,
Gui, Add, Hotkey,vEWO,
Gui, Add, Hotkey,vEWOLookBehindKey,
Gui, Add, Hotkey,vEWOSpecialAbilitySlashActionKey,
Gui, Add, Hotkey,vBST,
Gui, Add, Hotkey,vAmmo,
Gui, Add, Edit,Number vSleepTime,
Gui, Add, Edit,Number vBuyCycles,
Gui, Add, Hotkey,vFastRespawn,
Gui, Add, Hotkey,vSuspend,
Gui, Add, Hotkey,vGTAHax,PrintScreen

Gui, Add, Text,ys y10, Epic Roast Chat Macro:
Gui, Add, Text,, Essay About GTA Chat Macro:
Gui, Add, Text,, Custom Text Spam Chat Macro:
Gui, Add, Text,, Custom Spam Text (30 character limit):
Gui, Add, Text,, Shut Up Chat Macro:
Gui, Add, Text,, Reload Outfit:
Gui, Add, Text,, Show UI:
Gui, Add, Text,, Toggle CEO Mode:
Gui, Add, Text,, Close macros if GTA is closed?
Gui, Add, Text,, CEO/VIP/MC mode:
Gui, Add, Text,, AW Mode:
Gui, Add, Text,, Use Night Vision for Thermal Macro?

Gui, Add, Hotkey,vHelpWhatsThis yn y10,
Gui, Add, Hotkey,vEssayAboutGTA,
Gui, Add, Hotkey,vCustomTextSpam,
Gui, Add, Edit,vCustomSpamText
Gui, Add, Hotkey,vShutUp,
Gui, Add, Hotkey,vReloadOutfit,
Gui, Add, Hotkey,vShowUI,
Gui, Add, Hotkey,vToggleCEO,
Gui, Add, CheckBox, gProcessCheck3 vProcessCheck2 h20,
Gui, Add, CheckBox, vCEOMode h20,
Gui, Add, CheckBox, gAWMode2 vAWMode h20,
Gui, Add, CheckBox, vNightVision h20,
Gui, Add, Button, gSaveConfig,Save config and start the macros!
Gui, Add, Button, gHideWindow,Hide window and start the macros!
Gui, Add, Button, gExitMacros,Exit macros

Gui, Add, Text,ys y10, AW Mode ONLY RPG Spam
Gui, Add, Text,, RPG (in-game) Bind:
Gui, Add, Text,, Sticky bomb (in-game) Bind:
Gui, Add, Text,, Pistol (in-game) Bind:
Gui, Add, Text,, Be able to use weapons after respawning (AW mode only)
Gui, Add, Text,, Crosshair (AW mode only)
Gui, Add, Text,, Do you have a 2 screen setup?

Gui, Add, Hotkey, vRPGSpam yn y10,
Gui, Add, Hotkey, vRPGBind,
Gui, Add, Hotkey, vStickyBind,
Gui, Add, Hotkey, vPistolBind,
Gui, Add, Checkbox, gTabWeapon2 vTabWeapon h20,
Gui, Add, Checkbox, gCrossHair5 vCrossHair h20,
Gui, Add, Checkbox, g2Screen2 v2Screen h20,

Gui, Font, s13 q5
Gui, Add, Text,x1350 y200, Go into Config.ini and set the bind to F23 if you want to unbind something!
Gui, Add, Text,x1350 y225, AW MODE IS UNDER CONSTRUCTION!

IniWrite,1,%CFG%,Misc,CEO Mode (always on by default. Don't change)
IniRead,Read_CEOMode,%CFG%,Misc,CEO Mode (always on by default. Don't change)
GuiControl,,CEOMode,%Read_CEOMode%

DisableCapsLock := "CapsLock"
Hotkey, *$%DisableCapsLock%, DisableCapsLock
Enter := "Enter"
Hotkey, *$%Enter%, Enter
Delete := "Del"
Hotkey, *$%Delete%, Delete

IfExist, %CFG%
{ 
IniRead,Read_InteractionMenuKey,%CFG%,Keybinds,Interaction Menu Key
IniRead,Read_ThermalHelmet,%CFG%,PVP Macros,Thermal Helmet
IniRead,Read_FastSniperSwitch,%CFG%,PVP Macros,Fast Sniper Switch
IniRead,Read_SniperBind,%CFG%,Keybinds,Sniper Bind
IniRead,Read_EWO,%CFG%,PVP Macros,EWO
IniRead,Read_EWOLookBehindKey,%CFG%,Keybinds,EWO Look Behind Button
IniRead,Read_EWOSpecialAbilitySlashActionKey,%CFG%,Keybinds,EWO Special Ability/Action Key
IniRead,Read_BST,%CFG%,PVP Macros,BST
IniRead,Read_Ammo,%CFG%,PVP Macros,Buy Ammo
IniRead,Read_FastRespawn,%CFG%,Misc,Fast Respawn
IniRead,Read_Suspend,%CFG%,Misc,Suspend Macro
IniRead,Read_GTAHax,%CFG%,Misc,GTAHax EWO Codes
IniRead,Read_HelpWhatsThis,%CFG%,Chat Macros,idkwtfthisis
IniRead,Read_EssayAboutGTA,%CFG%,Chat Macros,Essay About GTA
IniRead,Read_CustomTextSpam,%CFG%,Chat Macros,Custom Text Spam
IniRead,Read_ShutUp,%CFG%,Chat Macros,Shut Up Spam
IniRead,Read_CustomSpamText,%CFG%,Chat Macros,Custom Spam Text
IniRead,Read_ReloadOutfit,%CFG%,Misc,Reload Outfit
IniRead,Read_ShowUI,%CFG%,Misc,Show UI
IniRead,Read_ToggleCEO,%CFG%,Misc,Toggle CEO
IniRead,Read_SleepTime,%CFG%,Misc,Ammo Buy Sleep Time
IniRead,Read_BuyCycles,%CFG%,Misc,Ammo Buy Cycles
IniRead,Read_ProcessCheck2,%CFG%,Misc,Process Check
IniRead,Read_AWMode,%CFG%,Misc,AW Mode On
IniRead,Read_NightVision,%CFG%,Misc,Use Night Vision Thermal
IniRead,Read_RPGSpam,%CFG%,PVP Macros,RPG Spam
IniRead,Read_RPGBind,%CFG%,Keybinds,RPG Bind
IniRead,Read_StickyBind,%CFG%,Keybinds,Sticky Bind
IniRead,Read_PistolBind,%CFG%,Keybinds,Pistol Bind
IniRead,Read_TabWeapon,%CFG%,Misc,Tab Weapon
IniRead,Read_Crosshair,%CFG%,Misc,Crosshair
IniRead,Read_2Screen,%CFG%,Misc,2 Screen Setup

GuiControl,,InteractionMenuKey,%Read_InteractionMenuKey%
GuiControl,,ThermalHelmet,%Read_ThermalHelmet%
GuiControl,,FastSniperSwitch,%Read_FastSniperSwitch%
GuiControl,,SniperBind,%Read_SniperBind%
GuiControl,,EWO,%Read_EWO%
GuiControl,,EWOLookBehindKey,%Read_EWOLookBehindKey%
GuiControl,,EWOSpecialAbilitySlashActionKey,%Read_EWOSpecialAbilitySlashActionKey%
GuiControl,,BST,%Read_BST%
GuiControl,,Ammo,%Read_Ammo%
GuiControl,,FastRespawn,%Read_FastRespawn%
GuiControl,,Suspend,%Read_Suspend%
GuiControl,,GTAHax,%Read_GTAHax%
GuiControl,,HelpWhatsThis,%Read_HelpWhatsThis%
GuiControl,,EssayAboutGTA,%Read_EssayAboutGTA%
GuiControl,,CustomTextSpam,%Read_CustomTextSpam%
GuiControl,,ShutUp,%Read_ShutUp%
GuiControl,,CustomSpamText,%Read_CustomSpamText%
GuiControl,,ReloadOutfit,%Read_ReloadOutfit%
GuiControl,,ShowUI,%Read_ShowUI%
GuiControl,,ToggleCEO,%Read_ToggleCEO%
GuiControl,,SleepTime,%Read_SleepTime%
GuiControl,,BuyCycles,%Read_BuyCycles%
GuiControl,,ProcessCheck2,%Read_ProcessCheck2%
GuiControl,,AWMode,%Read_AWMode%
GuiControl,,NightVision,%Read_NightVision%
GuiControl,,RPGSpam,%Read_RPGSpam%
GuiControl,,RPGBind,%Read_RPGBind%
GuiControl,,StickyBind,%Read_StickyBind%
GuiControl,,PistolBind,%Read_PistolBind%
GuiControl,,TabWeapon,%Read_TabWeapon%
GuiControl,,Crosshair,%Read_Crosshair%
GuiControl,,2Screen,%Read_2Screen%
}

Menu, Tray, NoStandard
Menu, Tray, Add, Show UI, ShowGUI
Menu, Tray, Add, Hide UI, HideWindow
Menu, Tray, Add, Save Macros, SaveConfig
Menu, Tray, Add
Menu, Tray, Standard
Menu, Tray, Tip, Ryzen's Macros Version 3.6.2 FPS Edition
Gui, Show,, Ryzen's Macros Version 3.6.2 FPS Edition
GuiControlGet, AWMode
If (AWMode = 0) {
MsgBox, 0, Welcome!, Welcome to Ryzen's Macros. Please note that AW Mode is currently OFF. Add me on Discord (smilla kult#4725) if you have any issues. Good luck.
}
else {
MsgBox, 0, Welcome!, Welcome to Ryzen's Macros. Please note that AW Mode is currently ON. Add me on Discord (smilla kult#4725) if you have any issues. Good luck.
}
return

ShowGUI:
Gui, Show
return

ExitMacros:
ExitApp

HideWindow:
Gui, Submit

SaveConfig:
Gui, Submit, NoHide
{
IniWrite,%InteractionMenuKey%,%CFG%,Keybinds,Interaction Menu Key
IniWrite,%ThermalHelmet%,%CFG%,PVP Macros,Thermal Helmet
IniWrite,%FastSniperSwitch%,%CFG%,PVP Macros,Fast Sniper Switch
IniWrite,%SniperBind%,%CFG%,Keybinds,Sniper Bind
IniWrite,%EWO%,%CFG%,PVP Macros,EWO
IniWrite,%EWOLookBehindKey%,%CFG%,Keybinds,EWO Look Behind Button
IniWrite,%EWOSpecialAbilitySlashActionKey%,%CFG%,Keybinds,EWO Special Ability/Action Key
IniWrite,%BST%,%CFG%,PVP Macros,BST
IniWrite,%Ammo%,%CFG%,PVP Macros,Buy Ammo
IniWrite,%FastRespawn%,%CFG%,Misc,Fast Respawn
IniWrite,%Suspend%,%CFG%,Misc,Suspend Macro
IniWrite,%GTAHax%,%CFG%,Misc,GTAHax EWO Codes
IniWrite,%HelpWhatsThis%,%CFG%,Chat Macros,idkwtfthisis
IniWrite,%EssayAboutGTA%,%CFG%,Chat Macros,Essay About GTA
IniWrite,%CustomTextSpam%,%CFG%,Chat Macros,Custom Text Spam
IniWrite,%ShutUp%,%CFG%,Chat Macros,Shut Up Spam
IniWrite,%CustomSpamText%,%CFG%,Chat Macros,Custom Spam Text
IniWrite,%ReloadOutfit%,%CFG%,Misc,Reload Outfit
IniWrite,%ShowUI%,%CFG%,Misc,Show UI
IniWrite,%ToggleCEO%,%CFG%,Misc,Toggle CEO
IniWrite,%SleepTime%,%CFG%,Misc,Ammo Buy Sleep Time
IniWrite,%BuyCycles%,%CFG%,Misc,Ammo Buy Cycles
IniWrite,%ProcessCheck2%,%CFG%,Misc,Process Check
IniWrite,%AWMode%,%CFG%,Misc,AW Mode On
IniWrite,%NightVision%,%CFG%,Misc,Use Night Vision Thermal
IniWrite,%RPGSpam%,%CFG%,PVP Macros,RPG Spam
IniWrite,%RPGBind%,%CFG%,Keybinds,RPG Bind
IniWrite,%StickyBind%,%CFG%,Keybinds,Sticky Bind
IniWrite,%PistolBind%,%CFG%,Keybinds,Pistol Bind
IniWrite,%TabWeapon%,%CFG%,Misc,Tab Weapon
IniWrite,%Crosshair%,%CFG%,Misc,Crosshair
IniWrite,%2Screen%,%CFG%,Misc,2 Screen Setup
}

Hotkey, *$%ThermalHelmet%, ThermalHelmet
Hotkey, *$%FastSniperSwitch%, FastSniperSwitch
Hotkey, *$%EWO%, EWO
Hotkey, *$%BST%, BST
Hotkey, *$%Ammo%, Ammo
Hotkey, *$%FastRespawn%, FastRespawn
Hotkey, %Suspend%, Suspend
Hotkey, %GTAHax%, GTAHax
Hotkey, %HelpWhatsThis%, HelpWhatsThis
Hotkey, %EssayAboutGTA%, EssayAboutGTA
Hotkey, %CustomTextSpam%, CustomTextSpam
Hotkey, %ShutUp%, ShutUp
Hotkey, %ReloadOutfit%, ReloadOutfit
Hotkey, %ShowUI%, ShowUI
Hotkey, %ToggleCEO%, ToggleCEO
Goto, LaunchCycle
;                                                                            ———Macro Code———
ThermalHelmet: ; Toggles thermal helmet. Hold the "L" key in order to use it if you are not in a CEO or MC.
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
send {%InteractionMenuKey%}{down 3}{enter}{down}{enter}
}
else
{
send {%InteractionMenuKey%}{down 4}{enter}{down}{enter}
}
GuiControlGet, NightVision
If (NightVision = 0) {
send {down 4}{space}{%InteractionMenuKey%}
}
else {
send {space}{%InteractionMenuKey%}
}
return

FastSniperSwitch: ; Switches from sniper to marksman and back to sniper rapidly. You must have the normal sniper rifle removed from your loadout for this to work.
send {%SniperBind%}
sleep 20
send {lbutton}
sleep 20
send {%SniperBind%}
sleep 20
send {lbutton}
return

EWO: ; Kills yourself instantly. Now has a 5 minute cooldown unless using GTAHax or something similar.
sendinput {%EWOSpecialAbilitySlashActionKey% down}{%EWOLookBehindKey% down}{lbutton up}{rbutton up}{enter down}{g down}
send {%InteractionMenuKey%}{up}
sendinput {wheelup}{enter up}
sleep 25
send {enter}
sendinput {%EWOLookBehindKey% up}{< up}{g up}{%EWOSpecialAbilitySlashActionKey% up}
setcapslockstate, off
return

BST: ; Drops BST. Must be in CEO obviously.
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
return
}
else
{
send {%InteractionMenuKey%}{enter}{down 4}{enter}{down}{enter}
}
return

Ammo: ; Buys ammo.
BuyCycles -= 1
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
send {%InteractionMenuKey%}{down 2}{enter}{down 5}{enter}{up}{enter}
}
else
{
send {%InteractionMenuKey%}{down 3}{enter}{down 5}{enter}{up}{enter}
}
Loop, %BuyCycles%
{
send {up 2}{enter}{down 2}
sleep %SleepTime%
send {enter}
}
send {%InteractionMenuKey%}
BuyCycles += 1
return

FastRespawn: ; Respawns extremely fast.
send {lbutton 30}
return

Suspend: ; Suspends the entire macro until you press it again.
Suspend
return

;                                             EXTREMELY LONG AND CONFUSING MACROS BELOW, DON'T MESS WITH THEM UNLESS YOU WANT TO HAVE A BRAIN HEMMORAGE WHEN YOU TRY TO UNDERSTAND HOW THEY WORK























GTAHax: ; Applies the EWO no cooldown code using GTAHax.
sendinput {%GTAHax% up}
Run, GTAHaXUI.exe, %A_ScriptDir%, , Max
Sleep 1500
DllCall("SetCursorPos", int, 300, int, 298) ;Line 1
send {LButton}{BackSpace}262145
DllCall("SetCursorPos", int, 300, int, 328) ;Line 2
send {LButton}{BackSpace}28057
DllCall("SetCursorPos", int, 324, int, 585) ;Write
send {LButton}
DllCall("SetCursorPos", int, 300, int, 328) ;Line 2
Send {LButton}{BackSpace}8
DllCall("SetCursorPos", int, 324, int, 585) ;Write
send {LButton}
sleep 100
WinClose, who the fuck even uses this shit
sleep 100
WinActivate ahk_class grcWindow
return

HelpWhatsThis: ; Spams "don't care + didn't ask + cry about it + stay mad + get real + L + mald seethe cope harder + hoes mad + basic + skill issue + ratio + you fell off + the audacity + triggered + any askers + redpilled + get a life + ok and? + cringe + touch grass + donowalled + not based + you’re a (insert stereotype) + not funny didn't laugh + you're* + grammar issue + go outside + get good + reported + ad hominem + GG! + ur mom"
sendinput {%HelpWhatsThis% up}
send td
sendinput on’t care {Numpadadd} didn't ask {Numpadadd} cry a
send b
sendinput out it {Numpadadd} stay mad {Numpadadd} get real {Numpadadd} L {Numpadadd} 
send {space}
sendinput mald {Numpadadd} seethe {Numpadadd} cope harder {Numpadadd}
send {space}
sendinput hoes mad {Numpadadd} basic {Numpadadd} skill issue{Numpadadd} 
send {space}
sendinput {Numpadadd} ratio
send {enter}t{Numpadadd} 
sendinput {space}you fell off {Numpadadd} the audacity 
send {space}
sendinput {Numpadadd}{space}triggered {Numpadadd} any askers {Numpadadd} redp
send i
sendinput lled {Numpadadd} get a life {Numpadadd} ok and? 
send {space}
sendinput {Numpadadd} cringe {Numpadadd} touch grass {Numpadadd} donow
send a
sendinput lled {Numpadadd} not based
send {enter}t{Numpadadd} 
sendinput {space}you’re a (insert stereotype)
send {space}
sendinput {Numpadadd} not funny didn't laugh {Numpadadd} you
send ’
sendinput re* {Numpadadd} grammar issue {Numpadadd} go outsi
send d
sendinput e {Numpadadd} get good {Numpadadd} reported
send {enter}t{Numpadadd}
sendinput {space}ad hominem {Numpadadd} GG{shift down}1{shift up} {Numpadadd} ur mom
send {enter}
return

EssayAboutGTA: ; Complains about how bad the FPS is in GTA Online.
sendinput {%EssayAboutGTA% up}
send tw
sendinput hy is my fps so shlt this game
send {space}
sendinput has terrible optimization its{space}
send c
sendinput hinese as shlt man i hate this
send {space}
sendinput game im gonna swat the r* headq
send u
sendinput arters man i
send {enter}ts
sendinput wear to god this game is so ba
send d
sendinput {space}why do we all still play it i
send d
sendinput k but how can they not afford{space}
send s
sendinput ome dedicated servers they are a
send {space}
sendinput multi billion 
send {enter}td
sendinput ollar company also why does it
send {space}
sendinput still use p2p technology for s
send e
sendinput rvers thats been out of date s
send i
sendinput nce gta 4 man it honestly baffl
send l
sendinput es me how
send {enter}to
sendinput utdated gta online is and how{space}
send b
sendinput ad the fps is its so cpu bo 
send u
sendinput nd its stupid and thanks for{space}
send l
sendinput istening to my essay about how
send {space}
sendinput bad gta online is
send {enter}
return

CustomTextSpam: ; Spams whatever your clipboard is. Copy anything to your clipboard for it to work.
sendinput {%CustomTextSpam% up}
send t{shift up}
sendinput {raw}%CustomSpamText%
Send {enter}
return

ShutUp: ; Spams "shut up"
sendinput {%ShutUp% up}
send t{shift up}
sendinput {raw}shut up
send {enter}
return

ReloadOutfit:
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
send {%InteractionMenuKey%}{down 3}{enter}
}
else
{
send {%InteractionMenuKey%}{down 4}{enter}
}
send {down 3}{enter 2}{%InteractionMenuKey%}
return

DisableCapsLock: ; Disables CapsLock, so you can't press it.
send {CapsLock}
setcapslockstate, off
return

2Screen2:
GuiControlGet, 2Screen
If (2Screen = 0) {
Global crossHairX := (screenW / 2) - (crossHairH / 2)
Global crossHairY := (screenH / 2) - (crossHairH / 2)
WinMove, QuickMacroCrosshair,, %CrossHairX%, %CRossHairY%
}
else {
Global crossHairX := (screenW / 4) - (crossHairH / 2)
Global crossHairY := (screenH / 2) - (crossHairH / 2)
WinMove, QuickMacroCrosshair,, %CrossHairX%, %CRossHairY%
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
If (2Screen = 0) {
Global crossHairX := (screenW / 2) - (crossHairH / 2)
Global crossHairY := (screenH / 2) - (crossHairH / 2)
WinMove, QuickMacroCrosshair,, %CrossHairX%, %CRossHairY%
}
else {
Global crossHairX := (screenW / 4) - (crossHairH / 2)
Global crossHairY := (screenH / 2) - (crossHairH / 2)
WinMove, QuickMacroCrosshair,, %CrossHairX%, %CRossHairY%
}

IfNotExist, %A_WorkingDir%\assets
	FileCreateDir, %A_WorkingDir%\assets

FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

Gui, QuickMacroCrosshair: New, +AlwaysOnTop -Border -Caption
Gui, Color, backgroundColor
Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, QuickMacroCrosshair
WinSet, TransColor, backgroundColor, QuickMacroCrosshair
	} else {
Gui, QuickMacroCrosshair: Hide
	}
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
GuiControlGet, AWMode
If (TabWeapon = 0)
{
Hotkey, *$%RPGSpam%, RPGSpam, Off
Hotkey, *$%SniperBind%, SniperBind, Off
Hotkey, *$%RPGBind%, RPGBind, Off
Hotkey, *$%StickyBind%, StickyBind, Off
}
else
{
  If (AWMode = 0)
   {
    Hotkey, *$%RPGSpam%, RPGSpam, Off
    Hotkey, *$%SniperBind%, SniperBind, Off
    Hotkey, *$%RPGBind%, RPGBind, Off
    Hotkey, *$%StickyBind%, StickyBind, Off
  }
   else{
Hotkey, *$%RPGSpam%, RPGSpam, On
Hotkey, *$%SniperBind%, SniperBind, On
Hotkey, *$%RPGBind%, RPGBind, On
Hotkey, *$%StickyBind%, StickyBind, On 
      }								
}
return

AWMode2:
GuiControlGet, TabWeapon
GuiControlGet, AWMode
If (TabWeapon = 0)
{
Hotkey, *$%RPGSpam%, RPGSpam, Off
Hotkey, *$%SniperBind%, SniperBind, Off
Hotkey, *$%RPGBind%, RPGBind, Off
Hotkey, *$%StickyBind%, StickyBind, Off
}
else
{
  If (AWMode = 0)
   {
    Hotkey, *$%RPGSpam%, RPGSpam, Off
    Hotkey, *$%SniperBind%, SniperBind, Off
    Hotkey, *$%RPGBind%, RPGBind, Off
    Hotkey, *$%StickyBind%, StickyBind, Off
    MsgBox, 0, AW Mode, AW Mode is now DEACTIVATED
  }
   else{
Hotkey, *$%RPGSpam%, RPGSpam, On
Hotkey, *$%SniperBind%, SniperBind, On
Hotkey, *$%RPGBind%, RPGBind, On
Hotkey, *$%StickyBind%, StickyBind, On 
MsgBox, 0, AW Mode, AW Mode has been ACTIVATED
      }								
}
return

Enter:
sendinput {enter down}
sleep 50
sendinput {enter up}
return

ShowUI:
Gui, Show
return

ToggleCEO:
send {%ToggleCEO%}
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
GUIControl,, CEOMode, 1
}
else
{
GUIControl,, CEOMode, 0
}
return

ProcessCheckTimer:
GuiControlGet, ProcessCheck2 ; Retrieves 1 if it is checked, 0 if it is unchecked.
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
send {%SniperBind%}{tab}
return

RPGBind:
send {%RPGBind%}{tab}
return

StickyBind:
send {%StickyBind%}{tab}
return

PistolBind:
send {%PistolBind%}{tab}
return

RPGSpam:
send {%StickyBind%}{%RPGBind%}{tab}
return


DiscordPriority: ; Sets the process priority of various applications.
SetDiscordPriority:
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
Run, snipercrashfix.exe, %A_ScriptDir%\Recommended to use, , Max
Sleep 750
send {enter}
sleep 250
WinClose, snipercrashfix.exe
WinActivate ahk_class grcWindow
Goto, Macro

LaunchCycle:
GuiControlGet, TabWeapon
GuiControlGet, AWMode
If (TabWeapon = 0)
   {
Hotkey, *$%RPGSpam%, RPGSpam, Off
Hotkey, *$%SniperBind%, SniperBind, Off
Hotkey, *$%RPGBind%, RPGBind, Off
Hotkey, *$%StickyBind%, StickyBind, Off
   }
else
   {
  If (AWMode = 0)
   {
    Hotkey, *$%RPGSpam%, RPGSpam, Off
    Hotkey, *$%SniperBind%, SniperBind, Off
    Hotkey, *$%RPGBind%, RPGBind, Off
    Hotkey, *$%StickyBind%, StickyBind, Off
  }
   else{
Hotkey, *$%RPGSpam%, RPGSpam, On
Hotkey, *$%SniperBind%, SniperBind, On
Hotkey, *$%RPGBind%, RPGBind, On
Hotkey, *$%StickyBind%, StickyBind, On 
      }								
      }
GuiControlGet, ProcessCheck2
if (ProcessCheck2 = 0) {
SetTimer, ProcessCheckTimer, Off
   } else {
SetTimer, ProcessCheckTimer, 3000
   }
GuiControlGet, Crosshair
GuiControlGet, AWMode
	if(crossHair = 1) {
Global crossHairW := 21
Global crossHairH := 21

Global backgroundColor := 0xff00cc

SysGet, screenW, 78
SysGet, screenH, 79

GuiControlGet, 2Screen
If (2Screen = 0) {
Global crossHairX := (screenW / 2) - (crossHairH / 2)
Global crossHairY := (screenH / 2) - (crossHairH / 2)
WinMove, QuickMacroCrosshair,, %CrossHairX%, %CRossHairY%
}
else {
Global crossHairX := (screenW / 4) - (crossHairH / 2)
Global crossHairY := (screenH / 2) - (crossHairH / 2)
WinMove, QuickMacroCrosshair,, %CrossHairX%, %CRossHairY%
}

IfNotExist, %A_WorkingDir%\assets
	FileCreateDir, %A_WorkingDir%\assets

FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

Gui, QuickMacroCrosshair: New, +AlwaysOnTop -Border -Caption
Gui, Color, backgroundColor
Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, QuickMacroCrosshair
WinSet, TransColor, backgroundColor, QuickMacroCrosshair
	} else {
Gui, QuickMacroCrosshair: Hide
	}
If (AWMode = 0) {
Gui, QuickMacroCrosshair: Hide
}
else {
}
#Include *i PutYourOwnScriptsHere.ahk
return

Delete:
send {f23}
return