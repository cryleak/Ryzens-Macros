 SetBatchLines, -1 ; Removes the built in 10ms sleep that happens after every line of code normally. It should never sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.
if not A_IsAdmin ; Runs the script as an admin.
	Run *RunAs "%A_ScriptFullPath%"

; Debug:
/*
ListLines Off ; Removes line history, makes the script slightly more secret.
#KeyHistory 0 ; Removes key history, makes the script slightly more secret.
*/



; GTAHaX EWO Offsets:
FreemodeGlobalIndex = 262145
EWOGlobalOffset1 = 28397
; GTAHaX EWO Score Offsets:
ScoreGlobalIndex = 2703735
ScoreGlobalOffset1 = 1571
ScoreGlobalOffset2 = 817
; CEO Circle Offsets:
CEOCircleGlobalIndex = 1892703
CEOCircleGlobalOffset1 = 5
CEOCircleGlobalOffset2 = 10
CEOCircleGlobalOffset3 = 11

; Add them together
FreemodeGlobalIndexAddedTogether := FreemodeGlobalIndex + EWOGlobalOffset1 ; Calculates the Global Index for EWO Cooldown
ScoreGlobalIndexAddedTogether := ScoreGlobalIndex + ScoreGlobalOffset1 + ScoreGlobalOffset2 ; Calculates the Global Index for EWO Score
CEOCircleGlobalIndexAddedTogether := CEOCircleGlobalIndex + CEOCircleGlobalOffset1 + CEOCircleGlobalOffset2 + CEOCircleGlobalOffset3 ; Calculates the Global Index for CEO Circle

Goto, CheckHWID ; Checks your PC's UUID. Shitty but it works
Backk: ; It goes back to this checkpoint. It works.
MacroVersion = 3.21-beta ; Macro version
CFG = GTA Binds.ini ; Config file name
CrosshairDone := 0 ; If crosshair has been applied
MCCEO2 := 0 ; If you are in MC
WriteWasJustPerformed = 0
If not WinExist("ahk_class grcWindow") {
   GTAAlreadyClosed = 1
} else {
   GTAAlreadyClosed = 0
}
MsgBox, 0, Ryzen's Macros %MacroVersion%, Successfully started. Welcome to Ryzen's Macros!
IniRead,DebugTesting,%CFG%,Debug,Debug Testing ; Checks if debug testing is true, usually false.
#SingleInstance, force ; Forces single instance
#IfWinActive ahk_class grcWindow ; Hotkeys will only work if you are tabbed in.
#MaxThreadsPerHotkey 1 ; Doesn't really matter
#MaxThreads 99999 ; Sets the maximum amount of active threads to practically infinity.
#MaxThreadsBuffer On ; Makes hotkeys buffer if you hold it down or something.
#MaxHotkeysPerInterval 99000000 ; Doesn't matter but AHK may give you an error if you spam hotkeys really really fast otherwise.
#HotkeyInterval 99000000 ; Same as the other hotkey interval setting
#Persistent ; Makes the script never exit, probably unneccassary because other commands (like hotkey) already cause it to never exit.
SetTitleMatchMode, 2 ; I forgor :dead_skull:
SetDefaultMouseSpeed, 0 ; Something
SetKeyDelay, -1, -1 ; Sets key delay to the lowest possible, there is still delay due to the keyboard hook in GTA, but this makes it excecute as fast as possible WITHOUT skipping keystrokes. Set this a lot higher if you uninstalled the keyboard hook using mods.
SetWinDelay, -1 ; After any window modifying command, the script has a built in delay. Fuck delays.
SetControlDelay, 0 ; After any control modifying command, for example; ControlSend, there is a built in delay. Set to 0 instead of -1 because having a slight delay may improve reliability, and is unnoticable anyways.
SetWorkingDir %A_ScriptDir% ; Sets the default working directory of the script.
Gui, Font,, Segoe UI Semibold ; Sets font to something
Global processName := "SocialClubHelper.exe"
Global Level := "L"
Gosub, Priority ; Sets priority of "SocialClubHelper.exe" to "L"
Global processName := "Launcher.exe"
Global Level := "L"
Gosub, Priority ; Sets priority of "Launcher.exe" to "L"
Gui, Font, q5 ; Font quality, I don't know why this is a seperate line to the other font command above.
Gui, Add, Tab3,, Combat|Chat|In-Game Binds|Options|Custom|Buttons/Misc|| ; Adds tabs to the GUI
Gosub, CombatMacros ; Combat Macros
Gosub, ChatMacros ; Chat Macros
Gosub, InGameBinds ; In-Game Binds
Gosub, MacroOptions ; Options for the macros
Gosub, MiscMacros ; Custom Macros and a few Misc Macros.
Gosub, SavingAndButtonsAndMiscMacros ; Buttons and some more settings and shit

Gosub, Read ; Reads your config file
GuiControl,,CEOMode,1 ; Sets CEO Mode to 1 whenever you start the script
DetectHiddenWindows, ON ; It does something 
Gui0 := WinExist( A_ScriptFullpath " ahk_pid " DllCall( "GetCurrentProcessId" ) ) ; I forgor
DetectHiddenWindows, OFF ; It does something

Menu, Tray, NoStandard ; Default trays but with some extra things above it, usually not possible so you need to do some complicated things to make it work.
Menu, Tray, Add, Show UI, ShowGUI
Menu, Tray, Add, Hide UI, HideWindow
Menu, Tray, Add, Save Macros, SaveConfig
Menu, Tray, Add
Menu, Tray, Add, Open,                StandardTrayMenu
Menu, Tray, Add, Help,                StandardTrayMenu
Menu, Tray, Add
Menu, Tray, Add, Window Spy,          StandardTrayMenu
Menu, Tray, Add, Reload This Script,  Reload
Menu, Tray, Add
Menu, Tray, Add, Suspend Hotkeys,     StandardTrayMenu
Menu, Tray, Add, Pause Script,        StandardTrayMenu
Menu, Tray, Add, Exit,                ExitMacros
Menu, Tray, Default, Open

