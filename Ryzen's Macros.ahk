﻿CFG = GTA Binds.ini
MacroVersion = 3.10.4
CrosshairDone := 0
MCCEO2 := 0
if not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
#SingleInstance, force
#IfWinActive ahk_class grcWindow
#IfWinActive Grand Theft Auto V
#MaxThreadsPerHotkey 1
#MaxThreads 99999
#MaxThreadsBuffer On
#MaxHotkeysPerInterval 99000000
#KeyHistory 0 
#HotkeyInterval 99000000
ListLines Off
SetTitleMatchMode, 2
SetDefaultMouseSpeed, 0
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1
SetControlDelay, -1
SetMouseDelay, -1
Process, Priority, , N
SetWorkingDir %A_ScriptDir%
Gui, Font,, Segoe UI Semibold
Gosub, DiscordPriority
Gui, Font, q5
Gui, Add, Text,ym, Interaction Menu Bind:
Gui, Add, Text,, Thermal Helmet Macro:
Gui, Add, Text,, Fast Sniper Switch Macro:
Gui, Add, Text,, Sniper Rifle (in-game) Bind:
Gui, Add, Text,, Instant EWO Macro:
Gui, Add, Text,, EWO Look Behind (in-game) Bind:
Gui, Add, Text,, EWO Special Ability (in-game) Bind:
Gui, Add, Text,, EWO Melee (in-game) Bind:
Gui, Add, Text,, BST Macro:
Gui, Add, Text,, BST Macro MC Mode:
Gui, Add, Text,, BST Less Reliable But Faster?
Gui, Add, Text,, Ammo Macro:
Gui, Add, Text,, Ammo buy wait time (ms):
Gui, Add, Text,, Ammo weapons to buy:
Gui, Add, Text,, Reverse Ammo Macro buy order?
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
Gui, Add, Hotkey,vEWOMelee,
Gui, Add, Hotkey,vBST,
Gui, Add, Checkbox,vBSTMC h20,
Gui, Add, Checkbox,vBSTSpeed h20,
Gui, Add, Hotkey,vAmmo,
Gui, Add, Edit,Number vSleepTime,
Gui, Add, Edit,Number vBuyCycles,
Gui, Add, Checkbox,vReverse h20,
Gui, Add, Hotkey,vFastRespawn,
Gui, Add, Hotkey,vSuspend,
Gui, Add, Hotkey,vGTAHax,PrintScreen

Gui, Add, Text,ys y10, Epic Roast Chat Macro:
Gui, Add, Text,, Essay About GTA Chat Macro:
Gui, Add, Text,, Custom Text Spam Chat Macro:
Gui, Add, Text,, Custom Spam Text (max 140 characters)
Gui, Add, Text,, Shut Up Chat Macro:
Gui, Add, Text,, Reload Outfit:
Gui, Add, Text,, Show UI:
Gui, Add, Text,, Toggle CEO Mode:
Gui, Add, Text,, Toggle Crosshair:
Gui, Add, Text,, Close macros if GTA is closed?
Gui, Add, Text,, CEO/VIP/MC mode:
Gui, Add, Text,, AW Mode:
Gui, Add, Text,, Use Night Vision for Thermal Macro?
Gui, Add, Text,, Crosshair:
Gui, Add, Text,, Smoothen EWO animation? (slower)

Gui, Add, Hotkey,vHelpWhatsThis yn y10,
Gui, Add, Hotkey,vEssayAboutGTA,
Gui, Add, Hotkey,vCustomTextSpam,
Gui, Add, Edit, Limit140 vCustomSpamText
Gui, Add, Hotkey,vShutUp,
Gui, Add, Hotkey,vReloadOutfit,
Gui, Add, Hotkey,vShowUI,
Gui, Add, Hotkey,vToggleCEO,
Gui, Add, Hotkey,vToggleCrosshair,
Gui, Add, CheckBox, gProcessCheck3 vProcessCheck2 h20,
Gui, Add, CheckBox, vCEOMode h20,
Gui, Add, CheckBox, gAWMode2 vAWMode h20,
Gui, Add, CheckBox, vNightVision h20,
Gui, Add, Checkbox, gCrossHair5 vCrossHair h20,
Gui, Add, Checkbox, vSmoothEWO h20,
Gui, Add, Button, gSaveConfig,Save config and start the macros!
Gui, Add, Button, gApply,Apply changes and don't save
Gui, Add, Button, gHideWindow,Hide window
Gui, Add, Button, gExitMacros,Exit macros
Gui, Add, Button, gFlawless, Apply Flawless Widescreen fix!

