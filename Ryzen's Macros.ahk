if not A_IsAdmin ; Runs the script as an admin.
   Run *RunAs "%A_ScriptFullPath%"
SetBatchLines, -1 ; Removes the built in 10ms sleep that happens after every line of code normally. It should never sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.
Menu, Tray, NoStandard ; Default trays but with some extra things above it, usually not possible so you need to do some complicated things to make it work.
ConfigDirectory = %A_MyDocuments%\Ryzen's Macros
IfNotExist, %ConfigDirectory%
   FileCreateDir, %ConfigDirectory%
IfNotExist, %ConfigDirectory%\assets
   FileCreateDir, %ConfigDirectory%\assets
clumsyEnabled = 0
TrayButtonInfo = 1
If InStr(A_ScriptName,.ahk) && not (A_ScriptName = "AutoHotkey.ahk")
   isCompiled = 0
else
   isCompiled = 1
; Debug:
If (isCompiled) {
   ListLines Off ; Removes line history, makes the script slightly more secret.
   #KeyHistory 0 ; Removes key history, makes the script slightly more secret.
   TrayButtonInfo = 0
}

; Variables:
MacroVersion = sort of trolled ; Macro version
RunningInScript = 1 ; Required for dynamic script to work properly
CFG = %A_MyDocuments%\Ryzen's Macros\GTA Binds.ini ; Config file name
CrosshairDone := 0 ; If crosshair has been applied
MCCEO2 := 0 ; If you are in MC
SendInputFallbackText = I have detected that it has taken a very long time to complete the chat message. First, check if the characters are being sent one by one, or in instant `"batches`". If it is being sent in batches, then your FPS is likely very low. Please complain to me on Discord and I will raise the threshold for this message. If it is being sent one by one, try this: If you are running Flawless Widescreen, you must close it, as it causes issues, and makes most macros far slower. Please open a support ticket on the Discord Server if the problem persists, or if Flawless Widescreen is not running.
WriteWasJustPerformed = 0 ; EWO Score Write was just performed
IniRead,DebugTesting,%CFG%,Debug,Debug Testing ; Checks if debug testing is true, usually false.
IniRead,clumsyPing,%CFG%,Debug,clumsy ping ; yes
IniRead,OriginalLocation, %ConfigDirectory%\FileLocationData.ini, Location, Location
IniRead,OriginalName, %ConfigDirectory%\FileLocationData.ini, Name, Name

; GTAHaX EWO Offsets:
FreemodeGlobalIndex = 262145
EWOGlobalOffset1 = 28409
; GTAHaX EWO Offsets 2:
EWOGlobalIndex = 2793044
EWOGlobalOffset0 = 6899
; GTAHaX EWO Score Offsets:
ScoreGlobalIndex = 2672505
ScoreGlobalOffset1 = 1684
ScoreGlobalOffset2 = 817
; CEO Circle Offsets:
CEOCircleGlobalIndex = 1894573
CEOCircleGlobalOffset1 = 5
CEOCircleGlobalOffset2 = 10
CEOCircleGlobalOffset3 = 11

; Add them together
FreemodeGlobalIndexAddedTogether := FreemodeGlobalIndex + EWOGlobalOffset1 ; Calculates the Global Index for EWO Cooldown
EWOGlobalIndexAddedTogether := EWOGlobalIndex + EWOGlobalOffset0 ; Calculates the Global Index for active EWO Cooldown
ScoreGlobalIndexAddedTogether := ScoreGlobalIndex + ScoreGlobalOffset1 + ScoreGlobalOffset2 ; Calculates the Global Index for EWO Score
CEOCircleGlobalIndexAddedTogether := CEOCircleGlobalIndex + CEOCircleGlobalOffset1 + CEOCircleGlobalOffset2 + CEOCircleGlobalOffset3 ; Calculates the Global Index for CEO Circle

Goto, CheckHWID ; Checks your PC's UUID. Shitty but it works
Back: ; It goes back to this checkpoint. It works.
   Gosub, CreateTrayOptions
   SetWorkingDir %A_MyDocuments%\Ryzen's Macros\
   If not WinExist("ahk_exe GTA5.exe") { ; Makes the macros not immediately close if you run it while GTA isn't open
      GTAAlreadyClosed = 1
   } else {
      GTAAlreadyClosed = 0
   }
   #SingleInstance, force ; Forces single instance
   #HotkeyModifierTimeout -1 ; Changes hotkey modifier timeout, maybe does something lmao
#IfWinActive ahk_exe GTA5.exe ; Hotkeys will only work if you are tabbed in.
   #MaxThreadsPerHotkey 1 ; Doesn't really matter
   #MaxThreads 99999 ; Sets the maximum amount of active threads to practically infinity.
   #MaxThreadsBuffer On ; Makes hotkeys buffer if you hold it down or something.
   #MaxHotkeysPerInterval 99000000 ; Doesn't matter but AHK may give you an error if you spam hotkeys really really fast otherwise.
   #HotkeyInterval 99000000 ; Same as the other hotkey interval setting
   #Persistent ; Makes the script never exit, probably unneccassary because other commands (like hotkey) already cause it to never exit.
   #UseHook On ; Idk
   #InstallKeybdHook ; Idk
   #InstallMouseHook ; Idk
   SetTitleMatchMode, 2 ; I forgor :dead_skull:
   SetDefaultMouseSpeed, 0 ; Something
   SetKeyDelay, -1, -1 ; Sets key delay to the lowest possible, there is still delay due to the keyboard hook in GTA, but this makes it excecute as fast as possible WITHOUT skipping keystrokes. Set this a lot higher if you uninstalled the keyboard hook using mods.
   SetWinDelay, -1 ; After any window modifying command, the script has a built in delay. Fuck delays.
   SetControlDelay, 0 ; After any control modifying command, for example; ControlSend, there is a built in delay. Set to 0 instead of -1 because having a slight delay may improve reliability, and is unnoticable anyways.
   Gui,Font,q5,Segoe UI Semibold ; Sets font to something
   IniRead,Read_AlwaysOnTop,%CFG%,Misc,Always On Top ; Secret module
   If (Read_AlwaysOnTop = 1) {
      WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
      WinMinimize, ahk_exe GTA5.exe
      SetTimer, AlwaysOnTop, 25, -2147483648
   }
   If (IsCompiled)
      SendInputTestV2() ; Check to see if SendInput works or not
   MsgBox, 0, Ryzen's Macros %MacroVersion%, Successfully started. Welcome to Ryzen's Macros! , 0.75
   Gui, Add, Tab3,, Combat|Chat|In-Game Binds|Options|Misc|Buttons/Misc|| ; Adds tabs to the GUI
   Gosub, CombatMacros ; Combat Macros
   Gosub, ChatMacros ; Chat Macros
   Gosub, InGameBinds ; In-Game Binds
   Gosub, MacroOptions ; Options for the macros
   Gosub, MiscMacros ; Custom Macros and a few Misc Macros.
   Gosub, SavingAndButtonsAndMiscMacros ; Buttons and some more settings and shit
   
   Gosub, Read ; Reads your config file
   GuiControl,,CEOMode,1 ; Sets CEO Mode to 1 whenever you start the script
   If (DebugTesting = 1)
      GuiControl,,PassiveDisableSpam,0 ; Sets CEO Mode to 1 whenever you start the script
   DetectHiddenWindows, On ; It does something
   Gui0 := WinExist(A_ScriptFullpath "ahk_pid" DllCall("GetCurrentProcessId")) ; Somehow linked to tray items
   DetectHiddenWindows, Off ; It does something
   Gui, Show,, Ryzen's Macros Version %MacroVersion%
   
   ;MsgBox, 0, Welcome!, HWID Matching! Welcome to Ryzen's Macros. Add me on Discord (cryleak#3961) if you have any issues. Good luck.
   Gosub, StandardTrayMenu
Return

Reload: ; Reloads the macros
GuiControlGet, AlwaysOnTop
If (AlwaysOnTop = 1)
{
   WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
   WinMinimize, ahk_exe GTA5.exe
}
If (!isCompiled)
{
   MsgBox, 0, Ryzen's Macros %MacroVersion%,If you see this`, something strange is happening. , 0.75
   Reload
}
Else
{
   Process, Close, %Gay%
   Process, Close, %Gay2%
   Process, Close, %Gay3%
   Process, Close, %Obese11%
   Run, Reload.exe, %A_MyDocuments%
   ExitApp
}
return