If (DebugTesting = maybeillusethisometimeinthefuture) { ; Adds some debug text if debug testing is true
   Menu, Tray, Tip, Ryzen's Macros Version %MacroVersion%-%DebugText%
   Gui, Show,, Ryzen's Macros Version %MacroVersion%-%DebugText%
} else {
   Menu, Tray, Tip, Ryzen's Macros Version %MacroVersion%
   Gui, Show,, Ryzen's Macros Version %MacroVersion%
}
;MsgBox, 0, Welcome!, HWID Matching! Welcome to Ryzen's Macros. Add me on Discord (cryleak#3961) if you have any issues. Good luck.
Gosub, StandardTrayMenu
Return

Reload:
   Process, Close, %Gay%
   Process, Close, %Gay2%
   Process, Close, %Obese11%
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
   Process, Close, %Gay%
   Process, Close, %Gay2%
   Process, Close, %Obese11%
ExitApp
return

HideWindow:
Gui, Hide
return

ThermalHelmet:
SendInput {Blind}{lbutton up}{enter down}
GuiControlGet, CEOMode
GuiControlGet, NightVision
Send {Blind}{%InteractionMenuKey%}{down 3}
If (CEOMode = 1) 
   Send {Blind}{down} 
SendInput {Blind}{enter up}
Send {Blind}{down down}
SendInput {Blind}{enter down}
Send {Blind}{down up}
SendInput {Blind}{enter up}
If (NightVision = 0)
   Send {Blind}{down 4}
sleep 50
Send {Blind}{space}{%InteractionMenuKey%}
return

FastSniperSwitch:
SendInput {Blind}{%FastSniperSwitch% up}
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
GuiControlGet, EWOWrite
If (SmoothEWOMode = "Fast Respawn") { 
      SendInput {Blind}{lshift down}{w up}{a up}{s up}{d up}
      Hotkey, Tab, ProBlocking, On
      BlockInput, On
      MouseMove,0,5000,,R
      SendInput {Blind}{%FranklinBind% down}
      sleep 50
      SendInput {Blind}{lbutton down}
      If (BugRespawnMode = "Homing") {
         sleep 340
      } else if (BugRespawnMode = "RPG") {
         sleep 393
   }
   SendInput {Blind}{%FranklinBind% up}{lshift up}
   BlockInput, Off
   sleep 75
   Send {Blind}{esc}{lbutton up}
   sleep 1500
   Send {Blind}{%StickyBind%}{%RPGBind%}{tab}
   Hotkey, Tab, ProBlocking, Off
   sleep 200
} else if (SmoothEWOMode = "Sticky") {
   SendInput {lbutton down}{rbutton up}
   Send {Blind}{%RifleBind%}
   SendInput {lbutton up}
   Send {Blind}{tab} ; {lbutton 5}
   Loop, 15 {
      if WinActive("ahk_class grcWindow") {
         Send {Blind}{g 4} ; {lbutton}
      }
   } 
   SendInput {Blind}{lbutton up}
} else {
SetMouseDelay, -1
if (SmoothEWO = 1) {
/*
      If (SmoothEWOMode = "Faster") {
            if (getKeyState("rbutton", "P")) {
            SendInput {Blind}{lbutton up}{rbutton up}
            DllCall("Sleep",UInt,50)
            }
         }
         else if (SmoothEWOMode = "Slow") {
            if (getKeyState("rbutton", "P")) {
            SendInput {Blind}{lbutton up}{rbutton up}
            DllCall("Sleep",UInt,50)
            }
         }
*/
   If (SmoothEWOMode = "Faster") {
      SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{d up}{w up}{s up}{a up}{enter down}{%EWOLookBehindKey% down}{%InteractionMenuKey% down}
      DllCall("Sleep",UInt,14)
      Send {Blind}{shift down}{f24 up}{shift up}{up}
      DllCall("Sleep",UInt,9)
      Send {Blind}{up}
      DllCall("Sleep",UInt,9)
      Send {Blind}{%EWOSpecialAbilitySlashActionKey% down}{enter up}
   } else if (SmoothEWOMode = "Slow") {
      StringUpper, EWOLookBehindKey, EWOLookBehindKey
      SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{d up}{w up}{s up}{a up}{enter down}
      Send {Blind}{%InteractionMenuKey%}
      DllCall("Sleep",UInt,7)
      Send {Blind}{%EWOLookBehindKey% down}{up}
      DllCall("Sleep",UInt,11)
      Send {Blind}{up}{f24 up}
      DllCall("Sleep",UInt,32)
      Send {Blind}{%EWOSpecialAbilitySlashActionKey% down}{enter up}
      StringLower, EWOLookBehindKey, EWOLookBehindKey
      } else if (SmoothEWOMode = "Fastest") {
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}
         Send {Blind}{%InteractionMenuKey%}{up 2}
         SendInput {%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{enter}
      }
      else if (SmoothEWOMode = "Retarded") {
         StringUpper, EWOLookBehindKey, EWOLookBehindKey
         SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}{%EWOMelee% down}
         DllCall("Sleep",UInt,30)
         Send {Blind}{up}
         DllCall("Sleep",UInt,20)
         Send {Blind}{up}
         DllCall("Sleep",UInt,10)
         Send {Blind}{%EWOLookBehindKey% down}{f24}{f24 up}{enter up}
         StringLower, EWOLookBehindKey, EWOLookBehindKey
      }
      else if (SmoothEWOMode = "Retarded2") {
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{f24 down}{f23 down}{f22 down}
         SendInput {Blind}{wheelup}{up up}{space down}{%EWOLookBehindKey% down}
         Send {Blind}{f24}{enter up}{%EWOLookBehindKey% up}{space up}
      }
      } else if (SmoothEWO = 0) {
      SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}
      Send {Blind}{f24 down}{f23 down}{f22 down}
      SendInput {Blind}{wheelup}{enter up}{up up}
   }
