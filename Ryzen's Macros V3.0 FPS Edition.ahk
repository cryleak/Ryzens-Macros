;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
CFG = GTA Binds.ini
; All of this shit apparently theoretically increase speed according to the person know as Quxck. It probably only helps if you have high FPS,
; but i have noticed a difference between SetKeyDelay 10, 10 (the default) and -1, -1 (the fastest) even at a "low" FPS of 60FPS.
; Just use them because they probably improve speed, at least a little bit.
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
SetDefaultMouseSpeed, 0           ; Could theoretically increase speed in some situations.
SetKeyDelay, -1, -1               ; Always increases speed. Always use, and no it won't reduce reliability by much...
SetWinDelay, -1                   ; Window delay between window commands, it helps speed sometimes.
SetControlDelay, -1               ; Control-modifying command delay, sometimes helps.
Process, Priority, GTA5.exe, H    ; Sets the task priority of GTA V to high, which in theory should improve FPS, mostly on lower end systems
SetWorkingDir %A_ScriptDir%       ; Ensures a consistent starting directory. Helps for some shit.
SetTimer, ProcessCheckTimer, 3000 ; Closes macros if GTA is closed if a checkbox is checked.
Goto, DiscordPriority             ; Automatically excecutes DiscordPriority when you start the script, which sets Discords's priority to High, which should make it more usable now that we increased the priority of GTA to High, and it also changes some other applications to Low.
Macro:
Gui, Add, Text,, Interaction Menu Bind:
Gui, Add, Text,, Thermal Helmet Macro:
Gui, Add, Text,, Fast Sniper Switch Macro:
Gui, Add, Text,, Sniper Rifle Bind:
Gui, Add, Text,, Instant EWO Macro:
Gui, Add, Text,, EWO Look Behind Bind:
Gui, Add, Text,, EWO Special Ability / Action Bind:
Gui, Add, Text,, BST Macro:
Gui, Add, Text,, Ammo Macro:
Gui, Add, Text,, Fast Respawn Macro:
Gui, Add, Text,, Suspend:
Gui, Add, Text,, GTA Hax EWO Codes Macro:
Gui, Add, Text,, Epic Roast Chat Macro:
Gui, Add, Text,, Essay About GTA Chat Macro:
Gui, Add, Text,, Custom Text Spam Chat Macro:
Gui, Add, Text,, Custom Spam Text (30 character limit):
Gui, Add, Text,, Shut Up Chat Macro:
Gui, Add, Text,, Reload Outfit:
Gui, Add, Text,, Show UI:
Gui, Add, Text,, Toggle CEO Mode
Gui, Add, Text,, Close macros if GTA is closed?
Gui, Add, Text,, CEO/VIP/MC mode:

Gui, Add, Hotkey,vInteractionMenuKey ym,
Gui, Add, Hotkey,vThermalHelmet,
Gui, Add, Hotkey,vFastSniperSwitch,
Gui, Add, Hotkey,vSniperBind,
Gui, Add, Hotkey,vEWO,
Gui, Add, Hotkey,vEWOLookBehindKey,
Gui, Add, Hotkey,vEWOSpecialAbilitySlashActionKey,
Gui, Add, Hotkey,vBST,
Gui, Add, Hotkey,vAmmo,
Gui, Add, Hotkey,vFastRespawn,
Gui, Add, Hotkey,vSuspend,
Gui, Add, Hotkey,vGTAHax,PrintScreen
Gui, Add, Hotkey,vHelpWhatsThis,
Gui, Add, Hotkey,vEssayAboutGTA,
Gui, Add, Hotkey,vCustomTextSpam,
Gui, Add, Edit,vCustomSpamText
Gui, Add, Hotkey,vShutUp,
Gui, Add, Hotkey,vReloadOutfit,
Gui, Add, Hotkey,vShowUI,
Gui, Add, Hotkey,vToggleCEO,
Gui, Add, CheckBox, vProcessCheck2,
Gui, Add, CheckBox, vCEOMode
IniWrite,1,%CFG%,Misc,CEO Mode (always on by default. Don't change)
IniRead,Read_CEOMode,%CFG%,Misc,CEO Mode (always on by default. Don't change)
GuiControl,,CEOMode,%Read_CEOMode%

DisableCapsLock := "CapsLock"
Hotkey, *$%DisableCapsLock%, DisableCapsLock  
Enter := "Enter"
Hotkey, *$%Enter%, Enter

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
IniRead,Read_ProcessCheck2,%CFG%,Misc,Process Check

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
GuiControl,,ProcessCheck2,%Read_ProcessCheck2%
}

Gui, Add, Button, gSaveConfig,Save config and start the macros!
Gui, Add, Button, gHideWindow,Hide window and start the macros!
Gui, Add, Button, gExitMacros,Exit macros
Menu, Tray, NoStandard
Menu, Tray, Add, Show UI, ShowGUI
Menu, Tray, Add, Hide UI, HideWindow
Menu, Tray, Add, Save Macros, SaveConfig
Menu, Tray, Add
Menu, Tray, Standard
Menu, Tray, Tip, Ryzen's Macros Version 3.0
Gui, Show,, Ryzen's Macros Version 3.0
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
IniWrite,%ProcessCheck2%,%CFG%,Misc,Process Check
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
#Include *i Put your own scripts here.ahk
return
;                                                                            ———Macro Code———
ThermalHelmet: ; Toggles thermal helmet. Hold the "L" key in order to use it if you are not in a CEO or MC.
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
send {%InteractionMenuKey%}{down 3}{enter}
}
else
{
send {%InteractionMenuKey%}{down 4}{enter}
}
send {down}{enter}{down 4}{space}{%InteractionMenuKey%}
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
send {enter 4}
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