Gui, Add, Text,ys y10, RPG Spam:
Gui, Add, Text,, RPG (in-game) Bind:
Gui, Add, Text,, Sticky bomb (in-game) Bind:
Gui, Add, Text,, Pistol (in-game) Bind:
Gui, Add, Text,, Be able to use weapons after respawning (AW mode only)
Gui, Add, Text,, Do you have a 2 screen setup?

Gui, Add, Hotkey, vRPGSpam yn y10,
Gui, Add, Hotkey, vRPGBind,
Gui, Add, Hotkey, vStickyBind,
Gui, Add, Hotkey, vPistolBind,
Gui, Add, Checkbox, gTabWeapon2 vTabWeapon h20,
Gui, Add, Checkbox, g2Screen2 v2Screen h20,
Gosub, NotExist1
Gui, Add, Text,x775 y200, Turn off all Job Blips Fast:
Gui, Add, Text,x775 y230, Make it so you can copy paste?
Gui, Add, Text,x775 y260, MC CEO toggle
Gui, Add, Text,x775 y290, Custom Macro #1 Hotkey:
Gui, Add, Text,x775 y320, Custom Macro #2 Hotkey:
Gui, Add, Text,x775 y350, Custom Macro #3 Hotkey:
Gui, Add, Text,x775 y380, Custom Macro #4 Hotkey:
Gui, Add, Text,x775 y410, Custom Macro #5 Hotkey:
Gui, Add, Text,x775 y440, Custom Macro #6 Hotkey:
Gui, Add, Text,x775 y470, Custom Chat Macro #1 Hotkey:
Gui, Add, Text,x775 y500, Custom Chat Macro #2 Hotkey:
Gui, Add, Hotkey, vJobs x1080 y200
Gui, Add, Checkbox, gPaste2 vPaste x1080 y230
Gui, Add, Hotkey, vMCCEO x1080 y260
Gui, Add, Hotkey, vIncludeHotkey1 x1080 y290
Gui, Add, Hotkey, vIncludeHotkey2 x1080 y320
Gui, Add, Hotkey, vIncludeHotkey3 x1080 y350
Gui, Add, Hotkey, vIncludeHotkey4 x1080 y380
Gui, Add, Hotkey, vIncludeHotkey5 x1080 y410
Gui, Add, Hotkey, vIncludeHotkey6 x1080 y440
Gui, Add, Hotkey, vIncludeHotkeyChat1 x1080 y470
Gui, Add, Hotkey, vIncludeHotkeyChat2 x1080 y500
Gui, Font, s13 q5
Gui, Add, Text,x775 y170, AW MODE IS UNDER CONSTRUCTION!