Spotify: ; Another secret module
   Loop, 10 {
      Process, Close, Spotify.exe
   }
Return

Flawless: ; Flawless Widescreen fix
   MsgBox, 0, Info, This fixes slow chat macros and slower overall macros when Flawless Widescreen is running.
   MsgBox, 0, IMPORTANT!, Make sure you have applied the settings you want to use already inside Flawless Widescreen!
   Process, Close, FlawlessWidescreen.exe
   MsgBox, 0, Fix applied, Fix applied`, please DM me if it doesn't work.
Return

ExitMacros: ; Self explanatory
   GuiControlGet, AlwaysOnTop
   If (AlwaysOnTop = 1)
   {
      WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
      WinMinimize, ahk_exe GTA5.exe
   }
   Process, Close, %Gay%
   Process, Close, %Gay2%
   Process, Close, %Gay3%
   Process, Close, %Obese11%
ExitApp
return

HideWindow: ; Hides the GUI
   Gui, Hide
return

ThermalHelmet: ; Self explanatory
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

FastSniperSwitch: ; Self explanatory
   SendInput {Blind}{%FastSniperSwitch% up}
   If (FasterSniper = 1)
      Send {Blind}{%SniperBind%}{lbutton}{%SniperBind%}{lbutton}
   else
   {
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

EWO: ; Self explanatory
   GuiControlGet, SmoothEWO
   GuiControlGet, SmoothEWOMode
   GuiControlGet, EWOWrite
   If (SmoothEWOMode = "Fast Respawn")
   {
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
   }
   else if (SmoothEWOMode = "Sticky")
   {
      SendInput {lbutton down}{rbutton up}
      Send {Blind}{%RifleBind%}
      SendInput {lbutton up}
      Send {Blind}{tab} ; {lbutton 5}
      Loop, 15 {
         if WinActive("ahk_exe GTA5.exe") {
            Send {Blind}{g 4} ; {lbutton}
         }
      }
      SendInput {Blind}{lbutton up}
   } else {
      SetMouseDelay, -1
      if (SmoothEWO = 1)
      {
         If (SmoothEWOMode = "Slow")
         {
            If (getKeyState("rbutton", "P"))
            {
               SendInput {Blind}{lbutton up}{rbutton up}
               Sleep(125)
            }
         }
         If (SmoothEWOMode = "Faster")
         {
            SendInput {Blind}{%EWOLookBehindKey% down}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{%InteractionMenuKey% down}{d up}{w up}{s up}{a up}
            Sleep(13)
            Send {Blind}{shift down}{f24 up}{shift up}{up}
            Sleep(12)
            Send {Blind}{up}
            Sleep(9)
            Send {Blind}{%EWOSpecialAbilitySlashActionKey% down}{enter up}
         }
         else if (SmoothEWOMode = "Slow")
         {
            StringUpper, EWOLookBehindKey, EWOLookBehindKey
            /*
            SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{d up}{w up}{s up}{a up}{%InteractionMenuKey% down}
            Sleep(20)
            Send {Blind}{%EWOLookBehindKey% down}{up}
            Sleep(25)
            SendInput {Blind}{WheelUp}
            Sleep(46)
            SendInput {Blind}{%EWOSpecialAbilitySlashActionKey% down}
            Send {Blind}{enter up}{%InteractionMenuKey% up}
            */
            SendInput {Blind}{alt up}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{d up}{w up}{s up}{a up}{%InteractionMenuKey% down}{%EWOLookBehindKey% up}
            Sleep(18)
            Send {Blind}{%EWOLookBehindKey% down}{up}
            SendInput {Blind}{%EWOSpecialAbilitySlashActionKey%}
            Sleep(24)
            SendInput {Blind}{WheelUp}
            Sleep(55)
            SendInput {Blind}{enter up}{%InteractionMenuKey% up}{%EWOLookBehindKey% up}
            StringLower, EWOLookBehindKey, EWOLookBehindKey
         }
         else if (SmoothEWOMode = "Fastest")
         {
            SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}
            Send {Blind}{%InteractionMenuKey%}{up 2}
            SendInput {%EWOSpecialAbilitySlashActionKey% down}
            Send {Blind}{enter}
         }
         else if (SmoothEWOMode = "Retarded")
         {
            StringUpper, EWOLookBehindKey, EWOLookBehindKey
            Random, Var, 1, 3
            SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}{%EWOMelee% down}
            Sleep(30)
            Send {Blind}{up}
            Sleep(20)
            Send {Blind}{up}
            Sleep(40)
            Send {Blind}{%EWOLookBehindKey% down}
            if (var) ; why the fuck did i do this
               Sleep(10)
            else if (var = 2)
               Sleep(5)
            else
               Sleep(15)
            Send {Blind}{enter up}
            StringLower, EWOLookBehindKey, EWOLookBehindKey
         }
         else if (SmoothEWOMode = "Retarded2")
         {
            
            SendInput {Blind}{lbutton up}{enter down}
            Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
            SendInput {Blind}{enter down}
            Send {Blind}{up up}
            SendInput {Blind}{enter up}
            GUIControl,, CEOMode, 0
            Sleep(110)
            
            SendInput {Blind}{%EWOLookBehindKey% down}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{%InteractionMenuKey% down}{d up}{w up}{s up}{a up}
            Sleep(13)
            Send {Blind}{shift down}{f24 up}{shift up}{up}
            Sleep(12)
            Send {Blind}{up}
            Sleep(9)
            Send {Blind}{%EWOSpecialAbilitySlashActionKey% down}{enter up}
            /*
            sleep 30
            SendInput {Blind}{%EWOLookBehindKey% down}
            sleep 95
            SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
            Send {Blind}{f24 down}{f23 down}{f22 down}
            SendInput {Blind}{wheelup}{enter up}{up up}
            */
         }
      }
      else if (SmoothEWO = 0)
      {
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

Write: ; Shows the score even if you have EWOd in the session via some advanced shit
   If (GTAAlreadyClosed = 0) {
      if not WinExist("ahk_exe GTAHaXUI.exe") { ; If window doesn't exist, make it exist and add shit to it
         Run, GTAHaXUI.exe, %ConfigDirectory%,Min,Gay2
         WinWait, ahk_pid %Gay2%
         WinGet, ID2, ID, ahk_pid %Gay2%
         WinSet, ExStyle, ^0x80, ahk_id %ID2% ; 0x80 is WS_EX_TOOLWINDOW
         ControlSend, Edit1, {down}{backspace}%ScoreGlobalIndexAddedTogether%, ahk_pid %Gay2%
         sleep 20
      } else { ; If it does exist
         ControlGet, Cocaine,Line,1,Edit1,ahk_pid %Gay2% ; Get the value of controls and shiznit
         ControlGet, Heroin,Line,1,Edit7,ahk_pid %Gay2%
         ControlGet, AIDS,Line,1,Edit8,ahk_pid %Gay2%
         If (Heroin = 1) && (Cocaine = ScoreGlobalIndexAddedTogether) && (AIDS = 0) { ; If the values are correct do this shit
            ControlClick, Button1, ahk_pid %Gay2%
            WriteWasJustPerformed = 1
            SetTimer, WriteWasPerformed, -350, -2147483648
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
Return

WriteWasPerformed: ; Submodule of the Write module
   WriteWasJustPerformed = 0
Return

TabBackInnn: ; Submodule of the submodule of the Write module
   If (WriteWasJustPerformed = 1)
      WinActivate, ahk_exe GTA5.exe
Return

EWOWrite: ; Checks if EWO Write is enabled
   GuiControlGet, EWOWrite
   If (EWOWrite = 1) {
      SetTimer, Write, 10, -2147483648
      SetTimer, TabBackInnn, 10, -2147483648
   }
   else {
      SetTimer, Write, Off, -2147483648
      SetTimer, TabBackInnn, Off, -2147483648
   }
Return

KekEWO: ; Opens the options menu to EWO, works even if you are stunned or ragdolled
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

BST: ; Self explanatory
   SendInput {Blind}{lbutton up}{enter down}
   GuiControlGet, CEOMode
   GuiControlGet, BSTSpeed
   GuiControlGet, BSTMC
   If (CEOMode = 0)
      MsgBox, 0, Warning!, You are not in a CEO! , 0.75
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

Ammo: ; Self explanatory
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
   Send {Blind}{enter up}{down 4}
   SendInput {Blind}{enter down}
   Send {Blind}{down 2}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}{up down}
   SendInput {Blind}{enter down}
   Send {Blind}{up up}
   SendInput {Blind}{enter up}{%InteractionMenuKey% down}
   Sleep 25
   SendInput {Blind}{%InteractionMenuKey% up}
   sleep 100
return

FastRespawn: ; Self explanatory
   Send {Blind}{lbutton 30}
return

ProBlocking: ; I don't think I need this anymore
Return

GTAHax: ; Self explanatory
   Run, GTAHaXUI.exe, %ConfigDirectory%,,Gay
   WinWait, ahk_pid %Gay%
   ControlSend, Edit1, {down}{backspace}%FreemodeGlobalIndexAddedTogether%, ahk_pid %Gay%
   sleep 100
   ControlClick, Button1, ahk_pid %Gay%
   sleep 100
   ControlSend, Edit2, {down}{backspace}1, ahk_pid %Gay%
   sleep 100
   ControlClick, Button1, ahk_pid %Gay%
   sleep 100
   ControlSend, Edit1, {down}{backspace 7}%EWOGlobalIndexAddedTogether%, ahk_pid %Gay%
   ControlSend, Edit2, {down}{backspace 2}0, ahk_pid %Gay%
   sleep 100
   ControlClick, Button1, ahk_pid %Gay%
   MsgBox, 0, Complete!, You should now have no EWO cooldown. Kill yourself with a Sticky/RPG if you currently have a cooldown.
   Process, Close, %Gay%
return

GTAHaxCEO: ; GTAHaX CEO Circle
   Run, GTAHaXUI.exe, %ConfigDirectory%,,Gay
   WinWait, ahk_pid %Gay%
   ControlSend, Edit1, {down}{backspace}%CEOCircleGlobalIndexAddedTogether%, ahk_pid %Gay%
   sleep 30
   ControlClick, Button1, ahk_pid %Gay%
   sleep 30
   ;msgbox 0
   Loop, 32 { ; Recreates the function that determines what memory address this global should be in, and tests every possible combination of that.
      PlayerID := a_index
      PlayerID1 := PlayerID * 608
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

HelpWhatsThis: ; Self explanatory
   while GetKeyState(HelpWhatsThis,"P") {
      PrepareChatMacro()
      SendInput don't care {numpadadd} didn't ask {numpadadd} cry{space}
      Send {Blind}{f24 up}
      SendInput about it {numpadadd} stay mad {numpadadd} get real
      Send {Blind}{f24 up}
      SendInput {space}{numpadadd} L {numpadadd} mald {numpadadd} seethe {numpadadd} cope ha
      Send {Blind}{f24 up}
      SendInput rder {numpadadd} hoes mad {numpadadd} basic {numpadadd} skil
      Send {Blind}{f24 up}
      SendInput l issue {numpadadd} ratio
      
      Send {Blind}{enter up}
      PrepareChatMacro()
      
      SendInput {numpadadd} you fell off {numpadadd} the audacity{space}
      Send {Blind}{f24 up}
      SendInput {numpadadd} triggered {numpadadd} any askers {numpadadd} red
      Send {Blind}{f24 up}
      SendInput pilled {numpadadd} get a life {numpadadd} ok and?{space}
      Send {Blind}{f24 up}
      SendInput {numpadadd} cringe {numpadadd} touch grass {numpadadd} donow
      Send {Blind}{f24 up}
      SendInput alled {numpadadd} not based
      
      Send {Blind}{enter up}
      PrepareChatMacro()
      
      SendInput {numpadadd} you're a (insert stereotype)
      Send {Blind}{f24 up}
      SendInput {space}{numpadadd} not funny didn't laugh {numpadadd} yo
      Send {Blind}{f24 up}
      SendInput u're* {numpadadd} grammar issue {numpadadd} go out
      Send {Blind}{f24 up}
      SendInput side {numpadadd} get good {numpadadd} reported {numpadadd} a
      Send {Blind}{f24 up}
      SendInput d hominem {numpadadd} GG{shift down}1{shift up}
      
      Send {Blind}{enter up}
      PrepareChatMacro()
      
      SendInput {z 30}
      
      Send {Blind}{enter up}
   }
return

EssayAboutGTA: ; Self explanatory
   while GetKeyState(EssayAboutGTA,"P") {
      PrepareChatMacro()
      
      SendInput why is my fps so shlt this gam
      Send {Blind}{f24 up}
      SendInput e has terrible optimization it
      Send {Blind}{f24 up}
      SendInput s chinese as shlt man i hate t
      Send {Blind}{f24 up}
      SendInput his game im gonna swat the r*{space}
      Send {Blind}{f24 up}
      SendInput headquarters man i
      
      Send {Blind}{enter up}
      PrepareChatMacro()
      
      SendInput swear to god this game is so b
      Send {Blind}{f24 up}
      SendInput ad why do we all still play it
      Send {Blind}{f24 up}
      SendInput {space}idk but how can they not affo
      Send {Blind}{f24 up}
      SendInput rd some dedicated servers they
      Send {Blind}{f24 up}
      SendInput {space}are a multi billion
      
      Send {Blind}{enter up}
      PrepareChatMacro()
      
      SendInput dollar company also why does i
      Send {Blind}{f24 up}
      SendInput t still use p2p technology for
      Send {Blind}{f24 up}
      SendInput {space}servers thats been out of dat
      Send {Blind}{f24 up}
      SendInput e since gta 4 man it honestly{space}
      Send {Blind}{f24 up}
      SendInput baffles me how
      
      Send {Blind}{enter up}
      PrepareChatMacro()
      
      SendInput outdated gta online is and how
      Send {Blind}{f24 up}
      SendInput {space}bad the fps is its so cpu bou
      Send {Blind}{f24 up}
      SendInput nd its stupid also thanks for{space}
      Send {Blind}{f24 up}
      SendInput listening to my essay about ho
      Send {Blind}{f24 up}
      SendInput w bad gta online is
      
      Send {Blind}{enter up}
   }
return

CustomTextSpam: ; Self explanatory
   while GetKeyState(CustomTextSpam,"P") {
      GuiControlGet, RawText
      Length := StrLen(CustomSpamText)
      PrepareChatMacro()
      if (Length >= 31) {
         Loop, 140 {
            ArrayYes%A_Index% =
         }
         StringSplit, ArrayYes, CustomSpamText
         If (RawText = 1) {
            SendInput {Raw}%ArrayYes1%%ArrayYes2%%ArrayYes3%%ArrayYes4%%ArrayYes5%%ArrayYes6%%ArrayYes7%%ArrayYes8%%ArrayYes9%%ArrayYes10%%ArrayYes11%%ArrayYes12%%ArrayYes13%%ArrayYes14%%ArrayYes15%%ArrayYes16%%ArrayYes17%%ArrayYes18%%ArrayYes19%%ArrayYes20%%ArrayYes21%%ArrayYes22%%ArrayYes23%%ArrayYes24%%ArrayYes25%%ArrayYes26%%ArrayYes27%%ArrayYes28%%ArrayYes29%
            Send {Blind}{f24 up}
            SendInput {Raw}%ArrayYes30%%ArrayYes31%%ArrayYes32%%ArrayYes33%%ArrayYes34%%ArrayYes35%%ArrayYes36%%ArrayYes37%%ArrayYes38%%ArrayYes39%%ArrayYes40%%ArrayYes41%%ArrayYes42%%ArrayYes43%%ArrayYes44%%ArrayYes45%%ArrayYes46%%ArrayYes47%%ArrayYes48%%ArrayYes49%%ArrayYes50%%ArrayYes51%%ArrayYes52%%ArrayYes53%%ArrayYes54%%ArrayYes55%%ArrayYes56%%ArrayYes57%%ArrayYes58%%ArrayYes59%
            Send {Blind}{f24 up}
            SendInput {Raw}%ArrayYes60%%ArrayYes61%%ArrayYes62%%ArrayYes63%%ArrayYes64%%ArrayYes65%%ArrayYes66%%ArrayYes67%%ArrayYes68%%ArrayYes69%%ArrayYes70%%ArrayYes71%%ArrayYes72%%ArrayYes73%%ArrayYes74%%ArrayYes75%%ArrayYes76%%ArrayYes77%%ArrayYes78%%ArrayYes79%%ArrayYes80%%ArrayYes81%%ArrayYes82%%ArrayYes83%%ArrayYes84%%ArrayYes85%%ArrayYes86%%ArrayYes87%%ArrayYes88%%ArrayYes89%
            Send {Blind}{f24 up}
            SendInput {Raw}%ArrayYes90%%ArrayYes91%%ArrayYes92%%ArrayYes93%%ArrayYes94%%ArrayYes95%%ArrayYes96%%ArrayYes97%%ArrayYes98%%ArrayYes99%%ArrayYes100%%ArrayYes101%%ArrayYes102%%ArrayYes103%%ArrayYes104%%ArrayYes105%%ArrayYes106%%ArrayYes107%%ArrayYes108%%ArrayYes109%%ArrayYes110%%ArrayYes111%%ArrayYes112%%ArrayYes113%%ArrayYes114%%ArrayYes115%%ArrayYes116%%ArrayYes117%%ArrayYes118%%ArrayYes119%
            Send {Blind}{f24 up}
            SendInput {Raw}%ArrayYes120%%ArrayYes121%%ArrayYes122%%ArrayYes123%%ArrayYes124%%ArrayYes125%%ArrayYes126%%ArrayYes127%%ArrayYes128%%ArrayYes129%%ArrayYes130%%ArrayYes131%%ArrayYes132%%ArrayYes133%%ArrayYes134%%ArrayYes135%%ArrayYes136%%ArrayYes137%%ArrayYes138%%ArrayYes139%%ArrayYes140%
            Send {Blind}{enter up}
         } else {
            SendInput %ArrayYes1%%ArrayYes2%%ArrayYes3%%ArrayYes4%%ArrayYes5%%ArrayYes6%%ArrayYes7%%ArrayYes8%%ArrayYes9%%ArrayYes10%%ArrayYes11%%ArrayYes12%%ArrayYes13%%ArrayYes14%%ArrayYes15%%ArrayYes16%%ArrayYes17%%ArrayYes18%%ArrayYes19%%ArrayYes20%%ArrayYes21%%ArrayYes22%%ArrayYes23%%ArrayYes24%%ArrayYes25%%ArrayYes26%%ArrayYes27%%ArrayYes28%%ArrayYes29%
            Send {Blind}{f24 up}
            SendInput %ArrayYes30%%ArrayYes31%%ArrayYes32%%ArrayYes33%%ArrayYes34%%ArrayYes35%%ArrayYes36%%ArrayYes37%%ArrayYes38%%ArrayYes39%%ArrayYes40%%ArrayYes41%%ArrayYes42%%ArrayYes43%%ArrayYes44%%ArrayYes45%%ArrayYes46%%ArrayYes47%%ArrayYes48%%ArrayYes49%%ArrayYes50%%ArrayYes51%%ArrayYes52%%ArrayYes53%%ArrayYes54%%ArrayYes55%%ArrayYes56%%ArrayYes57%%ArrayYes58%%ArrayYes59%
            Send {Blind}{f24 up}
            SendInput %ArrayYes60%%ArrayYes61%%ArrayYes62%%ArrayYes63%%ArrayYes64%%ArrayYes65%%ArrayYes66%%ArrayYes67%%ArrayYes68%%ArrayYes69%%ArrayYes70%%ArrayYes71%%ArrayYes72%%ArrayYes73%%ArrayYes74%%ArrayYes75%%ArrayYes76%%ArrayYes77%%ArrayYes78%%ArrayYes79%%ArrayYes80%%ArrayYes81%%ArrayYes82%%ArrayYes83%%ArrayYes84%%ArrayYes85%%ArrayYes86%%ArrayYes87%%ArrayYes88%%ArrayYes89%
            Send {Blind}{f24 up}
            SendInput %ArrayYes90%%ArrayYes91%%ArrayYes92%%ArrayYes93%%ArrayYes94%%ArrayYes95%%ArrayYes96%%ArrayYes97%%ArrayYes98%%ArrayYes99%%ArrayYes100%%ArrayYes101%%ArrayYes102%%ArrayYes103%%ArrayYes104%%ArrayYes105%%ArrayYes106%%ArrayYes107%%ArrayYes108%%ArrayYes109%%ArrayYes110%%ArrayYes111%%ArrayYes112%%ArrayYes113%%ArrayYes114%%ArrayYes115%%ArrayYes116%%ArrayYes117%%ArrayYes118%%ArrayYes119%
            Send {Blind}{f24 up}
            SendInput %ArrayYes120%%ArrayYes121%%ArrayYes122%%ArrayYes123%%ArrayYes124%%ArrayYes125%%ArrayYes126%%ArrayYes127%%ArrayYes128%%ArrayYes129%%ArrayYes130%%ArrayYes131%%ArrayYes132%%ArrayYes133%%ArrayYes134%%ArrayYes135%%ArrayYes136%%ArrayYes137%%ArrayYes138%%ArrayYes139%%ArrayYes140%
            Send {Blind}{enter up}
         }
      }
      else if Length <= 30
      {
         If (RawText = 1) {
            SendInput {Raw}%CustomSpamText%
            Send {Blind}{enter up}
         } else {
            SendInput %CustomSpamText%
            Send {Blind}{enter up}
         }
      }
   }
return

Paste: ; Self explanatory
   Send {Blind}v
   SendInput {backspace}
   Send {Blind}{f24 up}
   Length2 = StrLen(Clipboard)
   if (Length2 >= 31) {
      Loop, 140 {
         ArrayYesPaste%A_Index% =
      }
      StringSplit, ArrayYesPaste, Clipboard
      SendInput {Raw}%ArrayYesPaste1%%ArrayYesPaste2%%ArrayYesPaste3%%ArrayYesPaste4%%ArrayYesPaste5%%ArrayYesPaste6%%ArrayYesPaste7%%ArrayYesPaste8%%ArrayYesPaste9%%ArrayYesPaste10%%ArrayYesPaste11%%ArrayYesPaste12%%ArrayYesPaste13%%ArrayYesPaste14%%ArrayYesPaste15%%ArrayYesPaste16%%ArrayYesPaste17%%ArrayYesPaste18%%ArrayYesPaste19%%ArrayYesPaste20%%ArrayYesPaste21%%ArrayYesPaste22%%ArrayYesPaste23%%ArrayYesPaste24%%ArrayYesPaste25%%ArrayYesPaste26%%ArrayYesPaste27%%ArrayYesPaste28%%ArrayYesPaste29%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYesPaste30%%ArrayYesPaste31%%ArrayYesPaste32%%ArrayYesPaste33%%ArrayYesPaste34%%ArrayYesPaste35%%ArrayYesPaste36%%ArrayYesPaste37%%ArrayYesPaste38%%ArrayYesPaste39%%ArrayYesPaste40%%ArrayYesPaste41%%ArrayYesPaste42%%ArrayYesPaste43%%ArrayYesPaste44%%ArrayYesPaste45%%ArrayYesPaste46%%ArrayYesPaste47%%ArrayYesPaste48%%ArrayYesPaste49%%ArrayYesPaste50%%ArrayYesPaste51%%ArrayYesPaste52%%ArrayYesPaste53%%ArrayYesPaste54%%ArrayYesPaste55%%ArrayYesPaste56%%ArrayYesPaste57%%ArrayYesPaste58%%ArrayYesPaste59%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYesPaste60%%ArrayYesPaste61%%ArrayYesPaste62%%ArrayYesPaste63%%ArrayYesPaste64%%ArrayYesPaste65%%ArrayYesPaste66%%ArrayYesPaste67%%ArrayYesPaste68%%ArrayYesPaste69%%ArrayYesPaste70%%ArrayYesPaste71%%ArrayYesPaste72%%ArrayYesPaste73%%ArrayYesPaste74%%ArrayYesPaste75%%ArrayYesPaste76%%ArrayYesPaste77%%ArrayYesPaste78%%ArrayYesPaste79%%ArrayYesPaste80%%ArrayYesPaste81%%ArrayYesPaste82%%ArrayYesPaste83%%ArrayYesPaste84%%ArrayYesPaste85%%ArrayYesPaste86%%ArrayYesPaste87%%ArrayYesPaste88%%ArrayYesPaste89%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYesPaste90%%ArrayYesPaste91%%ArrayYesPaste92%%ArrayYesPaste93%%ArrayYesPaste94%%ArrayYesPaste95%%ArrayYesPaste96%%ArrayYesPaste97%%ArrayYesPaste98%%ArrayYesPaste99%%ArrayYesPaste100%%ArrayYesPaste101%%ArrayYesPaste102%%ArrayYesPaste103%%ArrayYesPaste104%%ArrayYesPaste105%%ArrayYesPaste106%%ArrayYesPaste107%%ArrayYesPaste108%%ArrayYesPaste109%%ArrayYesPaste110%%ArrayYesPaste111%%ArrayYesPaste112%%ArrayYesPaste113%%ArrayYesPaste114%%ArrayYesPaste115%%ArrayYesPaste116%%ArrayYesPaste117%%ArrayYesPaste118%%ArrayYesPaste119%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYesPaste120%%ArrayYesPaste121%%ArrayYesPaste122%%ArrayYesPaste123%%ArrayYesPaste124%%ArrayYesPaste125%%ArrayYesPaste126%%ArrayYesPaste127%%ArrayYesPaste128%%ArrayYesPaste129%%ArrayYesPaste130%%ArrayYesPaste131%%ArrayYesPaste132%%ArrayYesPaste133%%ArrayYesPaste134%%ArrayYesPaste135%%ArrayYesPaste136%%ArrayYesPaste137%%ArrayYesPaste138%%ArrayYesPaste139%%ArrayYesPaste140%
   }
   else {
      SendInput {Raw}%Clipboard%
   }
return

ShutUp: ; Self explanatory
   while GetKeyState(ShutUp,"P") {
      PrepareChatMacro()
      SendInput {Blind}shut up
      Send {Blind}{enter up}
   }
return

Paste2: ; Checks if Paste is enabled
   GuiControlGet, Paste
   If (Paste = 0) {
      Hotkey, ^v, Paste, Off
   }
   else {
      Hotkey, ^v, Paste, On
   }
return

ReloadOutfit: ; Self explanatory
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

Crosshair5: ; Self explanatory
   WinGetActiveTitle, OldActiveWindow
   GuiControlGet, CrosshairPos
   If not (CrossHairPos = "") {
      CrosshairPosPro := CrosshairPos/500
      GuiControlGet, Crosshair
      if(crossHair = 1) {
         Global crossHairW := 21
         Global crossHairH := 21
         
         Global backgroundColor := 0xff00cc
         
         SysGet, screenW, 78
         SysGet, screenH, 79
         
         Global crossHairX := (screenW / CrosshairPosPro) - (crossHairH / 2)
         Global crossHairY := (screenH / 2) - (crossHairH / 2)
         WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
         IfNotExist, %A_WorkingDir%\assets
            FileCreateDir, %A_WorkingDir%\assets
         
         Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
         Gui, Color, backgroundColor
         Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%, %A_WorkingDir%\assets\crosshair.png
         Try {
            Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
         } Catch {
            Gui, Crosshair: Hide
         }
         WinSet, TransColor, backgroundColor, Crosshair
         WinGet, ID, ID, Crosshair
         WinSet, ExStyle, ^0x80, ahk_id %ID% ; 0x80 is WS_EX_TOOLWINDOW
      } else {
         Gui, Crosshair: Hide
      }
   }
   else {
      Gui, Crosshair: Hide
   }
   WinActivate, %OldActiveWindow%
return

Crosshair6: ; Self explanatory
   WinGetActiveTitle, OldActiveWindow
   GuiControlGet, CrosshairPos
   If not (CrossHairPos = "") {
      CrosshairPosPro := CrosshairPos/500
      GuiControlGet, Crosshair
      if(crossHair = 1) {
         Global crossHairW := 21
         Global crossHairH := 21
         
         Global backgroundColor := 0xff00cc
         
         SysGet, screenW, 78
         SysGet, screenH, 79
         
         Global crossHairX := (screenW / CrosshairPosPro) - (crossHairH / 2)
         Global crossHairY := (screenH / 2) - (crossHairH / 2)
         WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
         IfNotExist, %A_WorkingDir%\assets
            FileCreateDir, %A_WorkingDir%\assets
         
         Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
         Gui, Color, backgroundColor
         Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%, %A_WorkingDir%\assets\crosshair.png
         Try {
            Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
         } Catch {
            Gui, Crosshair: Hide
         }
         WinSet, TransColor, backgroundColor, Crosshair
         WinGet, ID, ID, Crosshair
         WinSet, ExStyle, ^0x80, ahk_id %ID% ; 0x80 is WS_EX_TOOLWINDOW
      } else {
         Gui, Crosshair: Hide
      }
      WinActivate, ahk_exe GTA5.exe
   } else {
      Gui, Crosshair: Hide
   }
   WinActivate, %OldActiveWindow%
return

ProcessCheck3: ; Self explanatory
   GuiControlGet, ProcessCheck2
   if (ProcessCheck2 = 0) {
      SetTimer, ProcessCheckTimer, Off, -2147483648
   } else {
      SetTimer, ProcessCheckTimer, 100, -2147483648
   }
return

TabWeapon2: ; If Fast Switch is enabled
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
   GuiControlGet, AlwaysOnTop
   If (AlwaysOnTop = 1) {
      WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
      WinMinimize, ahk_exe GTA5.exe
   }
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
   sleep 125
return

ProcessCheckTimer:
   If (GTAAlreadyClosed = 0) {
      GuiControlGet, ProcessCheck2
      If not (ProcessCheck2 = 0) {
         If not WinExist("ahk_exe GTA5.exe") {
            Gosub, CloseGTAProcesses
            SetTimer, Write, Off, -2147483648
            SetTimer, CloseGTAHaX, 100, -2147483648
            SetTimer, ExitMacros, -10000, -2147483648
            MsgBox, 0, Macros will close now. RIP., GTA is no longer running. Macros will close now. RIP.
            Process, Close, %Gay%
            Process, Close, %Gay2%
            Process, Close, %Gay3%
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
   Send {Blind}{%RPGBind% down}{tab}
   SendInput {Blind}{%RPGBind% up}{%StickyBind% up}
return

ToggleCrosshair:
   GuiControlGet, Crosshair
   If (Crosshair = 1) {
      GuiControl,, Crosshair, 0
   }
   else {
      GuiControl,, Crosshair, 1
   }
   Goto, Crosshair6

Jobs:
   SendInput {Blind}{lbutton up}{enter down}
   Send {Blind}{%InteractionMenuKey%}{up 8}
   SendInput {Blind}{enter up}
   Send {Blind}{down down}
   SendInput {Blind}{enter down}
   Send {Blind}{down up}{down}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}{%InteractionMenuKey%}
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
         CrosshairPosPro := CrosshairPos/500
         GuiControlGet, Crosshair
         if(crossHair = 1) {
            Global crossHairW := 21
            Global crossHairH := 21
            
            Global backgroundColor := 0xff00cc
            
            SysGet, screenW, 78
            SysGet, screenH, 79
            
            Global crossHairX := (screenW / CrosshairPosPro) - (crossHairH / 2)
            Global crossHairY := (screenH / 2) - (crossHairH / 2)
            WinMove, Crosshair,, %CrossHairX%, %CRossHairY%
            IfNotExist, %A_WorkingDir%\assets
               FileCreateDir, %A_WorkingDir%\assets
            
            Gui, Crosshair: New, +AlwaysOnTop -Border -Caption
            Gui, Color, backgroundColor
            Gui, Add, Picture, x0 y0 w%crossHairW% h%crossHairH%, %A_WorkingDir%\assets\crosshair.png
            Try {
               Gui, Show, w%crossHairW% h%crossHairH% x%crossHairX% y%crossHairY%, Crosshair
            } Catch {
               Gui, Crosshair: Hide
            }
            WinSet, TransColor, backgroundColor, Crosshair
            WinGet, ID, ID, Crosshair
            WinSet, ExStyle, ^0x80, ahk_id %ID% ; 0x80 is WS_EX_TOOLWINDOW
         } else {
            Gui, Crosshair: Hide
         }
      }
   } else {
      Gui, Crosshair: Hide
   }
   CrosshairDone := 1
   WinActivate, %OldActiveWindow%
   GuiControlGet, AlwaysOnTop
   if (AlwaysOnTop = 0) {
      SetTimer, AlwaysOnTop, Delete, -2147483648
   } else {
      SetTimer, AlwaysOnTop, 100, -2147483648
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
   Hotkey, *%RPGSpam%, RPGSpam, UseErrorLevel Off
   Hotkey, *%PassiveDisableSpamToggle%, PassiveDisableSpamToggle, UseErrorLevel Off
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
   Gui, Add, Link,, Crosshair position: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Crosshair-position">(?)</a>
   Gui, Add, Link,, Night Vision Thermal <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Night-Vision-Thermal">(?)</a>
   Gui, Add, Link,, Slower EWO? <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a>
   Gui, Add, Link,, Slower EWO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a>
   Gui, Add, Link,, CEO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/CEO-Mode">(?)</a>
   Gui, Add, Link,, Optimize Fast Respawn EWO for: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Optimize-Fast-Respawn-EWO-For">(?)</a>
   Gui, Add, Link,, Show EWO Score: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score">(?)</a>
   Gui, Add, Link,, Sing: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score">(?)</a>
   If (DebugTesting = 1) {
      Gui, Add, Link,, Passive Disable Spam: <a href="">(?)</a>
      Gui, Add, Link,, Always On Top: <a href="">(?)</a>
   }
   
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
   Gui, Add, Checkbox, gEWOWrite vEWOWrite h20
   Gui, Add, Checkbox, gToggleSing vsingEnabled h20
   If (DebugTesting = 1) {
      Gui, Add, Checkbox, gPassiveDisableSpamCheck vPassiveDisableSpam h20
      Gui, Add, Checkbox, gAlwaysOnTopCheck vAlwaysOnTop h32
   }
Return

MiscMacros:
   Gui, Tab, 5
   Gui, Add, Link,x+5 y60, Kek EWO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Kek-EWO">(?)</a>
   Gui, Add, Link,, Show UI: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-UI">(?)</a>
   Gui, Add, Link,, Toggle CEO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-CEO">(?)</a>
   Gui, Add, Link,, Reload Outfit: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Reload-Outfit">(?)</a>
   Gui, Add, Link,, Toggle Jobs: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-Jobs">(?)</a>
   Gui, Add, Link,, Copy Paste: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Copy-Paste">(?)</a>
   Gui, Add, Link,, MCCEO toggle: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/MCCEO-Toggle">(?)</a>
   If (DebugTesting = 1)
      Gui, Add, Link,, Passive Disable Spam Toggle: <a href="">(?)</a>
   
   Gui, Add, Hotkey, vKekEWO x+105 y60
   Gui, Add, Hotkey,vShowUI,
   Gui, Add, Hotkey,vToggleCEO,
   Gui, Add, Hotkey,vReloadOutfit,
   Gui, Add, Hotkey, vJobs
   Gui, Add, Checkbox, gPaste2 vPaste h20
   Gui, Add, Hotkey, vMCCEO
   If (DebugTesting = 1)
      Gui, Add, Hotkey, vPassiveDisableSpamToggle
Return

SavingAndButtonsAndMiscMacros:
   Gui, Tab, 6
   Gui, Add, Button, gSaveConfig h20 x+5 y60,Save Config/Start Macros
   Gui, Add, Button, gApply h20,Start Macros No Save
   Gui, Add, Button, gHideWindow h20,Hide GUI
   Gui, Add, Button, gExitMacros h20,Exit Macros
   Gui, Add, Button, gFlawless h20, Apply Flawless Widescreen fix!
   Gui, Add, Button, gGTAHax h20, Apply GTAHaX EWO Codes!
   Gui, Add, Button, gGTAHaxCEO h20, Apply CEO Circle!
   Gui, Add, Button, gOpenDirectory h20, Open Local Directory of Ryzen's Macros!
   If (DebugTesting = 1) {
      Gui, Add, Button, gSpotify h20, get rid of noob spotify
      Gui, Add, Button, gClumsy h20, toggle clumsy
   }
   
   ; Button Links
   Gui, Add, Link,x158 y62, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Save-Config-Start-Macros">(?)</a>
   Gui, Add, Link,x140 y89, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Start-Macros-Don't-Save">(?)</a>
   Gui, Add, Link,x78 y116, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Hide-GUI">(?)</a>
   Gui, Add, Link,x91 y142, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Exit-Macros">(?)</a>
   Gui, Add, Link,x188 y168, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Apply-Flawless-Widescreen-Fix">(?)</a>
   Gui, Add, Link,x170 y193, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Apply-GTAHaX-EWO-Codes">(?)</a>
   Gui, Add, Link,x120 y219, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Apply-CEO-Circle">(?)</a>
   Gui, Add, Link,x235 y245, <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Open-Local-Directory-of-Ryzen's-Macros">(?)</a>
Return

Apply:
   Global save = 0
   Goto SaveConfigRedirect
Return

SaveConfig:
   Global save = 1
   Goto SaveConfigRedirect
Return

SaveConfigRedirect:
   GuiControlGet, ProcessCheck2
   SetTimer, Write, Off, -2147483648
   SetTimer, TabBackInnn, Off, -2147483648
   SetTimer, ProcessCheckTimer, Off, -2147483648
   Gosub,DisableAll
   Gui,Submit,NoHide
   If (save = 1) {
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
      IniWrite,%PassiveDisableSpamToggle%,%CFG%,Misc,Passive Disable Spam Toggle
      IniWrite,%AlwaysOnTop%,%CFG%,Misc,Always On Top
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
   Hotkey, *%RPGSpam%, RPGSpam, UseErrorLevel On
   Hotkey, *%PassiveDisableSpamToggle%, PassiveDisableSpamToggle, UseErrorLevel On
   If (EWOWrite = 1) {
      SetTimer, Write, 10, -2147483648
      SetTimer, TabBackInnn, 10, -2147483648
   }
   if (ProcessCheck2 = 1)
      SetTimer, ProcessCheckTimer, 100, -2147483648
   ;MsgBox, 0, Saved!, Your config has been saved and/or the macros have been started!, 2
   If (GTAAlreadyClosed = 0 && save = 1)
      TrayTip, Ryzen's Macros %MacroVersion%, Your config has been saved and/or the macros have been started!, 10, 1
   else if (save = 0)
      TrayTip, Ryzen's Macros %MacroVersion%, Your config has been applied and/or the macros have been started! Settings have not been saved., 10, 1
   else if (GTAAlreadyClosed = 1) && (ProcessCheck2 = 1)
      TrayTip, Ryzen's Macros %MacroVersion%, GTA has not been detected to be open`, the macros will not automatically close and Show EWO Score will not work`. Please restart the macros once you have restarted GTA., 10, 1
   #Include *i %A_MyDocuments%\Ryzen's Macros\DynamicScript.ahk
Return

CloseGTAHaX:
   Process, Close, %Gay%
   Process, Close, %Gay2%
   Process, Close, %Gay3%
   Process, Close, %Obese11%
Return

Nice1234:
   Gui,3:Hide
Return

StandardTrayMenu:
   If (TrayButtonInfo = 1) {
      If (A_ThisMenuItem = "Open")
         DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65406, UInt,0 )
   }
   If (A_ThisMenuItem = "Help")
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65411, UInt,0 )
   
   If (A_ThisMenuItem = "Window Spy" )
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65402, UInt,0 )
   
   If (A_ThisMenuItem = "Reload This Script" )
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65400, UInt,0 )
   
   If (A_ThisMenuItem = "Suspend Hotkeys" ) {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65404, UInt,0 )
   }
   
   If (A_ThisMenuItem = "Pause Script" ) {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65403, UInt,0 )
   }
   
   If (A_ThisMenuItem = "Exit" )
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65405, UInt,0 )

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
      IniRead,Read_PassiveDisableSpamToggle,%CFG%,Misc,Passive Disable Spam Toggle
      IniRead,Read_AlwaysOnTop,%CFG%,Misc,Always On Top
      
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
      GuiControl,,PassiveDisableSpamToggle,%Read_PassiveDisableSpamToggle%
      GuiControl,,AlwaysOnTop,%Read_AlwaysOnTop%
   }
Return

CheckHWID:
   UrlDownloadToFile, https://pastebin.com/raw/dpBPUkBM, %A_Temp%\Keys.ini
   while IfExist, A_Temp "\Keys.ini" ; This cheeky little piece of code makes it wait until the file exists.
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
      Loop % count {
         if StrGet(NumGet(addr + 8)) = procName
            PID := NumGet(addr + 4, "UInt"), PIDs.Push(PID)
         addr += A_PtrSize = 4 ? 16 : 24
      }
      DllCall("Wtsapi32\WTSFreeMemory", Ptr, pProcessInfo)
      Return PIDs
   }
Return

PassiveDisableSpamCheck:
   GuiControlGet, PassiveDisableSpam
   if (PassiveDisableSpam = 0) {
      SetTimer, PassiveDisableSpam, Delete, -2147483648
   } else {
      SetTimer, PassiveDisableSpam, 7500, -2147483648
   }
Return

PassiveDisableSpamToggle:
   GuiControlGet, PassiveDisableSpam
   if (PassiveDisableSpam = 1) {
      SetTimer, PassiveDisableSpam, Delete, -2147483648
      GuiControl,, PassiveDisableSpam, 0
      MsgBox, 0, Ryzen's Macros %MacroVersion%, Passive Disable Spam disabled , 0.75
   } else {
      SetTimer, PassiveDisableSpam, 7500, -2147483648
      GuiControl,, PassiveDisableSpam, 1
      TrayTip, Ryzen's Macros %MacroVersion%, Passive Disable Spam enabled, 10, 1
      MsgBox, 0, Ryzen's Macros %MacroVersion%, Passive Disable Spam enabled , 0.75
   }
Return

PassiveDisableSpam:
   GuiControlGet, PassiveDisableSpam
   If (PassiveDisableSpam = 1) {
      If WinActive("ahk_exe GTA5.exe") {
         If GetKeyState("LButton","P") {
            SendInput {Blind}{up down}{enter down}{lbutton up}
            Send {Blind}{backspace}{%InteractionMenuKey%}{enter up}{%InteractionMenuKey%}
            SendInput {Blind}{up up}{lbutton down}
         } else {
            SendInput {Blind}{up down}{enter down}{lbutton up}
            Send {Blind}{backspace}{%InteractionMenuKey%}{enter up}{%InteractionMenuKey%}
            SendInput {Blind}{up up}
         }
      }
   }
Return

OpenDirectory:
   Run, %ConfigDirectory%
Return

AlwaysOnTopCheck:
   GuiControlGet, AlwaysOnTop
   if (AlwaysOnTop = 0) {
      SetTimer, AlwaysOnTop, Delete, -2147483648
   } else {
      SetTimer, AlwaysOnTop, 25, -2147483648
   }
Return

AlwaysOnTop:
   GuiControlGet, AlwaysOnTop
   If (AlwaysOnTop = 1) {
      If WinActive("ahk_exe GTA5.exe") {
         WinSet, AlwaysOnTop, On, ahk_exe GTA5.exe
      } else {
         WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
         WinMinimize, ahk_exe GTA5.exe
      }
   }
Return

SendInputTestV2() {
   BlockInput, On
   WinActivate, ahk_exe GTA5.exe
   sleep 250
   StartTime := A_TickCount
   Send t{shift up}
   SendInput Loading{. 30}
   EndTime := A_TickCount - StartTime
   sleep 500
   Send {Blind}{esc}
   sleep 500
   BlockInput, Off
   ; MsgBox %EndTime%
   If (EndTime > 200)
      MsgBox, 4, Ryzen's Macros %MacroVersion%, I have detected that macros are currently incredibly slow, most likely due to Flawless Widescreen, or a different program that also installs the keyboard hook. Would you like to continue anyway?
   IfMsgBox No
   { ExitApp
}}

Clumsy:
   if (clumsyEnabled = 0) {
      Process, Close, %Gay3%
      Run, clumsy.exe, %ConfigDirectory%\clumsy,Min,Gay3
      WinWait, ahk_pid %Gay3%
      WinGet, ID3, ID, ahk_pid %Gay3%
      WinSet, ExStyle, ^0x80, ahk_id %ID3% ; 0x80 is WS_EX_TOOLWINDOW
      Control, Choose, 4, ComboBox1, ahk_pid %Gay3%
      Control, Check,, Button4, ahk_pid %Gay3%
      ControlSetText,Edit2,%clumsyPing%,ahk_pid %Gay3%
      sleep 100
      ControlClick, Button2, ahk_pid %Gay3%
      global clumsyStarted = 1
      global clumsyEnabled = 1
      global Notified = 0
      SetTimer, ClumsyClosed, 350, -2147483648
      msgbox, clumsy enabled
   } else {
      Process, Close, %Gay3%
      SetTimer, ClumsyClosed, Delete, -2147483648
      global clumsyEnabled = 0
      msgbox, clumsy disabled
   }
Return

ClumsyClosed:
   If (clumsyStarted) && (!Notified) && (!ProcessExist(ahk_pid Gay3)) {
      msgbox, for some reason it closed`, idk why
      global Notified = 1
      SetTimer, ClumsyClosed, Delete, -2147483648
   }