SendInput {Blind}{%EWOSpecialAbilitySlashActionKey% up}
SetCapsLockState, Off
Send {Blind}{enter 2}{up down}
SendInput {Blind}{enter down}
Send {Blind}{up up}
SendInput {Blind}{enter up}
Send {Blind}{left}{down}
SendInput {Blind}{%EWOLookBehindKey% up}{%EWOMelee% up}{%InteractionMenuKey% up}{up up}{g up}{f24 up}{f23 up}{f22 up}{f20 up}{%EWO% up}
SetMouseDelay, 10
}
return

Write:
If WinActive("ahk_class grcWindow") {
   If (GTAAlreadyClosed = 0) {
      if not WinExist("ahk_exe GTAHaXUI.exe") { ; If window doesn't exist, make it exist and add shit to it
         Run, GTAHaXUI.exe, %A_ScriptDir%,Min,Gay2
         WinWait, ahk_pid %Gay2%
         ControlSend, Edit1, {down}{backspace}%ScoreGlobalIndexAddedTogether%, ahk_pid %Gay2%
         sleep 20
         SendInput {lbutton up}
      } else { ; If it does exist
         ControlGet, Cocaine,Line,1,Edit1,ahk_pid %Gay2% ; Get the value of controls and shiznit
         ControlGet, Heroin,Line,1,Edit7,ahk_pid %Gay2%
         ControlGet, AIDS,Line,1,Edit8,ahk_pid %Gay2%
         If (Heroin = 1) && (Cocaine = ScoreGlobalIndexAddedTogether) && (AIDS = 0) { ; If the values are correct do this shit
         ControlClick, Button1, ahk_pid %Gay2%
         WriteWasJustPerformed = 1
         SetTimer, WriteWasPerformed, -200
         } else {
            If not (Cocaine = ScoreGlobalIndexAddedTogether) { ; If global index isn't correct, then close GTAHaX and remake the window. Too lazy to remove everything, this is better anyways.
               Process, Close, %Gay2%
               Goto, Write
            }
            If not (AIDS = 0) { ; Same thing here but if the value you want to set it to is not 0, then it will restart GTAHaX and redo it.
               Process, Close, %Gay2%
               Goto, Write
            }
         }
      }
   }
}
Return

WriteWasPerformed:
WriteWasJustPerformed = 0
Return

TabBackInnn:
If (WriteWasJustPerformed = 1)
   WinActivate, ahk_exe GTA5.exe
Return