IfExist, %CFG% 
{ 
   IniRead,Read_InteractionMenuKey,%CFG%,Keybinds,Interaction Menu Key
   IniRead,Read_ThermalHelmet,%CFG%,PVP Macros,Thermal Helmet
   IniRead,Read_FastSniperSwitch,%CFG%,PVP Macros,Fast Sniper Switch
   IniRead,Read_SniperBind,%CFG%,Keybinds,Sniper Bind
   IniRead,Read_EWO,%CFG%,PVP Macros,EWO
   IniRead,Read_EWOLookBehindKey,%CFG%,Keybinds,EWO Look Behind Button
   IniRead,Read_EWOSpecialAbilitySlashActionKey,%CFG%,Keybinds,EWO Special Ability/Action Key
   IniRead,Read_EWOMelee,%CFG%,Keybinds,EWO Melee Key
   IniRead,Read_BST,%CFG%,PVP Macros,BST
   IniRead,Read_BSTSpeed,%CFG%,PVP Macros,BST Speed
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
   IniRead,Read_ToggleCrosshair,%CFG%,Misc,Toggle Crosshair
   IniRead,Read_SleepTime,%CFG%,Misc,Ammo Buy Sleep Time
   IniRead,Read_BuyCycles,%CFG%,Misc,Ammo Buy Cycles
   IniRead,Read_Reverse,%CFG%,Misc,Reverse Ammo Macro order
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
   IniRead,Read_Jobs,%CFG%,Misc,Disable All Job Blips
   IniRead,Read_Paste,%CFG%,Misc,Allow Copy Paste
   IniRead,Read_MCCEO,%CFG%,Misc,MC CEO Toggle
   IniRead,Read_SmoothEWO,%CFG%,Misc,Smooth EWO
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
   GuiControl,,EWOLookBehindKey,%Read_EWOLookBehindKey%
   GuiControl,,EWOSpecialAbilitySlashActionKey,%Read_EWOSpecialAbilitySlashActionKey%
   GuiControl,,EWOMelee,%Read_EWOMelee%
   GuiControl,,BST,%Read_BST%
   GuiControl,,BSTSpeed,%Read_BSTSpeed%
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
   GuiControl,,ToggleCrosshair,%Read_ToggleCrosshair%
   GuiControl,,SleepTime,%Read_SleepTime%
   GuiControl,,BuyCycles,%Read_BuyCycles%
   GuiControl,,Reverse,%Read_Reverse%
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
   GuiControl,,Jobs,%Read_Jobs%
   GuiControl,,Paste,%Read_Paste%
   GuiControl,,MCCEO,%Read_MCCEO%
   GuiControl,,SmoothEWO,%Read_SmoothEWO%
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
GuiControl,,BSTMC,0
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

Menu, Tray, Tip, Ryzen's Macros Version %MacroVersion%
Gui, Show,, Ryzen's Macros Version %MacroVersion%
GuiControlGet, AWMode
If (AWMode = 0) {
MsgBox, 0, Welcome!, Welcome to Ryzen's Macros. Please note that AW Mode is currently OFF. Add me on Discord (cryleak#3961) if you have any issues. Good luck.
}
else {
MsgBox, 0, Welcome!, Welcome to Ryzen's Macros. Please note that AW Mode is currently ON. Add me on Discord (cryleak#3961) if you have any issues. Good luck.
}
GuiControlGet, Paste
If (Paste = 0) {
   Hotkey, *^v, Paste, Off
}
else {
   Hotkey, *^v, Paste, On
}
return

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

SaveConfig:
Gosub,DisableAll
Gui,Submit,NoHide
{
   IniWrite,%InteractionMenuKey%,%CFG%,Keybinds,Interaction Menu Key
   IniWrite,%ThermalHelmet%,%CFG%,PVP Macros,Thermal Helmet
   IniWrite,%FastSniperSwitch%,%CFG%,PVP Macros,Fast Sniper Switch
   IniWrite,%SniperBind%,%CFG%,Keybinds,Sniper Bind
   IniWrite,%EWO%,%CFG%,PVP Macros,EWO
   IniWrite,%EWOLookBehindKey%,%CFG%,Keybinds,EWO Look Behind Button
   IniWrite,%EWOSpecialAbilitySlashActionKey%,%CFG%,Keybinds,EWO Special Ability/Action Key
   IniWrite,%EWOMelee%,%CFG%,Keybinds,EWO Melee Key
   IniWrite,%BST%,%CFG%,PVP Macros,BST
   IniWrite,%BSTSpeed%,%CFG%,PVP Macros,BST Speed
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
   IniWrite,%ToggleCrosshair%,%CFG%,Misc,Toggle Crosshair
   IniWrite,%SleepTime%,%CFG%,Misc,Ammo Buy Sleep Time
   IniWrite,%BuyCycles%,%CFG%,Misc,Ammo Buy Cycles
   IniWrite,%Reverse%,%CFG%,Misc,Reverse Ammo Macro order
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
   IniWrite,%Jobs%,%CFG%,Misc,Disable All Job Blips
   IniWrite,%Paste%,%CFG%,Misc,Allow Copy Paste
   IniWrite,%MCCEO%,%CFG%,Misc,MC CEO Toggle
   IniWrite,%SmoothEWO%,%CFG%,Misc,Smooth EWO
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

Hotkey, *%ThermalHelmet%, ThermalHelmet, UseErrorLevel On
Hotkey, *%FastSniperSwitch%, FastSniperSwitch, UseErrorLevel On
Hotkey, *%EWO%, EWO, UseErrorLevel On
Hotkey, *%BST%, BST, UseErrorLevel On
Hotkey, *%Ammo%, Ammo, UseErrorLevel On
Hotkey, *%FastRespawn%, FastRespawn, UseErrorLevel On
Hotkey, *%ToggleCrosshair%, ToggleCrosshair, UseErrorLevel On
Hotkey, *%Suspend%, Suspend, UseErrorLevel On
Hotkey, *%GTAHax%, GTAHax, UseErrorLevel On
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
Gosub, LaunchCycle
Return

ThermalHelmet:
SendInput {lbutton up}
GuiControlGet, CEOMode
If (CEOMode = 0) {
Send {Blind}{%InteractionMenuKey%}{down 3}{enter}{down}{enter}
}
else {
Send {Blind}{%InteractionMenuKey%}{down 4}{enter}{down}{enter}
}
GuiControlGet, NightVision
If (NightVision = 0) {
Send {Blind}{down 4}
sleep 50
Send {Blind}{space}{%InteractionMenuKey%}
}
else {
sleep 50
Send {Blind}{space}{%InteractionMenuKey%}
}
return

FastSniperSwitch:
Send {Blind}{%SniperBind%}
SendInput {lbutton down}
sleep 9
SendInput {lbutton up}
Send {Blind}{%SniperBind%}
SendInput {lbutton down}
sleep 30
SendInput {lbutton up}
return

EWO:
GuiControlGet, SmoothEWO
SendInput {lbutton up}{rbutton up}
if (SmoothEWO = 1) {
 ;  SmoothEWOTime2 = %SmoothEWOTime%
 ;  SmoothEWOTime2 *= 3
   Send {Blind}{%InteractionMenuKey%}
   sleep 15
   Send {Blind}{%EWOSpecialAbilitySlashActionKey%}
   sleep 15
   Send {Blind}{shift down}
   sleep 15
   Send {Blind}{%EWOLookBehindKey% down}
   Send {Blind}{shift up}
   Send {Blind}{up}
   sleep 35
   Send {Blind}{up}
   sleep 45
   Send {Blind}{enter}
   } else {
   SendInput {%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}
   Send {Blind}{f24 down}{f23 down}{f22 down}
   SendInput {wheelup}{enter up}
}
sleep 25
Send {Blind}{enter}
SendInput {%EWOLookBehindKey% up}{%EWOSpecialAbilitySlashActionKey% up}{%EWOMelee% up}{%InteractionMenuKey% up}{up up}{g up}{f24 up}{f23 up}{f22 up}{%EWO% up}
SetCapsLockState, Off
sleep 25
return

BST:
SendInput {lbutton up}
GuiControlGet, CEOMode
GuiControlGet, BSTSpeed
GuiControlGet, BSTMC
If (CEOMode = 0) {
   MsgBox, 0, ur retarded, why the fuck are you trying to use bst when ur not in a ceo
}
else {
   if (BSTMC = 1) {
      Send {Blind}{%InteractionMenuKey%}{enter}{down}{enter}{up}{enter}
   }
   else if (BSTSpeed = 1) {
         Send {Blind}{%InteractionMenuKey%}{enter}{up 3}{enter}{down}{enter}
}
else {
         Send {Blind}{%InteractionMenuKey%}{enter}{down 4}{enter}{down}{enter}
      }
}
return

Ammo: ; Buys ammo.
SendInput {lbutton up}
BuyCycles -= 1
GuiControlGet, CEOMode
GuiControlGet, Reverse
If (Reverse = 1) {
Reverse2 = left
} else {
   Reverse2 = right
}
If (CEOMode = 0) {
   Send {Blind}{%InteractionMenuKey%}{down 2}
   }
   else {
      Send {Blind}{%InteractionMenuKey%}{down 3}
      }
Send {Blind}{enter}{down 5}{enter}{up}{enter}
Loop, %BuyCycles% {
   Send {Blind}{up 2}{%Reverse2%}{down 2}
   sleep %SleepTime%
   Send {Blind}{enter}
}
Send {Blind}{%InteractionMenuKey%}
BuyCycles += 1
return

FastRespawn:
Run, clicker.exe, %A_ScriptDir%
return

Suspend:
Suspend
return

GTAHax:
CoordMode, Mouse, Client
SendInput {%GTAHax% up}
Run, GTAHaXUI.exe, %A_ScriptDir%, , Max
Sleep 1500
Mousemove,125,62
Send {lbutton}{BackSpace}262145
Mousemove,125,90
Send {lbutton}{BackSpace}28073
Mousemove,125,350
Send {lbutton}
Mousemove,125,90
Send {lbutton}{BackSpace}4
Mousemove,125,350
Send {lbutton}
sleep 100
WinClose, ahk_exe GTAHaXUI.exe
sleep 100
WinActivate ahk_class grcWindow
return

HelpWhatsThis:
SendInput {%HelpWhatsThis% up}
Send {Blind}td
SendInput on’t care {Numpadadd} didn't ask {Numpadadd} cry a
Send {Blind}b
SendInput out it {Numpadadd} stay mad {Numpadadd} get real {Numpadadd} L {Numpadadd} 
Send {Blind}{space}
SendInput mald {Numpadadd} seethe {Numpadadd} cope harder {Numpadadd}
Send {Blind}{space}
SendInput hoes mad {Numpadadd} basic {Numpadadd} skill issue
Send {Blind}{space}
SendInput {numpadadd}{space}ratio
Send {Blind}{enter}t{Numpadadd} 
SendInput {space}you fell off {Numpadadd} the audacity 
Send {Blind}{space}
SendInput {Numpadadd}{space}triggered {Numpadadd} any askers {Numpadadd} red
Send {Blind}pi
SendInput lled {Numpadadd} get a life {Numpadadd} ok and? 
Send {Blind}{space}
SendInput {Numpadadd} cringe {Numpadadd} touch grass {Numpadadd} donow
Send {Blind}a
SendInput lled {Numpadadd} not based
Send {Blind}{enter}t{Numpadadd} 
SendInput {space}you’re a (insert stereotype)
Send {Blind}{space}
SendInput {Numpadadd} not funny didn't laugh {Numpadadd} you
Send {Blind}’
SendInput re* {Numpadadd} grammar issue {Numpadadd} go outsi
Send {Blind}d
SendInput e {Numpadadd} get good {Numpadadd} reported
Send {Blind}{enter}t{Numpadadd}
SendInput {space}ad hominem {Numpadadd} GG{shift down}1{shift up} {Numpadadd} ur mom
Send {Blind}{enter}
return

EssayAboutGTA:
SendInput {%EssayAboutGTA% up}
Send {Blind}tw
SendInput hy is my fps so shlt this game
Send {Blind}{space}
SendInput has terrible optimization its{space}
Send {Blind}c
SendInput hinese as shlt man i hate this
Send {Blind}{space}
SendInput game im gonna swat the r* headq
Send {Blind}u
SendInput arters man i
Send {Blind}{enter}ts
SendInput wear to god this game is so ba
Send {Blind}d
SendInput {space}why do we all still play it i
Send {Blind}d
SendInput k but how can they not afford{space}
Send {Blind}s
SendInput ome dedicated servers they are a
Send {Blind}{space}
SendInput multi billion 
Send {Blind}{enter}td
SendInput ollar company also why does it
Send {Blind}{space}
SendInput still use p2p technology for s
Send {Blind}e
SendInput rvers thats been out of date s
Send {Blind}i
SendInput nce gta 4 man it honestly baffl
Send {Blind}l
SendInput es me how
Send {Blind}{enter}to
SendInput utdated gta online is and how{space}
Send {Blind}b
SendInput ad the fps is its so cpu bo 
Send {Blind}u
SendInput nd its stupid and thanks for{space}
Send {Blind}l
SendInput istening to my essay about how
Send {Blind}{space}
SendInput bad gta online is
Send {Blind}{enter}
return

CustomTextSpam: ; Spams whatever your clipboard is. Copy anything to your clipboard for it to work.
Length := StrLen(CustomSpamText)
if (Length >= 31) {
Iterations = 1
StringSplit, ArrayYes, CustomSpamText
send {Blind}t{shift up}
Loop, 30 {
   SendInput % ArrayYes%Iterations%
   Iterations += 1
}   
Send %ArrayYes31%
Iterations += 1
Loop, 30 {
   SendInput % ArrayYes%Iterations%
   Iterations += 1 
}
Send %ArrayYes62%
Iterations += 1 
Loop, 30 {
   SendInput % ArrayYes%Iterations%
   Iterations += 1 
}
Send %ArrayYes93%
Iterations += 1 
Loop, 30 {
   SendInput % ArrayYes%Iterations%
   Iterations += 1 
}
Send %ArrayYes122%
Iterations += 1
Loop, 18 {
   SendInput % ArrayYes%Iterations%
   Iterations += 1 
}
}
else if Length <= 30
{
Send {Blind}t{shift up}
SendInput {raw}%CustomSpamText%
Send {Blind}{enter} 
}
send {Blind}{enter}
return

Paste:
SendInput {raw}%Clipboard%
return

ShutUp: ; Spams "shut up"
Send {Blind}t{shift up}
sendinput shut up
Send {Blind}{enter}
return

Paste2:
GuiControlGet, Paste
If (Paste = 0) {
   Hotkey, *^v, Paste, Off
}
else {
   Hotkey, *^v, Paste, On
}
return

ReloadOutfit:
SendInput {lbutton up}
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0) {
Send {Blind}{%InteractionMenuKey%}{down 3}{enter}
}
else {
Send {Blind}{%InteractionMenuKey%}{down 4}{enter}
}
Send {Blind}{down 3}{enter 2}{%InteractionMenuKey%}
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

Crosshair6:
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
GuiControlGet, AWMode
If (TabWeapon = 0) {
Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
} else {
   if (AWMode = 1) {
Hotkey, *%SniperBind%, SniperBind, UseErrorLevel On
Hotkey, *%RPGBind%, RPGBind, UseErrorLevel On
Hotkey, *%StickyBind%, StickyBind, UseErrorLevel On 
Hotkey, *%PistolBind%, PistolBind, UseErrorLevel On
      }								
}
return

AWMode2:
GuiControlGet, TabWeapon
GuiControlGet, AWMode
If (TabWeapon = 0) {
Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
}
If (AWMode = 0) {
    Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
    Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
    Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
    Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
    MsgBox, 0, AW Mode, AW Mode is now DEACTIVATED
   } else if (AWMode = 1) and (TabWeapon = 1) {
Hotkey, *%SniperBind%, SniperBind, UseErrorLevel On
Hotkey, *%RPGBind%, RPGBind, UseErrorLevel On
Hotkey, *%StickyBind%, StickyBind, UseErrorLevel On 
Hotkey, *%PistolBind%, PistolBind, UseErrorLevel On
MsgBox, 0, AW Mode, AW Mode has been ACTIVATED
      }								
      else if (AWMode = 1) {
         MsgBox, 0, AW Mode, AW Mode has been ACTIVATED
      }
return

ShowUI:
Gui, Show
return

ToggleCEO:
SendInput {lbutton up}
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
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
      if (ProcessCheck2 = 0) {
      SetTimer, ProcessCheckTimer, Off
         } else {
      SetTimer, ProcessCheckTimer, 3000
      }
      GuiControlGet, TabWeapon
      GuiControlGet, AWMode
      If (TabWeapon = 0) {
      Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
      Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
      Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
      Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
         }
      else If (AWMode = 0) {

         Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
         Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
         Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
         Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
      }
         else if (TabWeapon = 1) and (AWMode = 1) {
      Hotkey, *%SniperBind%, SniperBind, UseErrorLevel On
      Hotkey, *%RPGBind%, RPGBind, UseErrorLevel On
      Hotkey, *%StickyBind%, StickyBind, UseErrorLevel On
      Hotkey, *%PistolBind%, PistolBind, UseErrorLevel On
            }
            else if (AWMode = 1) and (TabWeapon = 0){
         Hotkey, *%SniperBind%, SniperBind, UseErrorLevel Off
         Hotkey, *%RPGBind%, RPGBind, UseErrorLevel Off
         Hotkey, *%StickyBind%, StickyBind, UseErrorLevel Off
         Hotkey, *%PistolBind%, PistolBind, UseErrorLevel Off
            }
      GuiControlGet, Paste
      If (Paste = 0) {
         Hotkey, *^v, Paste, Off
      }
      else {
         Hotkey, *^v, Paste, On
      }
      Gui, Submit, NoHide
      If (CrosshairDone = 0) {
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
sendraw %IncludeMacroChat1%
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
sendraw %IncludeMacroChat2%
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
   Hotkey, *%GTAHax%, GTAHax, UseErrorLevel Off
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
   GuiControl,,InteractionMenuKey,M
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
   GuiControl,,GTAHax,
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
   GuiControl,,ProcessCheck2,0
   GuiControl,,AWMode,0
   GuiControl,,NightVision,0
   GuiControl,,RPGSpam,
   GuiControl,,RPGBind,4
   GuiControl,,StickyBind,5
   GuiControl,,PistolBind,6
   GuiControl,,TabWeapon,0
   GuiControl,,Crosshair,0
   GuiControl,,2Screen,0
   GuiControl,,Jobs,
   GuiControl,,Paste,0
   GuiControl,,MCCEO,
   GuiControl,,SmoothEWO,0
   GuiControl,,SmoothEWOTime,15
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