Return

ProcessExist(Name) { ; For convenience sake
   Process,Exist,%Name%
   Return ErrorLevel
}

CreateTrayOptions:
   Menu, Tray, NoStandard ; Default trays but with some extra things above it, usually not possible so you need to do some complicated things to make it work.
   Menu, Tray, Add, Show UI, ShowUI
   Menu, Tray, Add, Hide UI, HideWindow
   Menu, Tray, Add, Save Macros, SaveConfig
   Menu, Tray, Add
   If (TrayButtonInfo = 1)
      Menu, Tray, Add, Open, StandardTrayMenu
   Menu, Tray, Add, Help, StandardTrayMenu
   Menu, Tray, Add
   Menu, Tray, Add, Window Spy, StandardTrayMenu
   Menu, Tray, Add, Reload This Script, Reload
   Menu, Tray, Add
   Menu, Tray, Add, Suspend Hotkeys, StandardTrayMenu
   Menu, Tray, Add, Pause Script, StandardTrayMenu
   Menu, Tray, Add, Exit, ExitMacros
   If (TrayButtonInfo = 1)
      Menu, Tray, Default, Open
   
   Menu, Tray, Tip, Ryzen's Macros Version %MacroVersion%
Return

ToggleSing: ; Toggles the sing
   GuiControlGet, singEnabled
   if (singEnabled) ; If sing is on
   {
      global singEnabledVariable = 1 ; Indicates that sing is enabled.
      Goto, Sing
   }
   else
   {
      global singEnabledVariable = 0 ; Indicates that sing is disabled if you disable it while it is running.
   }