EWOWrite:
GuiControlGet, EWOWrite
If (EWOWrite = 1) {
   MsgBox, 4,Warning!,Please note that this is a bit buggy`, and that the bugs are unfixable`, although it still works pretty well. Use the Cheat Engine method for a 100`% consistent method`, but also note that Cheat Engine may trigger RAC`, so I would not suggest doing recoveries on your account if you have used Cheat Engine without having another Mod Menu installed. Do you still want to continue?
   IfMsgBox No
      Goto NO!
}
If (EWOWrite = 1) {
   SetTimer, Write, 10
   SetTimer, TabBackInnn, 10
}
else {
   SetTimer, Write, Off
   SetTimer, TabBackInnn, Off
}
Return

NO!:
GuiControl,,EWOWrite,0
Return

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
SendInput {Blind}{lbutton up}{enter down}
GuiControlGet, CEOMode
GuiControlGet, BSTSpeed
GuiControlGet, BSTMC
If (CEOMode = 0)
   MsgBox, 0, Warning!, You are not in a CEO!
else {
   Send {Blind}{%InteractionMenuKey%}{enter up}
   If (BSTSpeed = 1) {
      Send {Blind}{up}
      SendInput {Blind}{enter down}
      Send {Blind}{up 2}
      SendInput {Blind}{enter up}
   } Else {
         Send {Blind}{down}
         SendInput {Blind}{enter down}
         Send {Blind}{down 3}
         SendInput {Blind}{enter up}
      }
   Send {Blind}{down down}
   SendInput {Blind}{enter down}
   Send {Blind}{down up}
   SendInput {Blind}{enter up}
}
return

Ammo:
SendInput {Blind}{lbutton up}{enter down}
GuiControlGet, CEOMode
Send {Blind}{%InteractionMenuKey%}
If (CEOMode) = 1 {
   Send {Blind}{down 2}
   SendInput {Blind}{WheelDown}
} Else {
      Send {Blind}{down}
      SendInput {Blind}{WheelDown}
}
Send {Blind}{enter up}{down}
SendInput {Blind}{enter down}
Send {Blind}{down 4}
SendInput {Blind}{enter up}
Send {Blind}{enter}{up down}
SendInput {Blind}{enter down}
Send {Blind}{up up}
SendInput {Blind}{enter up}
Send {Blind}{%InteractionMenuKey%}
Sleep 125
return

FastRespawn:
Send {Blind}{lbutton 30}
return

ProBlocking:
Return

GTAHax:
SendInput {Blind}{%GTAHax% up}
Run, GTAHaXUI.exe, %A_ScriptDir%,,Gay
WinWait, ahk_pid %Gay%
ControlSend, Edit1, {down}{backspace}%FreemodeGlobalIndexAddedTogether%, ahk_pid %Gay%
sleep 100
ControlClick, Button1, ahk_pid %Gay%
sleep 100
ControlSend, Edit2, {down}{backspace}1, ahk_pid %Gay%
sleep 100
ControlClick, Button1, ahk_pid %Gay%
sleep 100
MsgBox, 0, Complete!, You should now have no EWO cooldown. Kill yourself with a Sticky/RPG if you currently have a cooldown.
Process, Close, %Gay%
return

GTAHax2:
If (EWOWrite = 0) {
   GuiControlGet, EWOWrite
   SendInput {Blind}{%GTAHax% up}
   Run, GTAHaXUI.exe, %A_ScriptDir%,Min,Obese11
   WinWait, ahk_pid %Obese11%
   ControlSend, Edit1, {down}{backspace}%ScoreGlobalIndexAddedTogether%, ahk_pid %Obese11%
   ControlSend, Edit8, {down}{backspace}12345678, ahk_pid %Obese11%
   sleep 100
   ControlClick, Button1, ahk_pid %Obese11%
   sleep 250
   MsgBox, 0, Complete!, Search for the value 12345678 using Cheat Engine and lock the value to 0 for it to work properly. If you are dumb, ignore this. If you don't understand what it does but are not dumb, ask me what to do.
   Process, Close, %Obese11%
} else {
   MsgBox, 0, xdddd, you need to have disabled show ewo score without cheat engine for this to do anything
}
return

GTAHaxCEO:
SendInput {Blind}{%GTAHax% up}
Run, GTAHaXUI.exe, %A_ScriptDir%,,Gay
WinWait, ahk_pid %Gay%
ControlSend, Edit1, {down}{backspace}%CEOCircleGlobalIndexAddedTogether%, ahk_pid %Gay%
sleep 30
ControlClick, Button1, ahk_pid %Gay%
sleep 30
;msgbox 0
Loop, 32 { ; Recreates the function that determines what memory address this global should be in, and tests every possible combination of that.
   PlayerID := a_index
   PlayerID1 := PlayerID * 599
   ControlSend, Edit2, {down}{backspace 5}%PlayerID1%, ahk_pid %Gay%
   sleep 30
   ControlClick, Button1, ahk_pid %Gay%
   sleep 30
   ;msgbox %PlayerID1%
}
sleep 250
MsgBox, 0, Complete!, The fucking CEO circle should be back now. It will probably disappear again if you leave CEO or something.
Process, Close, %Gay%
Return

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
SendInput game im gonna swat the r* head
Send q
SendInput uarters man i
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
Send {Blind}{t down}
SendInput {Blind}{enter down}
Send {Blind}{t up}{f24 up}
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
Send {Blind}{enter up}
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
   Send {Blind}{enter up}
}
}
else if Length <= 30 
{
   If (RawText = 1) {
Loop, 8 {
   Send {Blind}{t down}
   SendInput {enter down}
   Send {Blind}{t up}{f24 up}
   SendInput {Raw}%CustomSpamText%
   Send {Blind}{enter up}
}
} else {
      Loop, 8 {
         Send {Blind}{t down}
         SendInput {enter down}
         Send {Blind}{t up}{f24 up}
         SendInput %CustomSpamText%
         Send {Blind}{enter up}
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
SendInput {Raw}%Clipboard%
}
return

ShutUp:
Loop, 8 {
Send {Blind}{t down}
SendInput {Blind}{enter down}
Send {Blind}{t up}{f24 up}
SendInput {Blind}shut up
Send {Blind}{enter up}
}
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
SendInput {Blind}{lbutton up}{enter down}
GuiControlGet, CEOMode
Send {Blind}{%InteractionMenuKey%}
If (CEOMode = 1) 
   Send {Blind}{down 4}
   Else
      Send {Blind}{down 3}
SendInput {Blind}{enter up}
Send {Blind}{down}
SendInput {Blind}{enter down}
Send {Blind}{down 2}
SendInput {Blind}{enter up}
Send {Blind}{%InteractionMenuKey%}
return

Crosshair5:
WinGetActiveTitle, OldActiveWindow
GuiControlGet, CrosshairPos
If not (CrossHairPos = "") {
   GuiControlGet, Crosshair
      if(crossHair = 1) {
   Global crossHairW := 21
   Global crossHairH := 21

   Global backgroundColor := 0xff00cc

   SysGet, screenW, 78
   SysGet, screenH, 79


      Global crossHairX := (screenW / CrosshairPos) - (crossHairH / 2)
      Global crossHairY := (screenH / 2) - (crossHairH / 2)
      WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
   IfNotExist, %A_WorkingDir%\assets
      FileCreateDir, %A_WorkingDir%\assets

   FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

   Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
   Gui, Color, backgroundColor
   Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
   Try {
      Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
   } Catch {
      Gui, Crosshair: Hide
   }
   WinSet, TransColor, backgroundColor, Crosshair
      } else {
   Gui, Crosshair: Hide
      }
} else {
   Gui, Crosshair: Hide
}
WinActivate, %OldActiveWindow%
return

Crosshair6:
WinGetActiveTitle, OldActiveWindow
GuiControlGet, CrosshairPos
If not (CrossHairPos = "") {
   GuiControlGet, Crosshair
      if(crossHair = 1) {
   Global crossHairW := 21
   Global crossHairH := 21

   Global backgroundColor := 0xff00cc

   SysGet, screenW, 78
   SysGet, screenH, 79

      Global crossHairX := (screenW / CrosshairPos) - (crossHairH / 2)
      Global crossHairY := (screenH / 2) - (crossHairH / 2)
      WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
   IfNotExist, %A_WorkingDir%\assets
      FileCreateDir, %A_WorkingDir%\assets

   FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

   Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
   Gui, Color, backgroundColor
   Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
   Try {
      Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
      } Catch {
         Gui, Crosshair: Hide
   }
   WinSet, TransColor, backgroundColor, Crosshair
      } else {
   Gui, Crosshair: Hide
      }
      WinActivate, ahk_class grcWindow
} else {
   Gui, Crosshair: Hide
}
WinActivate, %OldActiveWindow%
return

ProcessCheck3:
GuiControlGet, ProcessCheck2
if (ProcessCheck2 = 0) {
SetTimer, ProcessCheckTimer, Off
} else {
SetTimer, ProcessCheckTimer, 100
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
SendInput {Blind}{lbutton up}{enter down}
GuiControlGet, CEOMode
If (CEOMode = 0) {
   Send {Blind}{%InteractionMenuKey%}{down 6}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}
GUIControl,, CEOMode, 1
}
else {
   Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
   SendInput {Blind}{enter down} 
   Send {Blind}{up up}
   SendInput {Blind}{enter up}
GUIControl,, CEOMode, 0
}
return

ProcessCheckTimer:
If (GTAAlreadyClosed = 0) {
   GuiControlGet, ProcessCheck2
   If not (ProcessCheck2 = 0) {
      If not WinExist("ahk_class grcWindow") {
         Gosub, CloseGTAProcesses
         SetTimer, Write, Off
         SetTimer, CloseGTAHaX, 100
         SetTimer, ExitMacros, -10000
         MsgBox, 0, Macros will close now. RIP., GTA is no longer running. Macros will close now. RIP.
            Process, Close, %Gay%
            Process, Close, %Gay2%
            Process, Close, %Obese11%
            ExitApp
         }
      }
}
return

CloseGTAProcesses:
Process, Close, GTA5.exe
Process, Close, Launcher.exe
Loop, 6
   Process, Close, SocialClubHelper.exe
Process, Close, LauncherPatcher.exe
Return

SniperBind:
Send {Blind}{%SniperBind%}{tab}
return

RPGBind:
Send {Blind}{%RPGBind%}{tab}
return

StickyBind:
Send {Blind}{%StickyBind%}{tab}
Return

PistolBind:
Send {Blind}{%PistolBind%}{tab}
return

RPGSpam:
SendInput {Blind}{%StickyBind% down}
Send {Blind}{%RPGBind% down}{tab}{%StickyBind% up}{%RPGBind% up}
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
SendInput {Blind}{lbutton up}{enter down}
Send {Blind}{%InteractionMenuKey%}{up 8}
SendInput {Blind}{enter up}
Send {Blind}{down down} 
SendInput {Blind}{enter down} 
Send {Blind}{down up}
SendInput {Blind}{enter up}
sleep 25
Send {Blind}{left}
Loop, 14 {
Send {Blind}{down down}
SendInput {Blind}{enter down}
Send {Blind}{down up}
SendInput {Blind}{enter up}
}
Send {Blind}{%InteractionMenuKey%}
return

MCCEO:
SendInput {lbutton up}{enter down}
if (MCCEO2 = 0) {
   Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
   SendInput {Blind}{enter down}
   Send {Blind}{up up}
   SendInput {Blind}{enter up}
   sleep 200
   SendInput {Blind}{enter down}
   Send {Blind}{%InteractionMenuKey%}{down 7}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}
   Loop, 35 {
      Send {Blind}{backspace down}
      SendInput {Blind}{enter down}
      Send {Blind}{backspace up}
      SendInput {Blind}{enter up}
      Send {Blind}{enter}
}
   sleep 25
   MCCEO2 := 1
}
   else {
   Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
   SendInput {Blind}{enter down}
   Send {Blind}{up up}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}
   sleep 200
   SendInput {Blind}{enter down}
   Send {Blind}{%InteractionMenuKey%}{down 6}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}
   Loop, 35 {
      Send {Blind}{backspace down}
      SendInput {Blind}{enter down}
      Send {Blind}{backspace up}
      SendInput {Blind}{enter up}
      Send {Blind}{enter}
}
   sleep 25
   MCCEO2 := 0
}
GuiControl,, CEOMode, 1
return

LaunchCycle: 
{
      GuiControlGet, Paste ; Checks if pasting chat messages is enabled, and then it will enable it.
      If (Paste = 0)
         Hotkey, ^v, Paste, Off
         else
            Hotkey, ^v, Paste, On
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
      WinGetActiveTitle, OldActiveWindow
      GuiControlGet, CrosshairPos
      If not (CrossHairPos = "") {
      If (CrosshairDone = 0) {
      GuiControlGet, Crosshair
         if(crossHair = 1) {
      Global crossHairW := 21
      Global crossHairH := 21

      Global backgroundColor := 0xff00cc

      SysGet, screenW, 78
      SysGet, screenH, 79
 
   Global crossHairX := (screenW / CrosshairPos) - (crossHairH / 2)
   Global crossHairY := (screenH / 2) - (crossHairH / 2)
   WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
      IfNotExist, %A_WorkingDir%\assets
         FileCreateDir, %A_WorkingDir%\assets

      FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false

      Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
      Gui, Color, backgroundColor
      Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%,  %A_WorkingDir%\assets\crosshair.png
      Try {
         Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
         } Catch {
            Gui, Crosshair: Hide
      }
      WinSet, TransColor, backgroundColor, Crosshair
         } else {
      Gui, Crosshair: Hide
         }
      }
      } else {
         Gui, Crosshair: Hide
      }
      CrosshairDone := 1
WinActivate, %OldActiveWindow%
return
}

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
SendInput {Blind}{%IncludeHotkeyChat1% up}
Send {Blind}{t down}
SendInput {Blind}{enter down}
Send {Blind}{t up}{f24 up}
SendInput {Raw}%IncludeMacroChat1%
Send {Blind}{enter up}
}
else if Length3 <= 30
{
SendInput {Blind}{%IncludeHotkeyChat1% up}
Send {Blind}{t down}
SendInput {Blind}{enter down}
Send {Blind}{t up}{f24 up}
SendInput {raw}%IncludeMacroChat1%
Send {Blind}{enter up}
}
return

IncludeHotkeyChat02:
Length4 := StrLen(IncludeMacroChat2)
if (Length4 >= 31) {
SendInput {Blind}{%IncludeHotkeyChat2% up}
Send {Blind}{t down}
SendInput {Blind}{enter down}
Send {Blind}{t up}{f24 up}
SendInput {Raw}%IncludeMacroChat2%
Send {Blind}{enter up}
}
else if Length4 <= 30
{
SendInput {%IncludeHotkeyChat2% up}
Send {Blind}{t down}
SendInput {Blind}{enter down}
Send {Blind}{t up}{f24 up}
SendInput {Raw}%IncludeMacroChat2%
Send {Blind}{enter up}
}
return

DisableAll:
Hotkey, *%ThermalHelmet%, ThermalHelmet, UseErrorLevel Off
Hotkey, *%FastSniperSwitch%, FastSniperSwitch, UseErrorLevel Off
Hotkey, *%EWO%, EWO, UseErrorLevel Off
Hotkey, *%KekEWO%, KekEWO, UseErrorLevel Off
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
Hotkey, *%RPGSpam%, RPGSpam, UseErrorLevel Off
Return

   NotExist1:
   IfNotExist, %CFG% 
   {
   GuiControl,,InteractionMenuKey,m
   GuiControl,,FranklinBind,F6
   GuiControl,,ThermalHelmet,
   GuiControl,,FastSniperSwitch,
   GuiControl,,SniperBind,9
   GuiControl,,RifleBind,8
   GuiControl,,EWO,
   GuiControl,,EWOWrite,0
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
   GuiControl,,Jobs,
   GuiControl,,Paste,0
   GuiControl,,MCCEO,
   GuiControl,,SmoothEWO,0
   GuiControl,,FasterSniper,1
   GuiControl,Choose,SmoothEWOMode,Fastest
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
Gui, Add, Link,x+5 y60, Toggle Thermal: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-Thermal">(?)</a> 
Gui, Add, Link,, Sniper Switch: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Sniper-Switch">(?)</a> 
Gui, Add, Link,, EWO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/EWO">(?)</a> 
Gui, Add, Link,, BST: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/BST">(?)</a> 
Gui, Add, Link,, Ammo: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Ammo">(?)</a> 
Gui, Add, Link,, Fast Respawn: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Fast-Respawn">(?)</a> 
Gui, Add, Link,, Toggle Crosshair: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-Crosshair">(?)</a> 
Gui, Add, Link,, RPG Spam: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/RPG-Spam">(?)</a> 
Gui, Add, Link,, Fast Switch <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Fast-Switch">(?)</a> 

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
Gui, Add, Link,x+5 y60, Epic Roast: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Epic-Roast">(?)</a> 
Gui, Add, Link,, Essay About GTA: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Essay-About-GTA">(?)</a> 
Gui, Add, Link,, Custom Text Spam: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Text-Spam">(?)</a> 
Gui, Add, Link,, Custom Spam Text <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Spam-Text">(?)</a> 
Gui, Add, Link,, Raw Text? <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Spam-Text">(?)</a> 
Gui, Add, Link,, Shut Up: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Shut-Up">(?)</a> 
Gui, Add, Link,, Suspend: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Suspend">(?)</a> 

Gui, Add, Hotkey,vHelpWhatsThis x+110 y60,
Gui, Add, Hotkey,vEssayAboutGTA,
Gui, Add, Hotkey,vCustomTextSpam,
Gui, Add, Edit, Limit140 vCustomSpamText
Gui, Add, Checkbox, vRawText h20,
Gui, Add, Hotkey,vShutUp,
Gui, Add, Hotkey,vSuspend,
Return

InGameBinds:
Gui, Tab, 3
Gui, Add, Link,x+5 y60, Interaction Menu: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Interaction-Menu-Bind">(?)</a> 
Gui, Add, Link,, Sniper Rifle: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Sniper-Rifle-Bind">(?)</a> 
Gui, Add, Link,, EWO Look Behind: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/EWO-Look-Behind-Key">(?)</a> 
Gui, Add, Link,, EWO Special Ability: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/EWO-Special-Ability-Key">(?)</a> 
Gui, Add, Link,, EWO Melee: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/EWO-Melee-Bind">(?)</a> 
Gui, Add, Link,, Heavy Weapon: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Heavy-Weapon-Bind">(?)</a> 
Gui, Add, Link,, Sticky Bomb: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Sticky-Bomb-Bind">(?)</a> 
Gui, Add, Link,, Pistol: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Pistol-Bind">(?)</a> 
Gui, Add, Link,, Rifle: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Rifle-Bind">(?)</a> 
Gui, Add, Link,, Swap to Franklin Bind: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Swap-to-Franklin-Bind">(?)</a> 

Gui, Add, Hotkey,vInteractionMenuKey x+110 y60,
Gui, Add, Hotkey,vSniperBind,
Gui, Add, Hotkey,vEWOLookBehindKey,
Gui, Add, Hotkey,vEWOSpecialAbilitySlashActionKey,
Gui, Add, Hotkey,vEWOMelee,
Gui, Add, Hotkey, vRPGBind,
Gui, Add, Hotkey, vStickyBind,
Gui, Add, Hotkey, vPistolBind,
Gui, Add, Hotkey, vRifleBind,
Gui, Add, Hotkey, vFranklinBind,
Return

MacroOptions:
Gui, Tab, 4
Gui, Add, Link,x+5 y60, BST Less Reliable <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/BST-Less-Reliable-But-Faster">(?)</a> 
Gui, Add, Link,, Check if GTA open <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Check-if-GTA-is-Open">(?)</a> 
Gui, Add, Link,, Faster Sniper Switch <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Faster-Sniper-Switch">(?)</a> 
Gui, Add, Link,, Crosshair: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Crosshair">(?)</a> 
Gui, Add, Link,, Custom crosshair position: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-crosshair-position">(?)</a> 
Gui, Add, Link,, Night Vision Thermal <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Night-Vision-Thermal">(?)</a> 
Gui, Add, Link,, Slower EWO? <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a> 
Gui, Add, Link,, Slower EWO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a> 
Gui, Add, Link,, CEO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/CEO-Mode">(?)</a> 
Gui, Add, Link,, Optimize Fast Respawn EWO for: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Optimize-Fast-Respawn-EWO-For">(?)</a> 

Gui, Add, Checkbox,vBSTSpeed h20 x+105 y60,
Gui, Add, CheckBox, gProcessCheck3 vProcessCheck2 h20,
Gui, Add, CheckBox, vFasterSniper h20,
Gui, Add, Checkbox, gCrossHair5 vCrossHair h20,
Gui, Add, Edit, gCrosshair5 vCrosshairPos h20,
Gui, Add, CheckBox, vNightVision h20,
Gui, Add, Checkbox, vSmoothEWO h20,
Gui, Add, DropDownList, vSmoothEWOMode, Fast Respawn|Sticky|Retarded|Retarded2|Slow|Faster|Fastest
Gui, Add, CheckBox, vCEOMode h20,
Gui, Add, DropDownList, vBugRespawnMode, Homing|RPG
Return


MiscMacros:
Gui, Tab, 5
Gui, Add, Link,x+5 y60, Custom #1: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-1-6">(?)</a> 
Gui, Add, Link,, Custom #2: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-1-6">(?)</a> 
Gui, Add, Link,, Custom #3: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-1-6">(?)</a> 
Gui, Add, Link,, Custom #4: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-1-6">(?)</a> 
Gui, Add, Link,, Custom #5: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-1-6">(?)</a> 
Gui, Add, Link,, Custom #6: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-1-6">(?)</a> 
Gui, Add, Link,, Custom Chat #1: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Chat-1-2">(?)</a> 
Gui, Add, Link,, Custom Chat #2: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Chat-1-2">(?)</a> 
Gui, Add, Link,, Kek EWO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Kek-EWO">(?)</a> 

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
Gui, Add, Button, gGTAHaxCEO h20, bring back the fucking ceo circle
If (DebugTesting = 1) {
   Gui, Add, Button, gSpotify h20, get rid of noob spotify
   DebugText = beta
   }

; Button Links
Gui, Add, Link,x158 y62, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Save-Config-Start-Macros">(?)</a>
Gui, Add, Link,x140 y89, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Start-Macros-Don't-Save">(?)</a>
Gui, Add, Link,x78 y116, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Hide-GUI">(?)</a>
Gui, Add, Link,x91 y142, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Exit-Macros">(?)</a>
Gui, Add, Link,x188 y168, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Apply-Flawless-Widescreen-Fix">(?)</a>
Gui, Add, Link,x170 y193, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Apply-GTAHaX-EWO-Codes">(?)</a>
Gui, Add, Link,x193 y219, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/bring-back-the-fucking-ceo-circle">(?)</a>
Gui, Add, Link,x418 y64, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score-(only-use-if-you-aren't-dumb)">(?)</a>

; Back to normal shit
Gui, Add, Link, x20 y270, Show UI: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-UI">(?)</a> 
Gui, Add, Link,, Toggle CEO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-CEO">(?)</a> 
Gui, Add, Link,, Reload Outfit: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Reload-Outfit">(?)</a> 

Gui, Add, Hotkey,vShowUI x+30 y270,
Gui, Add, Hotkey,vToggleCEO,
Gui, Add, Hotkey,vReloadOutfit,

Gui, Add, Link,x260 y272, Toggle Jobs: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-Jobs">(?)</a> 
Gui, Add, Link,, Copy Paste: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Copy-Paste">(?)</a> 
Gui, Add, Link,, MCCEO toggle: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/MCCEO-Toggle">(?)</a> 

Gui, Add, Hotkey, vJobs x+30 y272
Gui, Add, Checkbox, gPaste2 vPaste
Gui, Add, Hotkey, vMCCEO
Gui, Add, Button, gGTAHax2 h20 x170 y60, Show EWO Score (only use if you aren't dumb)
Gui, Add, Link,, Show EWO Score without Cheat Engine: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score-Without-Cheat-Engine">(?)</a> 

Gui, Add, Checkbox, gEWOWrite vEWOWrite h20 x+30 y84
Return

SaveConfig:
GuiControlGet, ProcessCheck2
SetTimer, Write, Off
SetTimer, TabBackInnn, Off
SetTimer, ProcessCheckTimer, Off
Gosub,DisableAll
Gui,Submit,NoHide
   IniWrite,%InteractionMenuKey%,%CFG%,Keybinds,Interaction Menu Key
   IniWrite,%FranklinBind%,%CFG%,Keybinds,Franklin Key
   IniWrite,%ThermalHelmet%,%CFG%,PVP Macros,Thermal Helmet
   IniWrite,%FastSniperSwitch%,%CFG%,PVP Macros,Fast Sniper Switch
   IniWrite,%SniperBind%,%CFG%,Keybinds,Sniper Bind
   IniWrite,%RifleBind%,%CFG%,Keybinds,Rifle Bind
   IniWrite,%EWO%,%CFG%,PVP Macros,EWO
   IniWrite,%EWOWrite%,%CFG%,PVP Macros,EWO Write
   IniWrite,%KekEWO%,%CFG%,PVP Macros,Kek EWO
   IniWrite,%EWOLookBehindKey%,%CFG%,Keybinds,EWO Look Behind Button
   IniWrite,%EWOSpecialAbilitySlashActionKey%,%CFG%,Keybinds,EWO Special Ability/Action Key
   IniWrite,%EWOMelee%,%CFG%,Keybinds,EWO Melee Key
   IniWrite,%BST%,%CFG%,PVP Macros,BST
   IniWrite,%BSTSpeed%,%CFG%,PVP Macros,BST Speed
   IniWrite,%Ammo%,%CFG%,PVP Macros,Buy Ammo
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
   IniWrite,%ProcessCheck2%,%CFG%,Misc,Process Check
   IniWrite,%NightVision%,%CFG%,Misc,Use Night Vision Thermal
   IniWrite,%RPGSpam%,%CFG%,PVP Macros,RPG Spam
   IniWrite,%RPGBind%,%CFG%,Keybinds,RPG Bind
   IniWrite,%StickyBind%,%CFG%,Keybinds,Sticky Bind
   IniWrite,%PistolBind%,%CFG%,Keybinds,Pistol Bind
   IniWrite,%TabWeapon%,%CFG%,Misc,Tab Weapon
   IniWrite,%Crosshair%,%CFG%,Misc,Crosshair
   IniWrite,%CrosshairPos%,%CFG%,Misc,Crosshair Position
   IniWrite,%Jobs%,%CFG%,Misc,Disable All Job Blips
   IniWrite,%Paste%,%CFG%,Misc,Allow Copy Paste
   IniWrite,%MCCEO%,%CFG%,Misc,MC CEO Toggle
   IniWrite,%SmoothEWO%,%CFG%,Misc,Smooth EWO
   IniWrite,%SmoothEWOMode%,%CFG%,Misc,Smooth EWO Mode
   IniWrite,%BugRespawnMode%,%CFG%,Misc,Bug Respawn Mode
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
If (EWOWrite = 1) {
   SetTimer, Write, 10
   SetTimer, TabBackInnn, 10
}
if (ProcessCheck2 = 1) {
SetTimer, ProcessCheckTimer, 100
}
;MsgBox, 0, Saved!, Your config has been saved and/or the macros have been started!, 2
If (GTAAlreadyClosed = 0) {
TrayTip, Ryzen's Macros %MacroVersion%, Your config has been saved and/or the macros have been started!, 10, 1
} else If (GTAAlreadyClosed = 1) && (ProcessCheck2 = 1) {
   TrayTip, Ryzen's Macros %MacroVersion%, GTA has not been detected to be open`, the macros will not automatically close and Show EWO Score will not work`. Please restart the macros once you have restarted GTA., 10, 1
}
Return

CloseGTAHaX:
   Process, Close, %Gay%
   Process, Close, %Gay2%
   Process, Close, %Obese11%
Return

Nice1234:
Gui,3:Hide
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
   IniRead,Read_FranklinBind,%CFG%,Keybinds,Franklin Key
   IniRead,Read_ThermalHelmet,%CFG%,PVP Macros,Thermal Helmet
   IniRead,Read_FastSniperSwitch,%CFG%,PVP Macros,Fast Sniper Switch
   IniRead,Read_SniperBind,%CFG%,Keybinds,Sniper Bind
   IniRead,Read_RifleBind,%CFG%,Keybinds,Rifle Bind
   IniRead,Read_EWO,%CFG%,PVP Macros,EWO
   IniRead,Read_EWOWrite,%CFG%,PVP Macros,EWO Write
   IniRead,Read_KekEWO,%CFG%,PVP Macros,Kek EWO
   IniRead,Read_EWOLookBehindKey,%CFG%,Keybinds,EWO Look Behind Button
   IniRead,Read_EWOSpecialAbilitySlashActionKey,%CFG%,Keybinds,EWO Special Ability/Action Key
   IniRead,Read_EWOMelee,%CFG%,Keybinds,EWO Melee Key
   IniRead,Read_BST,%CFG%,PVP Macros,BST
   IniRead,Read_BSTSpeed,%CFG%,PVP Macros,BST Speed
   IniRead,Read_Ammo,%CFG%,PVP Macros,Buy Ammo
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
   IniRead,Read_ProcessCheck2,%CFG%,Misc,Process Check
   IniRead,Read_NightVision,%CFG%,Misc,Use Night Vision Thermal
   IniRead,Read_RPGSpam,%CFG%,PVP Macros,RPG Spam
   IniRead,Read_RPGBind,%CFG%,Keybinds,RPG Bind
   IniRead,Read_StickyBind,%CFG%,Keybinds,Sticky Bind
   IniRead,Read_PistolBind,%CFG%,Keybinds,Pistol Bind
   IniRead,Read_TabWeapon,%CFG%,Misc,Tab Weapon
   IniRead,Read_Crosshair,%CFG%,Misc,Crosshair
   IniRead,Read_CrosshairPos,%CFG%,Misc,Crosshair Position
   IniRead,Read_Jobs,%CFG%,Misc,Disable All Job Blips
   IniRead,Read_Paste,%CFG%,Misc,Allow Copy Paste
   IniRead,Read_MCCEO,%CFG%,Misc,MC CEO Toggle
   IniRead,Read_SmoothEWO,%CFG%,Misc,Smooth EWO
   IniRead,Read_SmoothEWOMode,%CFG%,Misc,Smooth EWO Mode
   IniRead,Read_BugRespawnMode,%CFG%,Misc,Bug Respawn Mode
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
   GuiControl,,FranklinBind,%Read_FranklinBind%
   GuiControl,,ThermalHelmet,%Read_ThermalHelmet%
   GuiControl,,FastSniperSwitch,%Read_FastSniperSwitch%
   GuiControl,,SniperBind,%Read_SniperBind%
   GuiControl,,RifleBind,%Read_RifleBind%
   GuiControl,,EWO,%Read_EWO%
   GuiControl,,EWOWrite,%Read_EWOWrite%
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
   GuiControl,,CrosshairPos,%Read_CrosshairPos%
   GuiControl,,Jobs,%Read_Jobs%
   GuiControl,,Paste,%Read_Paste%
   GuiControl,,MCCEO,%Read_MCCEO%
   GuiControl,,SmoothEWO,%Read_SmoothEWO%
   GuiControl,Choose,SmoothEWOMode,%Read_SmoothEWOMode%
   GuiControl,Choose,BugRespawnMode,%Read_BugRespawnMode%
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

Suspend:
Suspend
Return

Priority:
PIDs := EnumProcessesByName(processName)
for k, PID in PIDs
   Process, Priority, % PID, Level

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
Return

;JustStarted:
;JustStarted = 0
;Return