Ammo: ; Buys ammo. Hold the "L" key in order to use it if you are not in a CEO or MC.
GuiControlGet, CEOMode ; Retrieves 1 if it is checked, 0 if it is unchecked.
If (CEOMode = 0)
{
send {%InteractionMenuKey%}{down 2}{enter}
}
else
{
send {%InteractionMenuKey%}{down 3}{enter}
}
send {down 5}{enter}{up}{enter}  ; cycle 1 
send {up 2}{enter}{down 2} ; cycle 2
send {enter} ; end of cycle 2 
send {up 2}{enter}{down 2} ; cycle 3
send {enter} ; end of cycle 3
send {up 2}{enter}{down 2} ; cycle 4
send {enter} ; end of cycle 4
send {up 2}{enter}{down 2} ; cycle 5
send {enter} ; end of cycle 5
send {up 2}{enter}{down 2} ; cycle 6
send {enter} ; end of cycle 6
send {up 2}{enter}{down 2} ; cycle 7
send {enter} ; end of cycle 7
send {up 2}{enter}{down 2} ; cycle 8
send {enter}{left} ; end of cycle 8
send {%InteractionMenuKey%}
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

Enter:
send {enter}
sleep 50
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
   ExitApp
 }
return
}

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
Goto, Macro

;                                                                                        ———END OF CODE. INFO AND OTHER STUFF BELOW———

; Info:
; Welcome to these fast and useless for freeroam macros! This is (no longer) a heavily modified version of the macros found on the Motmus Discord server. The macros were pretty bad, so I decided to rewrite basically all the macros, only the system to bind keys has been kept.
; Contact me on Discord for more help, but please check the information below first, and don't be so lazy that you can't read my wall of text. (smilla kult#4725)


; NOTES:
; Chat macros are way slower when using Flawless widescreen with GTA V. I don't know why this is, but it makes them far slower. Watch out for that, I guess. Also makes EWO slower.
; The only way I could fix the above issue is by getting the source code of AHK, and manually removing the SendInput fallback. But I'm not that kind of coder, im the stupid kind.
; I know the standard binds are absolute dogshit, but that is because I'm left handed. If someone wants to suggest good default binds for right handed people, which is basically everyone but you already know that, let me know, i'll change them, and credit you.
; These macros are for PVP ONLY. They may also be useful for non-PVP purposes, but this is not a macro with 5000 different hotkeys to do every thing imaginable.
; DO NOT delete the "Libraries" folder or else the script will crash when you try to use GTAHax.

; KNOWN ISSUES:
; None right now.


; Changelog:
; 3.0:
; Upped the version number by an absolutely STAGGERING 0.8 versions!!!!!!!!!!!! Wow!!!!
; Keybinding system completely rewritten! You now have an interface that lets you set binds and save binds. Very nice indeed.
; You can now change your interaction menu key, the look back key (useful for EWO), and your Special Ability (as its called in the menu) aka the one that makes you do emotes and shit (also useful for EWO).
; No, this system will not add a delay to anything. There is no delay between any of the methods of binding keys. The macros will also behave excactly the same as they did before,
; aside from the fact you can now change them more easily, and that you can choose interaction menu binds and EWO macro binds, so this should make it easier to use if anything.
; 2.2:
; Upped the version number, as per tradition again.
; Made GTAHax public, as I have found a way of making it far easier to use. The macro now automatically sets the priority of Discord to Above Normal. It also sets SocialClubHelper.exe, and Launcher.exe to Low.
; Removed all weapon macros because they are useless.
; MASSIVELY improved the formatting of the entire script, the keybinding system is sorted to the actual text now, and it is easier to edit. Moved the descriptions of the macros to where the macros are located in the file.
; Fixed some spelling errors on the chat macros.
; Improved ammo macros.
; Disabled CapsLock because it is gay.
; Added to Github!
; 2.1:
; Upped the version number, as per tradition again.
; Added FastRespawn. Added Suspend, which is not a macro, but it suspends the hotkeys. In other words, it cancels the macros and disables them until you press the button again.
; Chat macros have been slightly modified. Made Thermal Helmet macro faster.
; 2.0:
; Upped the version number, as per tradition again.
; Gone public! Almost completely rewritten!
; Added 3 new chat macros, removed old chat macros. Added RPG, Stickybomb, Pistol, and Sniper. Added the GTAHax macro, which applies the no EWO cooldown code.
; All macros are significantly faster! All macros are also more reliable!
; The EWO macro in particular is now ridiculously fast.
; 1.0.1-1.3.1:
; Upped the version number, as per tradition.
; Not much, almost none of the code present in this version is still here. The code was terrible anyways.
; 1.0:
; Upped the version number.
; Initial release.


; QNA:
; Q: How do I add new macros?
; A: Go into the libraries folder included in the ZIP file, and right click on Extra Scripts.ahk. Click on "edit". Now, figure it out on your own it's not that hard i have an example there already
; Q: How do I change my weapon loadout? 
; A: Go to your CEO office or any other place with a "Weapon Locker" and then remove weapons that you don't need/want.
; Q: How do I remove macros? 
; A: Uh.... Fuck this it is way harder now just contact me on discord if you want to remove macros. Unless you're talking about the extra scripts, then you do the following:
; Go up to the "Hotkey Code" Section, and remove the specific (Hotkey, %EXAMPLE%, EXAMPLE;) that you don't want.
; Now, remove that code, and then, go up to the "Assign Hotkeys" section and remove the corressponding bind, or else the macro will not start.