Return

Sing: ; Sings in chat lmao
   global paused = 0
   global keepRunning = 1 ; Set to 1 at the start unless you use the Safeguard Hotkey.
   global noWaitExistsTimeout := 3000 ; If there is no wait() in the lyrics file and no wait specified in the file, then it will sleep this amount per message automatically.
   noAutoWait = 0 ; Resets it when you restart. Probably not necessary but maybe.
   waitExistsInLyrics = 0 ; Resets it when you restart
   
   songFileLocation = %ConfigDirectory%\Lyrics.txt ; Location of the file
   WinActivate, ahk_exe GTA5.exe ; Activates the GTA window
   
   Loop, Read, %songFileLocation% ; The part where the magic happens!
   {
      if (keepRunning) && (singEnabledVariable) ; This will only be disabled if you press the safeguard key. Timers override basically any thread priority, so this is better than a hotkey. If you do not specify a value that in the if statement, it will be if it is 1.
      {
         If (paused) { ; This cheeky bit of code will simply cause the loop to get stuck until the pause variable is no longer True. Pretty bad coding practice probably, but in this case it is probably the only way without disabling Timers.
            While (paused)
               {}
            }
         
         If (A_LoopReadLine = "") { ; If the line is empty, skip it and go to the next loop.
            Continue ; Goes back to the top of the loop and continues with the next line
         }
         else if InStr(A_LoopReadLine,"//") ; If it begins with // (a comment) then skip it.
         {
            foundPos := InStr(A_LoopReadLine,"//") ; The character "position" of //. Will only do something if it is in the front. I'm too dumb to make it parse the entire thing. Fuck regex.
            if (foundPos = 1) || (foundPos = 2) ; Incase you have a space before // for some reason, then the "position" will be 2.
               Continue ; Goes back to the top of the loop and continues with the next line
         }
         else if InStr(A_LoopReadLine,"NoAutoWait()") ; If the line starts with "NoAutoWait" then it will NOT wait.
         {
            noAutoWait = 1
         }
         else if InStr(A_LoopReadLine,"ExceptionWait(") ; If the line starts with "ExceptionWait(" then it will wait WITHOUT notifying the script of the fact that Wait() exists within the text file.
         {
            waitTime := StrSplit(A_LoopReadLine,"(",")",2) ; Splits the array into wait( and the rest of the string. It will omit the ")" so only the number remains. This number is then used to sleep.
            waitTime := waitTime[2] ; Makes waitTime equal to the second value in the array to make it slightly simpler.
            sleep %waitTime% ; It then waits the amount of time specified in the lyrics file.
         }
         else if InStr(A_LoopReadLine,"Wait(") || InStr(A_LoopReadLine,"wait(") ; If the line starts with "wait(" then it will wait and notify the script of the fact that Wait() exists within the text file.
         {
            waitExistsInLyrics = 1 ; Variable that lets me know that wait exists somewhere in the lyrics, and it will not count commented waits, thanks to this being below the other ifs in an else statement.
            waitTime := StrSplit(A_LoopReadLine,"(",")",2) ; Splits the array into wait( and the rest of the string. It will omit the ")" so only the number remains. This number is then used to sleep.
            waitTime := waitTime[2] ; Makes waitTime equal to the second value in the array to make it slightly simpler.
            sleep %waitTime% ; It then waits the amount of time specified in the lyrics file.
         }
         else if InStr(A_LoopReadLine,"SafeguardKey(") ; If the line starts with "SafeguardKey(" then it will use the key as the key to cancel singing.
         {
            global safeguardKey := StrSplit(A_LoopReadLine,"(","y" ")",2) ; Uses delimiters again
            global safeguardKey := safeguardKey[2] ; Makes it slightly simpler
            SetTimer, UltraHighPriorityLoopBypassingThread,1,2147483647 ; Find out more at the bottom of the script
         }
         else if InStr(A_LoopReadLine,"PauseKey(") ; If the line starts with "PauseKey(" then it will use the key as the key to pause singing.
         {
            global pauseKey := StrSplit(A_LoopReadLine,"(","y" ")",2) ; Uses delimiters again
            global pauseKey := pauseKey[2] ; Makes it slightly simpler
            SetTimer, UltraHighPriorityLoopBypassingThread,1,2147483647 ; Find out more at the bottom of the script
         }
         else if InStr(A_LoopReadLine,"StandardWaitTime(") ; Will change noWaitExistsTimeout variable to the new value. This will change how long it automatically waits between lines.
         {
            global noWaitExistsTimeout := StrSplit(A_LoopReadLine,"(","e" ")",2) ; Uses delimiters again
            global noWaitExistsTimeout := noWaitExistsTimeout[2] ; Makes it slightly simpler
         }
         else
         {
            Gosub, IJustCopyPastedThisChatFunction ; If it is (most likely) part of a valid lyrics that you will actually want to be sent, then send the messages.
            If (!waitExistsInLyrics) && (!noAutoWait) ; Waits 2000ms (2 seconds) if there is no wait() specified anywhere in the file and if NoAutoWait is not enabled for the current line.
               sleep %noWaitExistsTimeout%
            noAutoWait = 0 ; Resets NoAutoWait after it has sent something, so it doesn't stop waiting forever.
         }
      }
      else ; If the Safeguard Key has been pressed, stop the loop.
         break
   }
   GuiControl,,singEnabled,0 ; Once it is done, disable Sing.
   SetTimer, UltraHighPriorityLoopBypassingThread,Off,2147483647 ; Disables the timer after it is done
Return

IJustCopyPastedThisChatFunction: ; Pasted from CustomTextSpam.
   Length := StrLen(A_LoopReadLine)
   if (Length >= 31) {
      Loop, 140 {
         ArrayYes%A_Index% =
      }
      Send {Blind}{t down}
      SendInput {Blind}{enter down}
      Send {Blind}{t up}{f24 up}
      StringSplit, ArrayYes, A_LoopReadLine
      SendInput {Raw}%ArrayYes1%%ArrayYes2%%ArrayYes3%%ArrayYes4%%ArrayYes5%%ArrayYes6%%ArrayYes7%%ArrayYes8%%ArrayYes9%%ArrayYes10%%ArrayYes11%%ArrayYes12%%ArrayYes13%%ArrayYes14%%ArrayYes15%%ArrayYes16%%ArrayYes17%%ArrayYes18%%ArrayYes19%%ArrayYes20%%ArrayYes21%%ArrayYes22%%ArrayYes23%%ArrayYes24%%ArrayYes25%%ArrayYes26%%ArrayYes27%%ArrayYes28%%ArrayYes29%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYes30%%ArrayYes31%%ArrayYes32%%ArrayYes33%%ArrayYes34%%ArrayYes35%%ArrayYes36%%ArrayYes37%%ArrayYes38%%ArrayYes39%%ArrayYes40%%ArrayYes41%%ArrayYes42%%ArrayYes43%%ArrayYes44%%ArrayYes45%%ArrayYes46%%ArrayYes47%%ArrayYes48%%ArrayYes49%%ArrayYes50%%ArrayYes51%%ArrayYes52%%ArrayYes53%%ArrayYes54%%ArrayYes55%%ArrayYes56%%ArrayYes57%%ArrayYes58%%ArrayYes59%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYes60%%ArrayYes61%%ArrayYes62%%ArrayYes63%%ArrayYes64%%ArrayYes65%%ArrayYes66%%ArrayYes67%%ArrayYes68%%ArrayYes69%%ArrayYes70%%ArrayYes71%%ArrayYes72%%ArrayYes73%%ArrayYes74%%ArrayYes75%%ArrayYes76%%ArrayYes77%%ArrayYes78%%ArrayYes79%%ArrayYes80%%ArrayYes81%%ArrayYes82%%ArrayYes83%%ArrayYes84%%ArrayYes85%%ArrayYes86%%ArrayYes87%%ArrayYes88%%ArrayYes89%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYes90%%ArrayYes91%%ArrayYes92%%ArrayYes93%%ArrayYes94%%ArrayYes95%%ArrayYes96%%ArrayYes97%%ArrayYes98%%ArrayYes99%%ArrayYes100%%ArrayYes101%%ArrayYes102%%ArrayYes103%%ArrayYes104%%ArrayYes105%%ArrayYes106%%ArrayYes107%%ArrayYes108%%ArrayYes109%%ArrayYes110%%ArrayYes111%%ArrayYes112%%ArrayYes113%%ArrayYes114%%ArrayYes115%%ArrayYes116%%ArrayYes117%%ArrayYes118%%ArrayYes119%
      Send {Blind}{f24 up}
      SendInput {Raw}%ArrayYes120%%ArrayYes121%%ArrayYes122%%ArrayYes123%%ArrayYes124%%ArrayYes125%%ArrayYes126%%ArrayYes127%%ArrayYes128%%ArrayYes129%%ArrayYes130%%ArrayYes131%%ArrayYes132%%ArrayYes133%%ArrayYes134%%ArrayYes135%%ArrayYes136%%ArrayYes137%%ArrayYes138%%ArrayYes139%%ArrayYes140%
      Send {Blind}{enter up}
   }
   else if (Length <= 30) {
      Send {Blind}{t down}
      SendInput {enter down}
      Send {Blind}{t up}{f24 up}
      SendInput {Raw}%A_LoopReadLine%
      Send {Blind}{enter up}
   }
return

UltraHighPriorityLoopBypassingThread: ; SetTimers override basically any thread priority, so this is a better way.
   
   GuiControlGet, singEnabled ; If you disable singing while singing it wouldn't stop singing but now it will thanks to this.
   if (singEnabled) ; If sing is on
      global singEnabledVariable = 1 ; Indicates that sing is enabled.
   else
   {
      global singEnabledVariable = 0 ; Indicates that sing is disabled if you disable it while it is running.
      SetTimer, UltraHighPriorityLoopBypassingThread,Off,2147483647 ; Disables the timer after it is done
      MsgBox, 0, Ryzen's Macros %MacroVersion%, Sing disabled mid-singing`, lyrics cancelled., 1
   }
   
   if GetKeyState(pauseKey,"P") ; Pause function
   {
      SendInput {Blind}{%pauseKey% up}
      If (!paused) ; Pauses it
      {
         global paused = 1
         MsgBox, 0, Ryzen's Macros %MacroVersion%, Pause Key pressed`, lyrics paused. Press again to resume where you left off., 1
      }
      else if (paused) ; Unpauses it
      {
         global paused = 0
         MsgBox, 0, Ryzen's Macros %MacroVersion%, Pause Key pressed`, lyrics resumed. Press again to pause again., 1
      }
   }
   else if GetKeyState(safeguardKey,"P") ; Cancel function
   {
      SendInput {Blind}{%safeguardKey% up}
      GuiControl,,singEnabled,0 ; Once it is done, disable Sing.
      global keepRunning = 0 ; Makes it stop running
      SetTimer, UltraHighPriorityLoopBypassingThread,Off,2147483647 ; Disables the timer after it is done
      MsgBox, 0, Ryzen's Macros %MacroVersion%, Safeguard Key pressed`, lyrics cancelled., 1
   }
Return

Sleep(ms) {
   DllCall("Sleep",UInt,ms)
}

PrepareChatMacro() {
   Send {Blind}{t down}
   SendInput {Blind}{enter down}
   Send {Blind}{t up}{f24 up}
}