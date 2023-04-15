if (!A_IsAdmin) ; Runs the script as an admin.
   Run *RunAs "%A_ScriptFullPath%"
SetBatchLines, -1 ; Removes the built in 10ms Sleep that happens after every line of code normally. It should never Sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.
Menu, Tray, NoStandard ; Default trays but with some extra things above it, usually not possible so you need to do some complicated thinags to make it work.
ConfigDirectory = %A_MyDocuments%\Ryzen's Macros
IfNotExist, %ConfigDirectory%
   FileCreateDir, %ConfigDirectory%
IfNotExist, %ConfigDirectory%\assets
   FileCreateDir, %ConfigDirectory%\assets
clumsyEnabled = 0
MacroVersion := "4.0"
If InStr(A_ScriptName,.ahk) && not (A_ScriptName = "AutoHotkey.ahk")
{
   MacroText := "Ryzen's Macros Dev Build Version "MacroVersion ; Macro version
   isCompiled = 0
} else
{
   MacroText := "Ryzen's Macros Release Build "MacroVersion ; Macro version
   isCompiled = 1
}
; Debug:
If (isCompiled)
{
   ListLines Off ; Removes line history, makes the script slightly more secret.
}

; Variables:
RunningInScript = 1 ; Required for dynamic script to work properly
thermal = 0
Herpes := "No more bitches :(" ; ginlang asked me to add a variable named herpes
CFG = %A_MyDocuments%\Ryzen's Macros\GTA Binds.ini ; Config file name
global originalTime
CrosshairDone := 0 ; If crosshair has been applied
; gtaWindow := This apparently doesn't work so I will just manually specify it
MCCEO2 := 0 ; If you are in MC
SendInputFallbackText = I have detected that it has taken a very long time to complete the chat message. First, check if the characters are being sent one by one, or in instant `"batches`". If it is being sent in batches, then your FPS is likely very low. Please complain to me on Discord and I will raise the threshold for this message. If it is being sent one by one, try this: If you are running Flawless Widescreen, you must close it, as it causes issues, and makes most macros far slower. Please open a support ticket on the Discord Server if the problem persists, or if Flawless Widescreen is not running.
WriteWasJustPerformed = 0 ; EWO Score Write was just performed
IniRead,DebugTesting,%CFG%,Debug,Debug Testing ; Checks if debug testing is true, usually false.
IniRead,clumsyPing,%CFG%,Debug,clumsy ping ; yes
IniRead,WhileChat,%CFG%,Debug,Improve Chat Macros But You Can't Use Multiple Keybinds ; yes
IniWrite,%WhileChat%,%CFG%,Debug,Improve Chat Macros But You Can't Use Multiple Keybinds
IniRead,OriginalLocation, %ConfigDirectory%\FileLocationData.ini, Location, Location
IniRead,OriginalName, %ConfigDirectory%\FileLocationData.ini, Name, Name

; GTAHaX EWO Offsets:
FreemodeGlobalIndex = 262145
EWOGlobalOffset1 = 28409
; GTAHaX EWO Offsets 2:
EWOGlobalIndex = 2793046
EWOGlobalOffset0 = 6899
; GTAHaX EWO Score Offsets:
ScoreGlobalIndex = 2672505
ScoreGlobalOffset1 = 1685
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
   If !WinExist("ahk_exe GTA5.exe") ; Makes the macros not immediately close if you run it while GTA isn't open
      GTAAlreadyClosed = 1
   else
      GTAAlreadyClosed = 0
   #SingleInstance, force ; Forces single instance
   #KeyHistory 0 ; Removes key history, makes the script slightly more secret. Isn't conditional so will always be removed.
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
   Process, Priority, GTA5.exe, H ; I heard that high priority gives keyboard input priority. I only heard it improves input speed and didn't read into it because yes.
   Process, Priority,, A ; Sets priority of the script to Above Normal because I can
   DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ; yes
   SetTitleMatchMode, 2 ; I forgor :dead_skull:
   SetDefaultMouseSpeed, 0 ; Something
   SetKeyDelay, -1, -1 ; Sets key delay to the lowest possible, there is still delay due to the keyboard hook in GTA, but this makes it excecute as fast as possible WITHOUT skipping keystrokes. Set this a lot higher if you uninstalled the keyboard hook using mods.
   SetWinDelay, -1 ; After any window modifying command, the script has a built in delay. Fuck delays.
   SetControlDelay, 0 ; After any control modifying command, for example; ControlSend, there is a built in delay. Set to 0 instead of -1 because having a slight delay may improve reliability, and is unnoticable anyways.
   Gui,Font,q5,Segoe UI Semibold ; Sets font to something
   IniRead,Read_AlwaysOnTop,%CFG%,Misc,Always On Top ; Secret module
   If (Read_AlwaysOnTop)
   {
      WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
      WinMinimize, ahk_exe GTA5.exe
      SetTimer, AlwaysOnTop, 25, -2147483648
   }
   global sendInputWork = 1 ; SendInput works, will be changed to false if it doesn't work
   If (IsCompiled) && (!GTAAlreadyClosed)
   {
      endTime := SendInputTestV2() ; Check to see if SendInput works or not
      If (endTime > 200)
      {
         MsgBox, 2, %MacroText%, I have detected that macros are currently incredibly slow, most likely due to Flawless Widescreen, or a different program that also installs the keyboard hook.
         global sendInputWork = 0 ; It doesn't work so change it to false
      }
      IfMsgBox Abort
         ExitApp
      IfMsgBox Retry
         Goto Reload
   }
   MsgBox, 0, %MacroText%, Successfully started. Welcome to Ryzen's Macros! , 0.75
   Gui, Add, Tab3,, Combat|Chat|In-Game Binds|Options|Misc|Buttons/Misc|| ; Adds tabs to the GUI
   Gosub, CombatMacros ; Combat Macros
   Gosub, ChatMacros ; Chat Macros
   Gosub, InGameBinds ; In-Game Binds
   Gosub, MacroOptions ; Options for the macros
   Gosub, MiscMacros ; Custom Macros and a few Misc Macros.
   Gosub, SavingAndButtonsAndMiscMacros ; Buttons and some more settings and shit
   
   Gosub, Read ; Reads your config file
   GuiControl,1:,CEOMode,1 ; Sets CEO Mode to 1 whenever you start the script
   If (DebugTesting)
      GuiControl,1:,PassiveDisableSpam,0 ; Sets CEO Mode to 1 whenever you start the script
   DetectHiddenWindows, On ; It does something
   Gui0 := WinExist(A_ScriptFullpath "ahk_pid" DllCall("GetCurrentProcessId")) ; Somehow linked to tray items
   DetectHiddenWindows, Off ; It does something
   Gui, Show,, %MacroText%
   
   ;MsgBox, 0, Welcome!, HWID Matching! Welcome to Ryzen's Macros. Add me on Discord (cryleak#3961) if you have any issues. Good luck.
   Gosub, StandardTrayMenu
Return

Reload: ; Reloads the macros
GuiControlGet, AlwaysOnTop
If (AlwaysOnTop)
{
   WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
   WinMinimize, ahk_exe GTA5.exe
}
If (!isCompiled)
{
   MsgBox, 0, %MacroText%,If you see this`, something strange is happening. , 0.75
   Reload
}
Else
{
   Process, Close, %Gay%
   Process, Close, %ewoWriteWindow%
   Process, Close, %Gay3%
   Process, Close, %Obese11%
   Run,Reload.exe,%A_MyDocuments%
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
   If (AlwaysOnTop)
   {
      WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
      WinMinimize, ahk_exe GTA5.exe
   }
   Process, Close, %Gay%
   Process, Close, %ewoWriteWindow%
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
   If (CEOMode)
      Send {Blind}{down}
   SendInput {Blind}{enter up}
   Send {Blind}{down down}
   SendInput {Blind}{enter down}
   Send {Blind}{down up}
   SendInput {Blind}{enter up}
   If (!NightVision)
      Send {Blind}{down 4}
   Sleep(50)
   Send {Blind}{space}{%InteractionMenuKey%}
return

jetThermal:
   GuiControlGet, CEOMode
   GuiControlGet, NightVision
   If (!thermal)
      thermal = 1
   else
      thermal = 0
   If (CEOMode)
   {
      SendInput {Blind}{enter down}
      Send {Blind}{%InteractionMenuKey%}{enter up}{down down}
      SendInput {Blind}{enter down}
      Send {Blind}{down up}
      SendInput {Blind}{enter up}
      Send {Blind}{down down}
      SendInput {Blind}{enter down}
      Send {Blind}{down up}
      SendInput {Blind}{enter up}
      Send {Blind}{f24 up}{right}{left}
      if (!thermal)
         Send {Blind}{backspace 3}
      else
         Send {Blind}{%InteractionMenuKey%}
   }
   if (!thermal)
   {
      SendInput {Blind}{lbutton up}{enter down}
      Send {Blind}{down 3}
      If (CEOMode)
         Send {Blind}{down}
      SendInput {Blind}{enter up}
      Send {Blind}{down down}
      SendInput {Blind}{enter down}
      Send {Blind}{down up}
      SendInput {Blind}{enter up}
      Sleep(50)
      Send {Blind}{space}{%InteractionMenuKey%}
   }
Return

FastSniperSwitch: ; Self explanatory
   GuiControlGet, FasterSniper
   SendInput {Blind}{%FastSniperSwitch% up}
   If (FasterSniper)
   {
      Send {%StickyBind% down}{%SniperBind% down}{tab}
      SendInput {Blind}{%SniperBind% up}{%StickyBind% up}
   } else
   {
      Send {Blind}{%SniperBind%}
      Sleep(17)
      Send {Blind}{lbutton down}
      Sleep(12)
      Send {Blind}{lbutton up}{%SniperBind%}
      Sleep(17)
      Send {Blind}{lbutton down}
      Sleep(110)
      Send {Blind}{lbutton up}
   }
return

EWO: ; Self explanatory
   GuiControlGet, SmoothEWO
   GuiControlGet, SmoothEWOMode
   GuiControlGet, EWOWrite
   GuiControlGet, shootEWO
   If (SmoothEWOMode = "Fast Respawn") && (SmoothEWO) || (SmoothEWOMode = "Sticky") && (SmoothEWO)
      Goto, MiscEWOModes
   If (shootEWO)
   {
      SendInput {Blind}{lbutton down}
      Send {Blind}{f24 up}
   }
   SendInput {Blind}{lbutton up}{rbutton up}
   If (SmoothEWO)
   {
      If GetKeyState("RButton","P")
      {
         switch SmoothEWOMode
         {
         case "Staeni":
            Sleep(100)
         case "Faster":
            Sleep(45)
         }
      }
      
      switch SmoothEWOMode
      {
      case "Fasterest":
         Send {Blind}{lbutton down}{rbutton down}{lbutton up}{rbutton up}
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}{%EWOLookBehindKey% down}
         Send {Blind}{f24 2}{f24 up}
         SendInput {Blind}{wheelup}{up up}{enter up}
      case "Custom":
         GuiControlGet, customTime
         customTimeFrames := StrSplit(customTime,"F")
         SendInput {Blind}{lbutton down}{rbutton down}
         Send {Blind}{%EWOLookBehindKey% down}
         SendInput {Blind}{rbutton up}{lbutton up}
         If InStr(customTime,"F")
            CancerFunction("f24 up",customTimeFrames[1],"Send")
         else
            Sleep(customTime)
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{f24}{f24 up}
         SendInput {Blind}{wheelup}{up up}{enter up}
      case "Faster":
         SendInput {Blind}{lbutton down}{rbutton down}
         Send {Blind}{f24 up}
         SendInput {Blind}{alt up}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%EWOMelee% down}{%InteractionMenuKey% down}{%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}
         Sleep(47)
         SendInput {Blind}{up down}
         Sleep(35)
         SendInput {Blind}{WheelUp}
         Sleep(28)
         SendInput {Blind}{enter up}{%InteractionMenuKey% up}{%EWOLookBehindKey% up}
      case "Staeni":
         /*
         SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{%InteractionMenuKey% down}
         Sleep(20)
         Send {Blind}{%EWOLookBehindKey% down}{up}
         Sleep(25)
         SendInput {Blind}{WheelUp}
         Sleep(46)
         SendInput {Blind}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{enter up}{%InteractionMenuKey% up}
         */
         SendInput {Blind}{alt up}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOLookBehindKey%}{%EWOSpecialAbilitySlashActionKey% down}
         Sleep(33.5)
         SendInput {Blind}{%EWOLookBehindKey% down}
         Sleep(14)
         SendInput {Blind}{up down}
         Sleep(37.5)
         SendInput {Blind}{WheelUp}
         Sleep(50)
         SendInput {Blind}{enter up}{%InteractionMenuKey% up}{%EWOLookBehindKey% up}
      case "Fastest":
         Send {Blind}{lbutton down}{rbutton down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}{f24 up}
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}{enter down}
         Send {Blind}{%InteractionMenuKey%}{f24 up}{up}{up}{enter up}
      case "Retarded":
         StringUpper, EWOLookBehindKey, EWOLookBehindKey
         Random, Var, 1, 3
         SendInput {Blind}{lbutton down}{rbutton down}
         Send {Blind}{f24 up}
         SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}
         Sleep(25)
         Send {Blind}{up}
         Sleep(25)
         Send {Blind}{up}
         Sleep(40)
         Send {Blind}{%EWOLookBehindKey% down}
         if (var) ; why the fuck did i do this
            Send {Blind}{f24 2}
         else if (var = 2)
            Send {Blind}{f24}
         else
            Send {Blind}{f24 3}
         Send {Blind}{enter up}
         StringLower, EWOLookBehindKey, EWOLookBehindKey
      case "Retarded2":
         SendInput {Blind}{lbutton down}{rbutton down}
         Send {Blind}{f24 up}
         SendInput {Blind}{lbutton up}{rbutton up}{enter down}
         Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
         SendInput {Blind}{enter down}
         Send {Blind}{up up}
         SendInput {Blind}{enter up}
         GuiControl,1:, CEOMode, 0
         Sleep(110)
         
         SendInput {Blind}{%EWOLookBehindKey% down}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{%InteractionMenuKey% down}
         Sleep(13)
         Send {Blind}{shift down}{f24 up}{shift up}{up}
         Sleep(12)
         Send {Blind}{up}
         Sleep(9)
         Send {Blind}{%EWOSpecialAbilitySlashActionKey% down}{enter up}
      case "Retarded3":
         SendInput {Blind}{lbutton down}{rbutton down}
         Send {Blind}{f24 up}
         SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}{%EWOMelee% down}
         Sleep(30)
         Send {Blind}{up}
         Sleep(20)
         Send {Blind}{up}
         Sleep(40)
         SendInput {Blind}{space down}{%EWOLookBehindKey% down}
         Send {Blind}{f24 up}{enter}
         SendInput {Blind}{space up}
      }
   } else
   {
      SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{%EWOMelee% down}{enter down}{up down}{%InteractionMenuKey% down}{g down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}
      Send {Blind}{f24}{f24 up}
      SendInput {Blind}{wheelup}{up up}{enter up}
   }
   SendInput {up up}
   Send {Blind}{enter 2}{up}{enter}{left}{down}{enter}
   SendInput {Blind}{%EWOSpecialAbilitySlashActionKey% up}{%EWOLookBehindKey% up}{%EWOMelee% up}{%InteractionMenuKey% up}{up up}{g up}{%EWO% up}
   SetCapsLockState, Off
   SetMouseDelay, 10
return

MiscEWOModes:
   GuiControlGet, SmoothEWO
   GuiControlGet, SmoothEWOMode
   GuiControlGet, EWOWrite
   GuiControlGet, shootEWO
   If (SmoothEWOMode = "Sticky") && (SmoothEWO)
   {
      SendInput {lbutton down}{rbutton up}
      Send {Blind}{%RifleBind%}
      SendInput {lbutton up}
      Send {Blind}{tab} ; {lbutton 5}
      Loop, 15 {
         if WinActive("ahk_exe GTA5.exe")
         {
            Send {Blind}{g 4} ; {lbutton}
         }
      }
      SendInput {Blind}{lbutton up}
   }
Return

Write: ; Shows the score even if you have EWOd in the session using some advanced shit
   If (!GTAAlreadyClosed)
   {
      if !WinExist("ahk_pid " ewoWriteWindow) ; If window doesn't exist, make it exist and add shit to it
      {
         Run, GTAHaXUI.exe, %ConfigDirectory%,Min,ewoWriteWindow ; "Min" is a launch option you can specify. This makes the window invsible; however, it will still show up on Alt+Tab. I fix that 2 lines below.
         WinWait, ahk_pid %ewoWriteWindow% ; Waits for GTAHaX to actually exist before continuing
         WinSet, ExStyle, ^0x80, ahk_pid %ewoWriteWindow% ; Makes the window not show up on Alt+Tab
         ControlSend, Edit1, {down}{backspace}%ScoreGlobalIndexAddedTogether%, ahk_pid %ewoWriteWindow%
         Sleep(20)
      } else ; If it does exist
      {
         ControlGet, currentScoreGlobalIndex,Line,1,Edit1,ahk_pid %ewoWriteWindow% ; GTAHaX uses a very basic window, so AHK can retrieve the values from "controls". These are the lines in this case. Here it is checking what the top line contains.
         ControlGet, currentValue,Line,1,Edit7,ahk_pid %ewoWriteWindow% ; This is the current value. This is next to the lowest global variable-related line. It gets the current value of the global. It will only click if it is 1
         ControlGet, newValue,Line,1,Edit8,ahk_pid %ewoWriteWindow% ; The value we want to set it to. We want this to be 0.
         If (currentValue = 1) && (currentScoreGlobalIndex = ScoreGlobalIndexAddedTogether) && (newValue = 0) ; If the values are correct do this shit
         {
            ControlClick, Button1, ahk_pid %ewoWriteWindow% ; For some reason ControlClick can tab you out, so it will only click it if there is an actual to do so.
            global writeWasJustPerformed = 1 ; If this is 1 then TabBackInnn will activate the GTA window; EWO Write sometimes tabs you out due to an issue.
            SetTimer, WriteWasPerformed, -350, -2147483648 ; Runs this once after 350ms, and then deletes the timer. Better than Sleep in this case.
         } else
         {
            If (!currentScoreGlobalIndex = ScoreGlobalIndexAddedTogether) || (!newValue = 0) ; If global index isn't correct, then close GTAHaX and remake the window. Too lazy to remove everything, this is better anyways.
            {
               Process, Close, %ewoWriteWindow%
               Goto, Write
            }
         }
      }
   }
Return

WriteWasPerformed: ; Submodule of the Write module
   global writeWasJustPerformed = 0
Return

TabBackInnn: ; Submodule of the submodule of the Write module
   If (writeWasJustPerformed)
      WinActivate, ahk_exe GTA5.exe
Return

EWOWrite: ; Checks if EWO Write is enabled
   GuiControlGet, EWOWrite
   If (EWOWrite)
   {
      SetTimer, Write, 10, -2147483648
      SetTimer, TabBackInnn, 10, -2147483648
   }
   else
   {
      SetTimer, Write, Off, -2147483648
      SetTimer, TabBackInnn, Off, -2147483648
   }
Return

KekEWO: ; Opens the options menu to EWO, works even if you are stunned or ragdolled
   Send {Blind}{esc}
   Sleep(150)
   Send {Blind}e
   Sleep(500)
   Send {Blind}{enter}
   Sleep(400)
   Send {Blind}{up 4}
   Sleep(250)
   Send {Blind}{enter}
   Sleep(100)
   Send {Blind}{up 6}
   Sleep(100)
   Send {Blind}{enter 20}
return

BST: ; Self explanatory
   SendInput {Blind}{lbutton up}{enter down}
   GuiControlGet, CEOMode
   GuiControlGet, BSTSpeed
   GuiControlGet, BSTMC
   If (!CEOMode)
      MsgBox, 0, Warning!, You are not in a CEO! , 0.75
   else
   {
      Send {Blind}{%InteractionMenuKey%}{enter up}
      If (BSTSpeed)
      {
         Send {Blind}{up}
         SendInput {Blind}{enter down}
         Send {Blind}{up 2}
         SendInput {Blind}{enter up}
      } else
      {
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
   } else
   {
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
   Send {Blind}{f24 up}
   SendInput {Blind}{%InteractionMenuKey% up}
   Sleep(100)
return

FastRespawn: ; Self explanatory
   Loop 30
   {
      SendInput {Blind}{lbutton down}
      Send {Blind}{f24 up}
      SendInput {Blind}{lbutton up}
      Send {Blind}{f24 up}
   }
return

FastRespawnEWO:
   sleepTime := 200
   SendInput {Blind}{ctrl up}{lshift up}{rshift up}
   GuiControlGet, BugRespawnMode
   If (BugRespawnMode = "Sticky")
   {
      SendInput {Blind}{%FranklinBind% down}
      Sleep(400)
      Send {Blind}{g}
      SendInput {Blind}{%FranklinBind% up}
      Sleep sleepTime
      Send {Blind}{backspace}{lbutton up}
   } else
   {
      SendInput {Blind}{lshift down}{w up}{a up}{s up}{d up}
      BlockInput, On
      MouseMove,0,5000,,R
      SendInput {Blind}{%FranklinBind% down}
      Sleep(50)
      SendInput {Blind}{lbutton down}
      If (BugRespawnMode = "Homing")
         Sleep 340
      else if (BugRespawnMode = "RPG")
         Sleep 393
      SendInput {Blind}{%FranklinBind% up}{lshift up}
      BlockInput, Off
      Sleep sleepTime
      Send {Blind}{backspace}{lbutton up}
   }
   If (FastRespawnEWO = "CapsLock")
      SetCapsLockState Off
Return

GTAHax: ; Self explanatory
   Run, GTAHaXUI.exe, %ConfigDirectory%,,Gay
   WinWait, ahk_pid %Gay%
   ControlSend, Edit1, {down}{backspace}%FreemodeGlobalIndexAddedTogether%, ahk_pid %Gay%
   Sleep(100)
   ControlClick, Button1, ahk_pid %Gay%
   Sleep(100)
   ControlSend, Edit2, {down}{backspace}1, ahk_pid %Gay%
   Sleep(100)
   ControlClick, Button1, ahk_pid %Gay%
   Sleep(100)
   ControlSend, Edit1, {down}{backspace 7}%EWOGlobalIndexAddedTogether%, ahk_pid %Gay%
   ControlSend, Edit2, {down}{backspace 2}0, ahk_pid %Gay%
   Sleep(100)
   ControlClick, Button1, ahk_pid %Gay%
   MsgBox, 0, Complete!, You should now have no EWO cooldown. Kill yourself with a Sticky/RPG if you currently have a cooldown.
   Process, Close, %Gay%
return

GTAHaxCEO: ; GTAHaX CEO Circle
   Run, GTAHaXUI.exe, %ConfigDirectory%,,Gay
   WinWait, ahk_pid %Gay%
   ControlSend, Edit1, {down}{backspace}%CEOCircleGlobalIndexAddedTogether%, ahk_pid %Gay%
   Sleep(30)
   ControlClick, Button1, ahk_pid %Gay%
   Sleep(30)
   ;msgbox 0
   Loop, 32 ; Recreates the function that determines what memory address this global should be in, and tests every possible combination of that.
   {
      PlayerID := a_index
      PlayerID1 := PlayerID * 608
      ControlSend, Edit2, {down}{backspace 5}%PlayerID1%, ahk_pid %Gay%
      Sleep(30)
      ControlClick, Button1, ahk_pid %Gay%
      Sleep(30)
      ;msgbox %PlayerID1%
   }
   Sleep(250)
   MsgBox, 0, Complete!, The fucking CEO circle should be back now. It will probably disappear again if you leave CEO or something.
   Process, Close, %Gay%
Return

HelpWhatsThis: ; Self explanatory
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
return

EssayAboutGTA: ; Self explanatory
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
return

ProMassEffectCopypasta:
   PrepareChatMacro()
   
   SendInput I fucking hate Batarians. Disg
   Send {Blind}{f24 up}
   SendInput usting spider-eye freaks. I'll
   Send {Blind}{f24 up}
   SendInput {space}never understand why the Coun
   Send {Blind}{f24 up}
   SendInput cil lets these vermin live. I'
   Send {Blind}{f24 up}
   SendInput d love to kick a
   
   Send {Blind}{enter up}
   PrepareChatMacro()
   
   SendInput Batarian in the head. Just run
   Send {Blind}{f24 up}
   SendInput {space}up to one full speed and catc
   Send {Blind}{f24 up}
   SendInput h his head full force with my
   Send {Blind}{f24 up}
   SendInput steel tipped toe. Punt his hea
   Send {Blind}{f24 up}
   SendInput d like a football.
   
   Send {Blind}{enter up}
   PrepareChatMacro()
   
   SendInput Every single Batarian freak de
   Send {Blind}{f24 up}
   SendInput serves a firing squad, and ext
   Send {Blind}{f24 up}
   SendInput ensive post death mutilation.{space}
   Send {Blind}{f24 up}
   SendInput Khar'shan will burn, and may a
   Send {Blind}{f24 up}
   SendInput {space}Collector Cruiser
   
   Send {Blind}{enter up}
   PrepareChatMacro()
   
   SendInput blow up my ship this very even
   Send {Blind}{f24 up}
   SendInput ing if I'm lying. Anyway, that
   Send {Blind}{f24 up}
   SendInput 's why we should blow up the B
   Send {Blind}{f24 up}
   SendInput ahak system.
   
   Send {Blind}{enter up}
Return

Trippy:
   AltCode = 0135
   PrepareChatMacro()
   SendInput {space}
   Send {Blind}{enter up}
   end = 0
   i := 0
   Loop
   {
      If (!end)
         i := i + 2
      else if (end)
         i := i - 2
      If (i <= 0) && (end)
         break
      else if (i >= 12) ; x*6 = amount of characters which is this number
         end = 1
      PrepareChatMacro()
      CancerFunction("ASC "AltCode,i)
      Send {Blind}{enter up}
   }
   PrepareChatMacro()
   SendInput {space}
   Send {Blind}{enter up}
Return

CustomTextSpam: ; Self explanatory
   GuiControlGet, RawText
   Length := StrLen(CustomSpamText)
   if (Length >= 31)
      Goto LongTextSpam
   else if (Length <= 30)
      Goto ShortTextSpam
return

LongTextSpam:
   Loop, 140 {
      ArrayYes%A_Index% =
   }
   StringSplit, ArrayYes, CustomSpamText
   PrepareChatMacro()
   If (RawText)
   {
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
   } else
   {
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
Return

ShortTextSpam:
   If (WhileChat = 1) && (sendInputWork)
   {
      Goto, WhileShortTextSpam
   }
   PrepareChatMacro()
   If (RawText)
   {
      SendInput {Raw}%CustomSpamText%
      Send {Blind}{enter up}
   } else
   {
      SendInput %CustomSpamText%
      Send {Blind}{enter up}
   }
Return

WhileShortTextSpam:
   while GetKeyState(CustomTextSpam,"P")
   {
      PrepareChatMacro()
      If (RawText)
      {
         SendInput {Raw}%CustomSpamText%
         Send {Blind}{enter up}
      } else
      {
         SendInput %CustomSpamText%
         Send {Blind}{enter up}
      }
   }
Return

Paste: ; Self explanatory
   Send {Blind}v
   SendInput {backspace}
   Send {Blind}{f24 up}
   Length2 = StrLen(Clipboard)
   if (Length2 >= 31)
   {
      Loop, 140
      {
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
   } else
   {
      SendInput {Raw}%Clipboard%
   }
return

ShutUp: ; Self explanatory
   If (WhileChat = 1) && (sendInputWork)
   {
      Goto, WhileShutUp
   }
   PrepareChatMacro()
   SendInput shut up
   Send {Blind}{enter up}
return

WhileShutUp:
   while GetKeyState(ShutUp,"P")
   {
      PrepareChatMacro()
      SendInput shut up
      Send {Blind}{enter up}
   }
Return

Paste2: ; Checks if Paste is enabled
   GuiControlGet, Paste
   If (!Paste)
      Hotkey, ^v, Paste, Off
   else
      Hotkey, ^v, Paste, On
return

ReloadOutfit: ; Self explanatory
   SendInput {Blind}{lbutton up}{enter down}
   GuicontrolGet, CEOMode
   Send {Blind}{%InteractionMenuKey%}
   If (CEOMode)
      Send {Blind}{up 11}
   else
      Send {Blind}{up 13}
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
         
         FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false
         
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

Crosshair6:
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
         
         FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false
         
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
      WinActivate, ahk_class grcWindow
   } else {
      Gui, Crosshair: Hide
   }
   WinActivate, %OldActiveWindow%
return

ProcessCheck3: ; Self explanatory
   GuiControlGet, ProcessCheck2
   if (!ProcessCheck2)
      SetTimer, ProcessCheckTimer, Off, -2147483648
   else
      SetTimer, ProcessCheckTimer, 100, -2147483648
return

TabWeapon2: ; If Fast Switch is enabled
   GuiControlGet, TabWeapon
   If (!TabWeapon)
   {
      Hotkey(SniperBind,"SniperBind","Off")
      Hotkey(RPGBind,"RPGBind","Off")
      Hotkey(StickyBind,"StickyBind","Off")
      Hotkey(PistolBind,"PistolBind","Off")
   } else
   {
      Hotkey(SniperBind,"SniperBind","On")
      Hotkey(RPGBind,"RPGBind","On")
      Hotkey(StickyBind,"StickyBind","On")
      Hotkey(PistolBind,"PistolBind","On")
   }
return

ShowUI:
   GuiControlGet, AlwaysOnTop
   If (AlwaysOnTop)
   {
      WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
      WinMinimize, ahk_exe GTA5.exe
   }
   Gui, Show
return

ToggleCEO:
   SendInput {Blind}{lbutton up}{enter down}
   GuiControlGet, CEOMode
   If (!CEOMode)
   {
      Send {Blind}{%InteractionMenuKey%}{down 6}
      SendInput {Blind}{enter up}
      Send {Blind}{enter}
      GuiControl,1:, CEOMode, 1
   }
   else
   {
      Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
      SendInput {Blind}{enter down}
      Send {Blind}{up up}
      SendInput {Blind}{enter up}
      GuiControl,1:, CEOMode, 0
   }
   Sleep(125)
return

ProcessCheckTimer:
   If (!GTAAlreadyClosed)
   {
      GuiControlGet, ProcessCheck2
      If (ProcessCheck2)
      {
         If !WinExist("ahk_exe GTA5.exe")
         {
            Gosub, CloseGTAProcesses
            SetTimer, Write, Off, -2147483648
            SetTimer, CloseGTAHaX, 100, -2147483648
            SetTimer, ExitMacros, -10000, -2147483648
            MsgBox, 0, Macros will close now. RIP., GTA is no longer running. Macros will close now. RIP.
            Process, Close, %Gay%
            Process, Close, %ewoWriteWindow%
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
   Send {Blind}{%SniperBind% down}{tab}
   SendInput {Blind}{%SniperBind% up}
return

RPGBind:
   Send {Blind}{%RPGBind% down}{tab}
   SendInput {Blind}{%RPGBind% up}
return

StickyBind:
   Send {Blind}{%StickyBind% down}{tab}
   SendInput {Blind}{%StickyBind% up}
Return

PistolBind:
   Send {Blind}{%PistolBind% down}{tab}
   SendInput {Blind}{%PistolBind% up}
return

RPGSpam:
   Send {%StickyBind% down}{%RPGBind% down}{tab}
   SendInput {%RPGBind% up}{%StickyBind% up}
return

ToggleCrosshair:
   GuiControlGet, Crosshair
   If (Crosshair)
      GuiControl,1:, Crosshair, 0
   else
      GuiControl,1:, Crosshair, 1
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
   Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
   SendInput {Blind}{enter down}
   Send {Blind}{up up}
   SendInput {Blind}{enter up}
   Sleep(200)
   SendInput {Blind}{enter down}
   Send {Blind}{%InteractionMenuKey%}{down 6}
   If (!MCCEO2)
      Send {Blind}{down}
   SendInput {Blind}{enter up}
   Send {Blind}{enter}
   RestartTimer()
   Loop
   {
      timeElapsed := CalculateTime()
      If (timeElapsed > 1250)
         break
      Send {Blind}{backspace down}
      SendInput {Blind}{enter down}
      Send {Blind}{backspace up}
      SendInput {Blind}{enter up}
      Send {Blind}{enter}
   }
   Sleep(25)
   GuiControl,1:, CEOMode, 1
   If (!MCCEO2)
      MCCEO2 := 1
   else
      MCCEO2 := 0
return

LaunchCycle:
   GuiControlGet, Paste ; Checks if pasting chat messages is enabled, and then it will enable it.
   If (!Paste)
      Hotkey, ^v, Paste, Off
   else
      Hotkey, ^v, Paste, On
   GuiControlGet, TabWeapon
   If (!TabWeapon)
   {
      Hotkey(SniperBind,"SniperBind","Off")
      Hotkey(RPGBind,"RPGBind","Off")
      Hotkey(StickyBind,"StickyBind","Off")
      Hotkey(PistolBind,"PistolBind","Off")
   } else
   {
      Hotkey(SniperBind,"SniperBind","On")
      Hotkey(RPGBind,"RPGBind","On")
      Hotkey(StickyBind,"StickyBind","On")
      Hotkey(PistolBind,"PistolBind","On")
   }
   GuiControlGet, Paste
   If (!Paste)
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
            
            FileInstall, assets\crosshair.png, %A_WorkingDir%\assets\crosshair.png, false
            
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
   if (!AlwaysOnTop)
   {
      SetTimer, AlwaysOnTop, Delete, -2147483648
   } else
   {
      SetTimer, AlwaysOnTop, 100, -2147483648
   }
return

DisableAll:
   Hotkey(ThermalHelmet,"ThermalHelmet","Off")
   Hotkey(jetThermal,"JetThermal","Off")
   Hotkey(FastSniperSwitch,"FastSniperSwitch","Off")
   Hotkey(EWO,"EWO","Off")
   Hotkey(KekEWO,"KekEWO","Off")
   Hotkey(BST,"BST","Off")
   Hotkey(Ammo,"Ammo","Off")
   Hotkey(FastRespawn,"FastRespawn","Off")
   Hotkey(FastRespawnEWO,"FastRespawnEWO","Off")
   Hotkey(ToggleCrosshair,"ToggleCrosshair","Off")
   Hotkey(Suspend,"Suspend","Off")
   Hotkey(HelpWhatsThis,"HelpWhatsThis","Off")
   Hotkey(EssayAboutGTA,"EssayAboutGTA","Off")
   Hotkey(CustomTextSpam,"CustomTextSpam","Off")
   Hotkey(ShutUp,"ShutUp","Off")
   Hotkey(ReloadOutfit,"ReloadOutfit","Off")
   Hotkey(ShowUI,"ShowUI","Off")
   Hotkey(ToggleCEO,"ToggleCEO","Off")
   Hotkey(Jobs,"Jobs","Off")
   Hotkey(MCCEO,"MCCEO","Off")
   Hotkey(RPGSpam,"RPGSpam","Off")
   Hotkey(PassiveDisableSpamToggle,"PassiveDisableSpamToggle","Off")
Return

NotExist1:
   IfNotExist, %CFG%
   {
      GuiControl,1:,InteractionMenuKey,m
      GuiControl,1:,FranklinBind,F6
      GuiControl,1:,ThermalHelmet,
      GuiControl,1:,jetThermal,
      GuiControl,1:,FastSniperSwitch,
      GuiControl,1:,SniperBind,9
      GuiControl,1:,RifleBind,8
      GuiControl,1:,EWO,
      GuiControl,1:,EWOWrite,0
      GuiControl,1:,EWOLookBehindKey,c
      GuiControl,1:,EWOSpecialAbilitySlashActionKey,CapsLock
      GuiControl,1:,EWOMelee,r
      GuiControl,1:,BST,
      GuiControl,1:,BSTSpeed,0
      GuiControl,1:,Ammo,
      GuiControl,1:,FastRespawn,
      GuiControl,1:,Suspend,
      GuiControl,1:,HelpWhatsThis,
      GuiControl,1:,EssayAboutGTA,
      GuiControl,1:,CustomTextSpam,
      GuiControl,1:,ShutUp,
      GuiControl,1:,CustomSpamText,Ryzen_7_5800X3D is hot
      GuiControl,1:,ReloadOutfit,
      GuiControl,1:,ShowUI,
      GuiControl,1:,ToggleCEO,
      GuiControl,1:,ToggleCrosshair,
      GuiControl,1:,SleepTime,200
      GuiControl,1:,BuyCycles,4
      GuiControl,1:,Reverse,0
      GuiControl,1:,SpecialBuy,0
      GuiControl,1:,ProcessCheck2,0
      GuiControl,1:,NightVision,0
      GuiControl,1:,RPGSpam,
      GuiControl,1:,RPGBind,4
      GuiControl,1:,StickyBind,5
      GuiControl,1:,PistolBind,6
      GuiControl,1:,TabWeapon,0
      GuiControl,1:,Crosshair,0
      GuiControl,1:,Jobs,
      GuiControl,1:,Paste,0
      GuiControl,1:,MCCEO,
      GuiControl,1:,SmoothEWO,0
      GuiControl,1:,shootEWO,0
      GuiControl,1:,customTime,30
      GuiControl,1:,FasterSniper,1
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
   Gui, Add, Link,, Jet Thermal: <a href="">(?)</a>
   Gui, Add, Link,, Sniper Switch: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Sniper-Switch">(?)</a>
   Gui, Add, Link,, EWO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/EWO">(?)</a>
   Gui, Add, Link,, BST: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/BST">(?)</a>
   Gui, Add, Link,, Ammo: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Ammo">(?)</a>
   Gui, Add, Link,, Fast Respawn: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Fast-Respawn">(?)</a>
   Gui, Add, Link,, Fast Respawn EWO:
   Gui, Add, Link,, Toggle Crosshair: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-Crosshair">(?)</a>
   Gui, Add, Link,, RPG Spam: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/RPG-Spam">(?)</a>
   Gui, Add, Link,, Fast Switch <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Fast-Switch">(?)</a>
   
   Gui, Add, Hotkey,vThermalHelmet x+40 y60,
   Gui, Add, Hotkey,vjetThermal,
   Gui, Add, Hotkey,vFastSniperSwitch,
   Gui, Add, Hotkey,vEWO,
   Gui, Add, Hotkey,vBST,
   Gui, Add, Hotkey,vAmmo,
   Gui, Add, Hotkey,vFastRespawn,
   Gui, Add, Hotkey,vFastRespawnEWO,
   Gui, Add, Hotkey,vToggleCrosshair,
   Gui, Add, Hotkey,vRPGSpam,
   Gui, Add, Checkbox, gTabWeapon2 vTabWeapon,
Return

ChatMacros:
   Gui, Tab, 2
   Gui, Add, Link,x+5 y60, Pro Mass Effect Copypasta: <a href="">(?)</a>
   Gui, Add, Link,, Trippy Chat Macro: <a href="">(?)</a>
   Gui, Add, Link,, Epic Roast: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Epic-Roast">(?)</a>
   Gui, Add, Link,, Essay About GTA: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Essay-About-GTA">(?)</a>
   Gui, Add, Link,, Custom Text Spam: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Text-Spam">(?)</a>
   Gui, Add, Link,, Custom Spam Text <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Spam-Text">(?)</a>
   Gui, Add, Link,, Raw Text? <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Custom-Spam-Text">(?)</a>
   Gui, Add, Link,, Shut Up: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Shut-Up">(?)</a>
   Gui, Add, Link,, Suspend: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Suspend">(?)</a>
   
   Gui, Add, Hotkey,vProMassEffectCopypasta x+100 y60,
   Gui, Add, Hotkey,vTrippy,
   Gui, Add, Hotkey,vHelpWhatsThis,
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
   
   Gui, Add, Hotkey,vInteractionMenuKey x+15 y60,
   Gui, Add, Hotkey,vSniperBind,
   Gui, Add, Hotkey,vEWOLookBehindKey,
   Gui, Add, Hotkey,vEWOSpecialAbilitySlashActionKey,
   Gui, Add, Hotkey,vEWOMelee,
   Gui, Add, Hotkey,vRPGBind,
   Gui, Add, Hotkey,vStickyBind,
   Gui, Add, Hotkey,vPistolBind,
   Gui, Add, Hotkey,vRifleBind,
   Gui, Add, Hotkey,vFranklinBind,
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
   Gui, Add, Link,, Shoot EWO? <a href="">(?)</a>
   Gui, Add, Link,, Custom EWO Sleep Time: <a href="">(?)</a>
   Gui, Add, Link,, Slower EWO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a>
   Gui, Add, Link,, CEO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/CEO-Mode">(?)</a>
   Gui, Add, Link,, Optimize Fast Respawn EWO for: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Optimize-Fast-Respawn-EWO-For">(?)</a>
   Gui, Add, Link,, Show EWO Score: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score">(?)</a>
   Gui, Add, Link,, Sing: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score">(?)</a>
   If (DebugTesting)
   {
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
   Gui, Add, Checkbox, vshootEWO h20,
   Gui, Add, Edit, vcustomTime h20,
   Gui, Add, DropDownList, vSmoothEWOMode, Sticky|Retarded|Retarded2|Retarded3|Staeni|Faster|Fastest|Fasterest|Custom
   Gui, Add, CheckBox, vCEOMode h20,
   Gui, Add, DropDownList, vBugRespawnMode, Sticky|Homing|RPG
   Gui, Add, Checkbox, gEWOWrite vEWOWrite h20
   Gui, Add, Checkbox, gToggleSing vsingEnabled h20
   If (DebugTesting)
   {
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
   If (DebugTesting)
      Gui, Add, Link,, Passive Disable Spam Toggle: <a href="">(?)</a>
   
   Gui, Add, Hotkey,vKekEWO x+20 y60
   Gui, Add, Hotkey,vShowUI,
   Gui, Add, Hotkey,vToggleCEO,
   Gui, Add, Hotkey,vReloadOutfit,
   Gui, Add, Hotkey,vJobs
   Gui, Add, Checkbox, gPaste2 vPaste h20
   Gui, Add, Hotkey,vMCCEO
   If (DebugTesting)
      Gui, Add, Hotkey,vPassiveDisableSpamToggle
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
   If (DebugTesting)
   {
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
   Gui, Add, Text,x+111, ; Makes the window size correct
Return

Apply:
   Global save = 0
   Goto SaveConfigRedirect

SaveConfig:
   Global save = 1
   Goto SaveConfigRedirect

SaveConfigRedirect:
   GuiControlGet, ProcessCheck2
   SetTimer, Write, Off, -2147483648
   SetTimer, TabBackInnn, Off, -2147483648
   SetTimer, ProcessCheckTimer, Off, -2147483648
   Gosub,DisableAll
   Gui,Submit,NoHide
   If (save)
   {
      IniWrite,%InteractionMenuKey%,%CFG%,Keybinds,Interaction Menu Key
      IniWrite,%FranklinBind%,%CFG%,Keybinds,Franklin Key
      IniWrite,%ThermalHelmet%,%CFG%,PVP Macros,Thermal Helmet
      IniWrite,%jetThermal%,%CFG%,PVP Macros,Jet Thermal
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
      IniWrite,%FastRespawnEWO%,%CFG%,Misc,Fast Respawn EWO
      IniWrite,%Suspend%,%CFG%,Misc,Suspend Macro
      IniWrite,%HelpWhatsThis%,%CFG%,Chat Macros,idkwtfthisis
      IniWrite,%EssayAboutGTA%,%CFG%,Chat Macros,Essay About GTA
      IniWrite,%ProMassEffectCopypasta%,%CFG%,Chat Macros,Pro Mass Effect Copypasta
      IniWrite,%Trippy%,%CFG%,Chat Macros,Trippy
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
      IniWrite,%shootEWO%,%CFG%,Misc,Shoot EWO
      IniWrite,%customTime%,%CFG%,Misc,Custom EWO Time
      IniWrite,%SmoothEWOMode%,%CFG%,Misc,Smooth EWO Mode
      IniWrite,%BugRespawnMode%,%CFG%,Misc,Bug Respawn Mode
      IniWrite,%FasterSniper%,%CFG%,Misc,Faster Sniper
      IniWrite,%PassiveDisableSpamToggle%,%CFG%,Misc,Passive Disable Spam Toggle
      IniWrite,%AlwaysOnTop%,%CFG%,Misc,Always On Top
   }
   
   Gosub, LaunchCycle
   Hotkey(ThermalHelmet,"ThermalHelmet","On")
   Hotkey(jetThermal,"JetThermal","On")
   Hotkey(FastSniperSwitch,"FastSniperSwitch","On")
   Hotkey(EWO,"EWO","On")
   Hotkey(KekEWO,"KekEWO","On")
   Hotkey(BST,"BST","On")
   Hotkey(Ammo,"Ammo","On")
   Hotkey(FastRespawn,"FastRespawn","On")
   Hotkey(FastRespawnEWO,"FastRespawnEWO","On")
   Hotkey(ToggleCrosshair,"ToggleCrosshair","On")
   Hotkey(Suspend,"Suspend","On")
   Hotkey(HelpWhatsThis,"HelpWhatsThis","On")
   Hotkey(EssayAboutGTA,"EssayAboutGTA","On")
   Hotkey(ProMassEffectCopypasta,"ProMassEffectCopypasta","On")
   Hotkey(Trippy,"Trippy","On")
   Hotkey(CustomTextSpam, "CustomTextSpam","On")
   Hotkey(ShutUp,"ShutUp","On")
   Hotkey(ReloadOutfit, "ReloadOutfit","On")
   Hotkey(ShowUI,"ShowUI","On")
   Hotkey(ToggleCEO,"ToggleCEO","On")
   Hotkey(Jobs,"Jobs","On")
   Hotkey(MCCEO,"MCCEO","On")
   Hotkey(RPGSpam,"RPGSpam","On")
   Hotkey(PassiveDisableSpamToggle,"PassiveDisableSpamToggle","On")
   If (EWOWrite)
   {
      SetTimer, Write, 10, -2147483648
      SetTimer, TabBackInnn, 10, -2147483648
   }
   if (ProcessCheck2)
      SetTimer, ProcessCheckTimer, 100, -2147483648
   ;MsgBox, 0, Saved!, Your config has been saved and/or the macros have been started!, 2
   If (GTAAlreadyClosed = 0 && save)
      TrayTip, %MacroText%, Your config has been saved and/or the macros have been started!, 10, 1
   else if (!save)
      TrayTip, %MacroText%, Your config has been applied and/or the macros have been started! Settings have not been saved., 10, 1
   else if (GTAAlreadyClosed) && (ProcessCheck2)
      TrayTip, %MacroText%, GTA has not been detected to be open`, the macros will not automatically close and Show EWO Score will not work`. Please restart the macros once you have restarted GTA., 10, 1
   #Include *i %A_MyDocuments%\Ryzen's Macros\DynamicScript.ahk
Return

CloseGTAHaX:
   Process, Close, %Gay%
   Process, Close, %ewoWriteWindow%
   Process, Close, %Gay3%
   Process, Close, %Obese11%
Return

StandardTrayMenu:
   If (!isCompiled)
   {
      If (A_ThisMenuItem = "Open")
         DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65406, UInt,0 )
   }
   If (A_ThisMenuItem = "Help")
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65411, UInt,0 )
   
   If (A_ThisMenuItem = "Window Spy" )
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65402, UInt,0 )
   
   If (A_ThisMenuItem = "Reload This Script" )
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65400, UInt,0 )
   
   If (A_ThisMenuItem = "Suspend Hotkeys" )
   {
      Menu, Tray, ToggleCheck, %A_ThisMenuItem%
      DllCall("PostMessage", UInt,Gui0, UInt,0x111, UInt,65404, UInt,0 )
   }
   
   If (A_ThisMenuItem = "Pause Script" )
   {
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
      IniRead,Read_jetThermal,%CFG%,PVP Macros,Jet Thermal
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
      IniRead,Read_FastRespawnEWO,%CFG%,Misc,Fast Respawn EWO
      IniRead,Read_Suspend,%CFG%,Misc,Suspend Macro
      IniRead,Read_HelpWhatsThis,%CFG%,Chat Macros,idkwtfthisis
      IniRead,Read_EssayAboutGTA,%CFG%,Chat Macros,Essay About GTA
      IniRead,Read_ProMassEffectCopypasta,%CFG%,Chat Macros,Pro Mass Effect Copypasta
      IniRead,Read_Trippy,%CFG%,Chat Macros,Trippy
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
      IniRead,Read_shootEWO,%CFG%,Misc,Shoot EWO
      IniRead,Read_customTime,%CFG%,Misc,Custom EWO Time
      IniRead,Read_SmoothEWOMode,%CFG%,Misc,Smooth EWO Mode
      IniRead,Read_BugRespawnMode,%CFG%,Misc,Bug Respawn Mode
      IniRead,Read_FasterSniper,%CFG%,Misc,Faster Sniper
      IniRead,Read_PassiveDisableSpamToggle,%CFG%,Misc,Passive Disable Spam Toggle
      IniRead,Read_AlwaysOnTop,%CFG%,Misc,Always On Top
      
      GuiControl,1:,InteractionMenuKey,%Read_InteractionMenuKey%
      GuiControl,1:,FranklinBind,%Read_FranklinBind%
      GuiControl,1:,ThermalHelmet,%Read_ThermalHelmet%
      GuiControl,1:,jetThermal,%Read_jetThermal%
      GuiControl,1:,FastSniperSwitch,%Read_FastSniperSwitch%
      GuiControl,1:,SniperBind,%Read_SniperBind%
      GuiControl,1:,RifleBind,%Read_RifleBind%
      GuiControl,1:,EWO,%Read_EWO%
      GuiControl,1:,EWOWrite,%Read_EWOWrite%
      GuiControl,1:,KekEWO,%Read_KekEWO%
      GuiControl,1:,EWOLookBehindKey,%Read_EWOLookBehindKey%
      GuiControl,1:,EWOSpecialAbilitySlashActionKey,%Read_EWOSpecialAbilitySlashActionKey%
      GuiControl,1:,EWOMelee,%Read_EWOMelee%
      GuiControl,1:,BST,%Read_BST%
      GuiControl,1:,BSTSpeed,%Read_BSTSpeed%
      GuiControl,1:,Ammo,%Read_Ammo%
      GuiControl,1:,SpecialBuy,%Read_SpecialBuy%
      GuiControl,1:,BuyAll,%Read_BuyAll%
      GuiControl,1:,FastRespawn,%Read_FastRespawn%
      GuiControl,1:,FastRespawnEWO,%Read_FastRespawnEWO%
      GuiControl,1:,Suspend,%Read_Suspend%
      GuiControl,1:,HelpWhatsThis,%Read_HelpWhatsThis%
      GuiControl,1:,EssayAboutGTA,%Read_EssayAboutGTA%
      GuiControl,1:,ProMassEffectCopypasta,%Read_ProMassEffectCopypasta%
      GuiControl,1:,Trippy,%Read_Trippy%
      GuiControl,1:,CustomTextSpam,%Read_CustomTextSpam%
      GuiControl,1:,ShutUp,%Read_ShutUp%
      GuiControl,1:,CustomSpamText,%Read_CustomSpamText%
      GuiControl,1:,RawText,%Read_RawText%
      GuiControl,1:,ReloadOutfit,%Read_ReloadOutfit%
      GuiControl,1:,ShowUI,%Read_ShowUI%
      GuiControl,1:,ToggleCEO,%Read_ToggleCEO%
      GuiControl,1:,ToggleCrosshair,%Read_ToggleCrosshair%
      GuiControl,1:,SleepTime,%Read_SleepTime%
      GuiControl,1:,BuyCycles,%Read_BuyCycles%
      GuiControl,1:,Reverse,%Read_Reverse%
      GuiControl,1:,ProcessCheck2,%Read_ProcessCheck2%
      GuiControl,1:,NightVision,%Read_NightVision%
      GuiControl,1:,RPGSpam,%Read_RPGSpam%
      GuiControl,1:,RPGBind,%Read_RPGBind%
      GuiControl,1:,StickyBind,%Read_StickyBind%
      GuiControl,1:,PistolBind,%Read_PistolBind%
      GuiControl,1:,TabWeapon,%Read_TabWeapon%
      GuiControl,1:,Crosshair,%Read_Crosshair%
      GuiControl,1:,CrosshairPos,%Read_CrosshairPos%
      GuiControl,1:,Jobs,%Read_Jobs%
      GuiControl,1:,Paste,%Read_Paste%
      GuiControl,1:,MCCEO,%Read_MCCEO%
      GuiControl,1:,SmoothEWO,%Read_SmoothEWO%
      GuiControl,1:,shootEWO,%Read_shootEWO%
      GuiControl,1:,customTime,%Read_customTime%
      GuiControl,Choose,SmoothEWOMode,%Read_SmoothEWOMode%
      GuiControl,Choose,BugRespawnMode,%Read_BugRespawnMode%
      GuiControl,1:,FasterSniper,%Read_FasterSniper%
      GuiControl,1:,PassiveDisableSpamToggle,%Read_PassiveDisableSpamToggle%
      GuiControl,1:,AlwaysOnTop,%Read_AlwaysOnTop%
   }
Return

CheckHWID:
   UrlDownloadToFile, https://pastebin.com/raw/dpBPUkBM, %A_Temp%\Keys.ini
   while not FileExist(A_Temp "\Keys.ini") ; This cheeky little piece of code makes it wait until the file exists.
      {}
      Loop 60
         IniRead, Key%A_Index%, %A_Temp%\Keys.ini, Registration, Key%A_Index%
   IniRead, latestMacroVersion, %A_Temp%\Keys.ini, Versions, LatestMacroVersion
   if VerCompare(MacroVersion, "<"latestMacroVersion)
   {
      MsgBox,0,Your version is old., Please upgrade to the latest version. This is a threat.
      ExitApp
   }
   
   FileDelete, %A_Temp%\Keys.ini
   
   key := % UUID()
   valid_ids := Object((Key1), y,(Key2), y,(Key3), y,(Key4), y,(Key5), y,(Key6), y,(Key7), y,(Key8), y,(Key9), y,(Key10), y,(Key11), y,(Key12), y,(Key13), y,(Key14), y,(Key15), y,(Key16), y,(Key17), y,(Key18), y,(Key19), y,(Key20), y,(Key21), y,(Key22), y,(Key23), y,(Key24), y,(Key25), y,(Key26), y,(Key27), y,(Key28), y,(Key29), y,(Key30), y,(Key31), y,(Key32), y,(Key33), y,(Key34), y,(Key35), y,(Key36), y,(Key37), y,(Key38), y,(Key39), y,(Key40), y,(Key41), y,(Key42), y,(Key43), y,(Key44), y,(Key45), y,(Key46), y,(Key47), y,(Key48), y,(Key49), y,(Key50), y,(Key51), y,(Key52), y,(Key53), y,(Key54), y,(Key55), y,(Key56), y,(Key57), y,(Key58), y,(Key59), y,(Key60), y)
   if (!valid_ids.HasKey(key))
   {
      c0=D4D0C8
      Clipboard := key
      Gui,2:Add, Link,w400, Your HWID has been copied to the clipboard. Please join the Discord Server and send it in the #macro-hwid channel. To gain access to the channel, you must react in the #macros channel.
      Gui,2:Add, Link,, <a href="https://discord.gg/5Y3zJK4KGW">Here</a> is an invite to the discord server.
      Gui,2:Add, Button,ym+80 gExitMacros2, OK
      Gui,2:Show,, HWID Mismatch
      Return
   } else
      Goto, Back
Return

ExitMacros2:
ExitApp

Suspend:
Suspend
Return

PassiveDisableSpamCheck:
   GuiControlGet, PassiveDisableSpam
   if (!PassiveDisableSpam)
   {
      SetTimer, PassiveDisableSpam, Delete, -2147483648
   } else
   {
      SetTimer, PassiveDisableSpam, 7500, -2147483648
   }
Return

PassiveDisableSpamToggle:
   GuiControlGet, PassiveDisableSpam
   if (PassiveDisableSpam)
   {
      SetTimer, PassiveDisableSpam, Delete, -2147483648
      GuiControl,1:, PassiveDisableSpam, 0
      MsgBox, 0, %MacroText%, Passive Disable Spam disabled , 0.75
   } else
   {
      SetTimer, PassiveDisableSpam, 7500, -2147483648
      GuiControl,1:, PassiveDisableSpam, 1
      TrayTip, %MacroText%, Passive Disable Spam enabled, 10, 1
      MsgBox, 0, %MacroText%, Passive Disable Spam enabled , 0.75
   }
Return

PassiveDisableSpam:
   GuiControlGet, PassiveDisableSpam
   If (PassiveDisableSpam)
   {
      If WinActive("ahk_exe GTA5.exe")
      {
         If GetKeyState("LButton","P")
         {
            SendInput {Blind}{up down}{enter down}{lbutton up}
            Send {Blind}{backspace}{%InteractionMenuKey%}{enter up}{%InteractionMenuKey%}
            SendInput {Blind}{up up}{lbutton down}
         } else
         {
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
   if (!AlwaysOnTop)
      SetTimer, AlwaysOnTop, Delete, -2147483648
   else
      SetTimer, AlwaysOnTop, 25, -2147483648

Return

AlwaysOnTop:
   GuiControlGet, AlwaysOnTop
   If (AlwaysOnTop)
   {
      If WinActive("ahk_exe GTA5.exe")
      {
         WinSet, AlwaysOnTop, On, ahk_exe GTA5.exe
      } else
      {
         WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
         WinMinimize, ahk_exe GTA5.exe
      }
   }
Return

SendInputTestV2()
{
   BlockInput, On
   WinActivate, ahk_exe GTA5.exe
   Sleep(250)
   startTime := A_TickCount
   Send t{shift up}
   SendInput Loading{. 30}
   calculatedTime := A_TickCount - startTime
   Sleep(500)
   Send {Blind}{esc}
   Sleep(500)
   BlockInput, Off
   Return calculatedTime
}

Clumsy:
   if (!clumsyEnabled)
   {
      Process, Close, %Gay3%
      Run, clumsy.exe, %ConfigDirectory%\clumsy,Min,Gay3
      WinWait, ahk_pid %Gay3%
      WinGet, ID3, ID, ahk_pid %Gay3%
      WinSet, ExStyle, ^0x80, ahk_id %ID3% ; 0x80 is WS_EX_TOOLWINDOW
      Control, Choose, 4, ComboBox1, ahk_pid %Gay3%
      Control, Check,, Button4, ahk_pid %Gay3%
      ControlSetText,Edit2,%clumsyPing%,ahk_pid %Gay3%
      Sleep(100)
      ControlClick, Button2, ahk_pid %Gay3%
      global clumsyStarted = 1
      global clumsyEnabled = 1
      global Notified = 0
      SetTimer, ClumsyClosed, 350, -2147483648
      msgbox, clumsy enabled
   } else
   {
      Process, Close, %Gay3%
      SetTimer, ClumsyClosed, Delete, -2147483648
      global clumsyEnabled = 0
      msgbox, clumsy disabled
   }
Return

ClumsyClosed:
   If (clumsyStarted) && (!Notified) && !ProcessExist(ahk_pid Gay3)
   {
      msgbox, for some reason it closed`, idk why
      global Notified = 1
      SetTimer, ClumsyClosed, Delete, -2147483648
   }
Return

ProcessExist(Name) ; For convenience sake
{
   Process, Exist, %Name%
   Return ErrorLevel
}

CreateTrayOptions:
   Menu, Tray, NoStandard ; Default trays but with some extra things above it, usually not possible so you need to do some complicated things to make it work.
   Menu, Tray, Add, Show UI, ShowUI
   Menu, Tray, Add, Hide UI, HideWindow
   Menu, Tray, Add, Save Macros, SaveConfig
   Menu, Tray, Add
   If (!isCompiled)
      Menu, Tray, Add, Open, StandardTrayMenu
   Menu, Tray, Add, Help, StandardTrayMenu
   Menu, Tray, Add
   Menu, Tray, Add, Window Spy, StandardTrayMenu
   Menu, Tray, Add, Reload This Script, Reload
   Menu, Tray, Add
   Menu, Tray, Add, Suspend Hotkeys, StandardTrayMenu
   Menu, Tray, Add, Pause Script, StandardTrayMenu
   Menu, Tray, Add, Exit, ExitMacros
   If (!isCompiled)
      Menu, Tray, Default, Open
   Menu, Tray, Tip, %MacroText%
Return

ToggleSing: ; Toggles the sing
   GuiControlGet, singEnabled
   if (singEnabled) ; If sing is on
   {
      global selecting = 1
      Gui,List:Add, ListView, r20 w700 gSing, Name|Size (KB)
      Gui,List:Default
      
      Loop, %ConfigDirectory%\*.*
      {
         If (A_LoopFileExt	= "txt")
            LV_Add("", A_LoopFileName, A_LoopFileSizeKB)
      }
      LV_ModifyCol()
      LV_ModifyCol(2, "Integer")
      
      Gui,List:Show,, Select a text file to sing
      return
      
      ListGuiClose:
         global singEnabledVariable = 0
         GuiControl,1:,singEnabled,0
         Gui,List:Destroy
      Return
   }
   else
   {
      global singEnabledVariable = 0 ; Indicates that sing is disabled if you disable it while it is running.
   }
   Return
   
   Sing: ; Sings in chat lmao
      if (A_GuiEvent = "DoubleClick")
      {
         LV_GetText(RowText, A_EventInfo)
         global songFileLocation := ConfigDirectory "\" RowText
         global singEnabledVariable = 1 ; Indicates that sing is enabled.
         Gui,List:Destroy
      }
      global paused = 0
      global keepRunning = 1 ; Set to 1 at the start unless you use the Safeguard Hotkey.
      global noWaitExistsTimeout := 3000 ; If there is no wait() in the lyrics file and no wait specified in the file, then it will Sleep this amount per message automatically.
      global i := 1
      noAutoWait = 0 ; Resets it when you restart. Probably not necessary but maybe.
      waitExistsInLyrics = 0 ; Resets it when you restart
      WinActivate, ahk_exe GTA5.exe ; Activates the GTA window
      
      ; Loop, Read, %songFileLocation% ; The part where the magic happens!
      Loop
      {
         if (keepRunning) && (singEnabledVariable) ; This will only be disabled if you press the safeguard key. Timers override basically any thread priority, so this is better than a hotkey. If you do not specify a value that in the if statement, it will be if it is 1.
         {
            If (paused) ; This cheeky bit of code will simply cause the loop to get stuck until the pause variable is no longer True. Pretty bad coding practice probably, but in this case it is probably the only way without disabling Timers.
            {
               While (paused)
                  {}
                  i--
            }
            i++
            FileReadLine, currentLine, %songFileLocation%, i
            if ErrorLevel ; If it fails to read then stop the loop
               break
            currentLine := StrReplace(currentLine,"fucking", "fkn")
            currentLine := StrReplace(currentLine," shit"," shlt")
            currentLine := StrReplace(currentLine,"fuck", "fk")
            
            If (currentLine = "") ; If the line is empty, skip it and go to the next loop.
            {
               Continue ; Goes back to the top of the loop and continues with the next line
            }
            else if InStr(currentLine,"//") ; If it begins with // (a comment) then skip it.
            {
               foundPos := InStr(currentLine,"//") ; The character "position" of //. Will only do something if it is in the front. I'm too dumb to make it parse the entire thing. Fuck regex.
               if (foundPos = 1) || (foundPos = 2) ; Incase you have a space before // for some reason, then the "position" will be 2.
                  Continue ; Goes back to the top of the loop and continues with the next line
            }
            else if InStr(currentLine,"NoAutoWait()") ; If the line starts with "NoAutoWait" then it will NOT wait.
            {
               noAutoWait = 1
            }
            else if InStr(currentLine,"ExceptionWait(") ; If the line starts with "ExceptionWait(" then it will wait WITHOUT notifying the script of the fact that Wait() exists within the text file.
            {
               waitTime := StrSplit(currentLine,"(",")",2) ; Splits the array into wait( and the rest of the string. It will omit the ")" so only the number remains. This number is then used to sleep.
               waitTime := waitTime[2] ; Makes waitTime equal to the second value in the array to make it slightly simpler.
               Sleep %waitTime% ; It then waits the amount of time specified in the lyrics file.
            }
            else if InStr(currentLine,"Wait(") || InStr(currentLine,"wait(") ; If the line starts with "wait(" then it will wait and notify the script of the fact that Wait() exists within the text file.
            {
               waitExistsInLyrics = 1 ; Variable that lets me know that wait exists somewhere in the lyrics, and it will not count commented waits, thanks to this being below the other ifs in an else statement.
               waitTime := StrSplit(currentLine,"(",")",2) ; Splits the array into wait( and the rest of the string. It will omit the ")" so only the number remains. This number is then used to sleep.
               waitTime := waitTime[2] ; Makes waitTime equal to the second value in the array to make it slightly simpler.
               Sleep %waitTime% ; It then waits the amount of time specified in the lyrics file.
            }
            else if InStr(currentLine,"SafeguardKey(") ; If the line starts with "SafeguardKey(" then it will use the key as the key to cancel singing.
            {
               global safeguardKey := StrSplit(currentLine,"(","y" ")",2) ; Uses delimiters again
               global safeguardKey := safeguardKey[2] ; Makes it slightly simpler
               SetTimer, UltraHighPriorityLoopBypassingThread,1,2147483647 ; Find out more at the bottom of the script
            }
            else if InStr(currentLine,"PauseKey(") ; If the line starts with "PauseKey(" then it will use the key as the key to pause singing.
            {
               global pauseKey := StrSplit(currentLine,"(","y" ")",2) ; Uses delimiters again
               global pauseKey := pauseKey[2] ; Makes it slightly simpler
               SetTimer, UltraHighPriorityLoopBypassingThread,1,2147483647 ; Find out more at the bottom of the script
            }
            else if InStr(currentLine,"StandardWaitTime(") ; Will change noWaitExistsTimeout variable to the new value. This will change how long it automatically waits between lines.
            {
               global noWaitExistsTimeout := StrSplit(currentLine,"(","e" ")",2) ; Uses delimiters again
               global noWaitExistsTimeout := noWaitExistsTimeout[2] ; Makes it slightly simpler
            }
            else
            {
               Gosub, IJustCopyPastedThisChatFunction ; If it is (most likely) part of a valid lyrics that you will actually want to be sent, then send the messages.
               If (!waitExistsInLyrics) && (!noAutoWait) ; Waits 2000ms (2 seconds) if there is no wait() specified anywhere in the file and if NoAutoWait is not enabled for the current line.
                  Sleep %noWaitExistsTimeout%
               noAutoWait = 0 ; Resets NoAutoWait after it has sent something, so it doesn't stop waiting forever.
            }
         }
         else ; If the Safeguard Key has been pressed, stop the loop.
            break
      }
      VarSetCapacity(i,0)
      GuiControl,1:,singEnabled,0 ; Once it is done, disable Sing.
      global singEnabledVariable = 0
      global paused = 0
      global keepRunning = 1 ; Set to 1 at the start unless you use the Safeguard Hotkey.
      SetTimer, UltraHighPriorityLoopBypassingThread,Off,2147483647 ; Disables the timer after it is done
   Return
   
   IJustCopyPastedThisChatFunction: ; Pasted from CustomTextSpam.
      Length := StrLen(currentLine)
      if (Length >= 31)
      {
         Loop, 140 {
            ArrayYes%A_Index% =
         }
         PrepareChatMacro()
         StringSplit, ArrayYes, currentLine
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
      else if (Length <= 30)
      {
         PrepareChatMacro()
         SendInput {Raw}%currentLine%
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
         MsgBox, 0, %MacroText%, Sing disabled mid-singing`, lyrics cancelled., 1
      }
      
      if GetKeyState(pauseKey,"P") ; Pause function
      {
         SendInput {Blind}{%pauseKey% up}
         If (!paused) ; Pauses it
         {
            global paused = 1
            MsgBox, 0, %MacroText%, Pause Key pressed`, lyrics paused. Press again to resume where you left off., 1
         }
         else if (paused) ; Unpauses it
         {
            global paused = 0
            MsgBox, 0, %MacroText%, Pause Key pressed`, lyrics resumed. Press again to pause again., 1
         }
      }
      else if GetKeyState(safeguardKey,"P") ; Cancel function
      {
         SendInput {Blind}{%safeguardKey% up}
         GuiControl,1:,singEnabled,0 ; Once it is done, disable Sing.
         global keepRunning = 0 ; Makes it stop running
         SetTimer, UltraHighPriorityLoopBypassingThread,Off,2147483647 ; Disables the timer after it is done
         MsgBox, 0, %MacroText%, Safeguard Key pressed`, lyrics cancelled., 1
      }
   Return
   
   Sleep(ms)
   {
      DllCall("Sleep",UInt,ms)
   }
   
   PrepareChatMacro()
   {
      Send {Blind}{t down}
      SendInput {Blind}{enter down}
      Send {Blind}{t up}{f24 up}
   }
   
   RestartTimer()
   {
      global originalTime := A_TickCount
   }
   
   CalculateTime()
   {
      return A_TickCount - originalTime
   }
   
   execute(CmdLine) ; Executes code dynamically, extrmely long. Not using #Include because it would be more of a hassle.
   {
      global r1,r2,r3,r4,r5,r6,r7
      
      StringGetPos, cPos, CmdLine, `,
      StringGetPos, sPos, CmdLine, %A_SPACE%
      
      IfGreater, sPos, 0
      IfLess, sPos, %cPos%
      cPos = %sPos%
      
      StringLeft, Command, CmdLine, %cPos%
      cPos ++
      StringTrimLeft, CmdLine, CmdLine, %cPos%
      CmdLine = %CmdLine%
      
      IfEqual, Command,
      Command = %CmdLine%
      
      Loop, Parse, CmdLine, `,, %A_Space%%A_Tab%
         P%A_Index% = %A_LOOPFIELD%
      
      if command not in
(Join
AutoTrim,BlockInput,ClipWait,Control,ControlClick,ControlFocus,
ControlGet,ControlGetFocus,ControlGetPos,ControlGetText,
ControlMove,ControlSend,ControlSendRaw,ControlSetText,CoordMode,
DetectHiddenText,DetectHiddenWindows,Drive,DriveGet,
DriveSpaceFree,Edit,EnvAdd,EnvDiv,EnvMult,EnvSet,EnvSub,EnvUpdate,
ExitApp,FileAppend,FileCopy,FileCopyDir,FileCreateDir,
FileCreateShortcut,FileDelete,FileGetAttrib,FileGetShortcut,
FileGetSize,FileGetTime,FileGetVersion,FileMove,FileMoveDir,
FileRead,FileReadLine,FileRecycle,FileRecycleEmpty,FileRemoveDir,
FileSelectFile,FileSelectFolder,FileSetAttrib,FileSetTime,
GetKeyState,GroupActivate,GroupAdd,GroupClose,GroupDeactivate,Gui,
GuiControl,GuiControlGet,Hotkey,IfEqual,IfNotEqual,IfExist,
IfNotExist,IfGreater,IfGreaterOrEqual,IfInString,IfNotInString,
IfLess,IfLessOrEqual,IfMsgBox,IfWinActive,IfWinNotActive,IfWinExist,
IfWinNotExist,ImageSearch,IniDelete,IniRead,IniWrite,Input,InputBox,
KeyHistory,KeyWait,ListHotkeys,ListLines,ListVars,Menu,MouseClick,
MouseClickDrag,MouseGetPos,MouseMove,MsgBox,OnExit,OutputDebug,
Pause,PixelGetColor,PixelSearch,PostMessage,Process,Progress,Random,
RegDelete,RegRead,RegWrite,Reload,Run,RunAs,RunWait,Send,SendRaw,
SendMessage,SetBatchLines,SetCapslockState,SetControlDelay,
SetDefaultMouseSpeed,SetFormat,SetKeyDelay,SetMouseDelay,
SetNumlockState,SetScrollLockState,SetStoreCapslockMode,SetTimer,
SetTitleMatchMode,SetWinDelay,SetWorkingDir,Shutdown,Sleep,Sort,
SoundBeep,SoundGet,SoundGetWaveVolume,SoundPlay,SoundSet,
SoundSetWaveVolume,SplashImage,SplashTextOn,SplashTextOff,SplitPath,
StatusBarGetText,StatusBarWait,StringCaseSense,StringGetPos,
StringLeft,StringLen,StringLower,StringMid,StringReplace,StringRight,
StringSplit,StringTrimLeft,StringTrimRight,StringUpper,Suspend,
SysGet,Thread,ToolTip,Transform,TrayTip,URLDownloadToFile,
WinActivate,WinActivateBottom,WinClose,WinGetActiveStats,
WinGetActiveTitle,WinGetClass,WinGet,WinGetPos,WinGetText,
WinGetTitle,WinHide,WinKill,WinMaximize,WinMenuSelectItem,
WinMinimize,WinMinimizeAll,WinMinimizeAllUndo,WinMove,WinRestore,
WinSet,WinSetTitle,WinShow,WinWait,WinWaitActive,WinWaitClose,
WinWaitNotActive
)
         return 0
      goto,%command%
      
      AutoTrim:
      autotrim,%p1%
      return
      
      BlockInput:
      blockinput,%p1%
      return
      
      ClipWait:
      clipwait,%p1%,%p2%
      return
      
      Control:
      control,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%
      return
      
      ControlClick:
      controlclick,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%
      return
      
      ControlFocus:
      controlfocus,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      ControlGet:
      controlget,ov,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%
      return ov
      
      ControlGetFocus:
      controlgetfocus,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      ControlGetPos:
      controlgetpos,r1,r2,r3,r4,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      ControlGetText:
      controlgettext,ov,%p1%,%p2%,%p3%,%p4%,%p5%
      return ov
      
      ControlMove:
      controlmove,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%,%p9%
      return
      
      ControlSend:
      controlsend,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%
      return
      
      ControlSendRaw:
      controlsendraw,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%
      return
      
      ControlSetText:
      controlsettext,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%
      return
      
      CoordMode:
      coordmode,%p1%,%p2%
      return
      
      DetectHiddenText:
      detecthiddentext,%p1%
      return
      
      DetectHiddenWindows:
      detecthiddenwindows,%p1%
      return
      
      Drive:
      drive,%p1%,%p2%,%p3%
      return
      
      DriveGet:
      driveget,ov,%p1%,%p2%
      return ov
      
      DriveSpaceFree:
      drivespacefree,ov,%p1%
      return ov
      
      Edit:
      edit
      return
      
      EnvAdd:
      envadd,%p1%,%p2%,%p3%
      return
      
      EnvDiv:
      envdiv,%p1%,%p2%
      return
      
      EnvMult:
      envmult,%p1%,%p2%
      return
      
      EnvSet:
      envset,%p1%,%p2%
      return
      
      EnvSub:
      envsub,%p1%,%p2%,%p3%
      return
      
      EnvUpdate:
      envupdate
      return
      
      ExitApp:
      exitapp
      return
      
      FileAppend:
      fileappend,%p1%,%p2%
      return
      
      FileCopy:
      filecopy,%p1%,%p2%,%p3%
      return
      
      FileCopyDir:
      filecopydir,%p1%,%p2%,%p3%
      return
      
      FileCreateDir:
      filecreatedir,%p1%
      return
      
      FileCreateShortcut:
      filecreateshortcut,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%,%p9%
      return
      
      FileDelete:
      filedelete,%p1%
      return
      
      FileGetAttrib:
      filegetattrib,ov,%p1%
      return ov
      
      FileGetShortcut:
      filegetshortcut,%p1%,r1,r2,r3,r4,r5,r6,r7
      return
      
      FileGetSize:
      filegetsize,ov,%p1%,%p2%
      return ov
      
      FileGetTime:
      filegettime,ov,%p1%,%p2%
      return ov
      
      FileGetVersion:
      filegetversion,ov,%p1%
      return ov
      
      FileMove:
      filemove,%p1%,%p2%,%p3%
      return
      
      FileMoveDir:
      filemovedir,%p1%,%p2%,%p3%
      return
      
      FileRead:
      fileread,ov,%p1%
      return ov
      
      FileReadLine:
      filereadline,ov,%p1%,%p2%
      return ov
      
      FileRecycle:
      filerecycle,%p1%
      return
      
      FileRecycleEmpty:
      filerecycleempty,%p1%
      return
      
      FileRemoveDir:
      fileremovedir,%p1%,%p2%
      return
      
      FileSelectFile:
      fileselectfile,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      FileSelectFolder:
      fileselectfolder,ov,%p1%,%p2%,%p3%
      return ov
      
      FileSetAttrib:
      filesetattrib,%p1%,%p2%,%p3%,%p4%
      return
      
      FileSetTime:
      filesettime,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      GetKeyState:
      getkeystate,ov,%p1%,%p2%
      return ov
      
      GroupActivate:
      groupactivate,%p1%,%p2%
      return
      
      GroupAdd:
      groupadd,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%
      return
      
      GroupClose:
      groupclose,%p1%,%p2%
      return
      
      GroupDeactivate:
      groupdeactivate,%p1%,%p2%
      return
      
      Gui:
      gui,%p1%,%p2%,%p3%,%p4%
      return
      
      GuiControl:
      guicontrol,%p1%,%p2%,%p3%
      return
      
      GuiControlGet:
      guicontrolget,ov,%p1%,%p2%,%p3%
      return ov
      
      Hotkey:
      hotkey,%p1%,%p2%,%p3%
      return
      
      IfEqual:
         ifequal,%p1%,%p2%
      return 1
      else
         return 0
      
      IfNotEqual:
         ifnotequal,%p1%,%p2%
      return 1
      else
         return 0
      
      IfExist:
         ifexist,%p1%
            return 1
else
   return 0
      
      IfNotExist:
         ifnotexist,%p1%
            return 1
else
   return 0
      
      IfGreater:
         ifgreater,%p1%,%p2%
      return 1
      else
         return 0
      
      IfGreaterOrEqual:
         ifgreaterorequal,%p1%,%p2%
      return 1
      else
         return 0
      
      IfInString:
         ifinstring,%p1%,%p2%
            return 1
else
   return 0
      
      IfNotInString:
         ifnotinstring,%p1%,%p2%
            return 1
else
   return 0
      
      IfLess:
         ifless,%p1%,%p2%
      return 1
      else
         return 0
      
      IfLessOrEqual:
         iflessorequal,%p1%,%p2%
      return 1
      else
         return 0
      
      IfMsgBox:
         ifmsgbox,%p1%
            return 1
else
   return 0
      
      IfWinActive:
         ifwinactive,%p1%,%p2%,%p3%,%p4%
            return 1
else
   return 0
      
      IfWinNotActive:
         ifwinnotactive,%p1%,%p2%,%p3%,%p4%
            return 1
else
   return 0
      
      IfWinExist:
         ifwinexist,%p1%,%p2%,%p3%,%p4%
            return 1
else
   return 0
      
      IfWinNotExist:
         ifwinnotexist,%p1%,%p2%,%p3%,%p4%
            return 1
else
   return 0
         
         ImageSearch:
         imagesearch,r1,r2,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      IniDelete:
      inidelete,%p1%,%p2%,%p3%
      return
      
      IniRead:
      iniread,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      IniWrite:
      iniwrite,%p1%,%p2%,%p3%,%p4%
      return
      
      Input:
      input,ov,%p1%,%p2%,%p3%
      return ov
      
      InputBox:
      inputbox,ov,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,,%p8%,%p9%
      return ov
      
      KeyHistory:
      keyhistory
      return
      
      KeyWait:
      keywait,%p1%,%p2%
      return
      
      ListHotkeys:
      listhotkeys
      return
      
      ListLines:
      listlines
      return
      
      ListVars:
      listvars
      return
      
      Menu:
      menu,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      MouseClick:
      mouseclick,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%
      return
      
      MouseClickDrag:
      mouseclickdrag,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%
      return
      
      MouseGetPos:
      mousegetpos,r1,r2,r3,r4,%p1%
      return
      
      MouseMove:
      mousemove,%p1%,%p2%,%p3%,%p4%
      return
      
      MsgBox:
      if (p2 || p3)
      {
         if p4
            msgbox,%p1%,%p2%,%p3%,%p4%
         else
            msgbox,%p1%,%p2%,%p3%
      }
      else
         msgbox,%p1%
      return
      
      OnExit:
      onexit,%p1%
      return
      
      OutputDebug:
      outputdebug,%p1%
      return
      
      Pause:
      pause,%p1%
      return
      
      PixelGetColor:
      pixelgetcolor,ov,%p1%,%p2%,%p3%
      return ov
      
      PixelSearch:
      pixelsearch,r1,r2,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%
      return
      
      PostMessage:
      postmessage,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%
      return
      
      Process:
      process,%p1%,%p2%,%p3%
      return
      
      Progress:
      progress,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      Random:
      random,ov,%p1%,%p2%
      return ov
      
      RegDelete:
      regdelete,%p1%,%p2%,%p3%
      return
      
      RegRead:
      regread,ov,%p1%,%p2%,%p3%
      return ov
      
      RegWrite:
      regwrite,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      Run:
      run,%p1%,%p2%,%p3%,ov
      return ov
      
      RunAs:
      runas,%p1%,%p2%,%p3%
      return
      
      RunWait:
      runwait,%p1%,%p2%,%p3%,ov
      return ov
      
      Send:
      send,%p1%
      return
      
      SendRaw:
      sendraw,%p1%
      return
      
      SendMessage:
      sendmessage,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%
      return errorlevel
      
      SetBatchLines:
      setbatchlines,%p1%
      return
      
      SetCapslockState:
      setcapslockstate,%p1%
      return
      
      SetControlDelay:
      setcontroldelay,%p1%
      return
      
      SetDefaultMouseSpeed:
      setdefaultmousespeed,%p1%
      return
      
      SetFormat:
      setformat,%p1%,%p2%
      return
      
      SetKeyDelay:
      setkeydelay,%p1%,%p2%
      return
      
      SetMouseDelay:
      setmousedelay,%p1%
      return
      
      SetNumlockState:
      setnumlockstate,%p1%
      return
      
      SetScrollLockState:
      setscrolllockstate,%p1%
      return
      
      SetStoreCapslockMode:
      setstorecapslockmode,%p1%
      return
      
      SetTimer:
      settimer,%p1%,%p2%,%p3%
      return
      
      SetTitleMatchMode:
      settitlematchmode,%p1%,%p2%
      return
      
      SetWinDelay:
      setwindelay,%p1%
      return
      
      SetWorkingDir:
      setworkingdir,%p1%
      return
      
      Shutdown:
      shutdown,%p1%
      return
      
      Sleep:
      sleep,%p1%
      return
      
      Sort:
      sort,%p1%,%p2%
      return
      
      SoundBeep:
      soundbeep,%p1%,%p2%
      return
      
      SoundGet:
      soundget,ov,%p1%,%p2%,%p3%
      return ov
      
      SoundGetWaveVolume:
      soundgetwavevolume,ov,%p1%
      return ov
      
      SoundPlay:
      soundplay,%p1%,%p2%
      return
      
      SoundSet:
      soundset,%p1%,%p2%,%p3%,%p4%
      return
      
      SoundSetWaveVolume:
      soundsetwavevolume,%p1%,%p2%
      return
      
      SplashImage:
      splashimage,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%
      return
      
      SplashTextOn:
      splashtexton,%p1%,%p2%,%p3%,%p4%
      return
      
      SplashTextOff:
      splashtextoff
      return
      
      SplitPath:
      splitpath,%p1%,r1,r2,r3,r4,r5
      return
      
      StatusBarGetText:
      statusbargettext,ov,%p1%,%p2%,%p3%,%p4%,%p5%
      return ov
      
      StatusBarWait:
      statusbarwait,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%
      return
      
      StringCaseSense:
      stringcasesense,%p1%
      return
      
      StringGetPos:
      stringgetpos,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      StringLeft:
      stringleft,ov,%p1%,%p2%
      return ov
      
      StringLen:
      stringlen,ov,%p1%
      return ov
      
      StringLower:
      stringlower,ov,%p1%,%p2%
      return
      
      StringMid:
      stringmid,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      StringReplace:
      stringreplace,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      StringRight:
      stringright,ov,%p1%,%p2%
      return ov
      
      StringSplit:
      stringsplit,%p1%,%p2%,%p3%,%p4%
      return
      
      StringTrimLeft:
      stringtrimleft,ov,%p1%,%p2%
      return ov
      
      StringTrimRight:
      stringtrimright,ov,%p1%,%p2%
      return ov
      
      StringUpper:
      stringupper,ov,%p1%,%p2%
      return ov
      
      SysGet:
      sysget,ov,%p1%,%p2%
      return ov
      
      Thread:
      thread,%p1%,%p2%,%p3%
      return
      
      ToolTip:
      tooltip,%p1%,%p2%,%p3%,%p4%
      return
      
      Transform:
      transform,ov,%p1%,%p2%,%p3%
      return ov
      
      TrayTip:
      traytip,%p1%,%p2%,%p3%,%p4%
      return
      
      URLDownloadToFile:
      urldownloadtofile,%p1%,%p2%
      return
      
      WinActivate:
      winactivate,%p1%,%p2%,%p3%,%p4%
      return
      
      WinActivateBottom:
      winactivatebottom,%p1%,%p2%,%p3%,%p4%
      return
      
      WinClose:
      winclose,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      WinGetActiveStats:
      wingetactivestats,r1,r2,r3,r4,r5
      return
      
      WinGetActiveTitle:
      wingetactivetitle,ov
      return ov
      
      WinGetClass:
      wingetclass,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      WinGet:
      winget,ov,%p1%,%p2%,%p3%,%p4%,%p5%
      return ov
      
      WinGetPos:
      wingetpos,r1,r2,r3,r4,%p1%,%p2%,%p3%,%p4%
      return
      
      WinGetText:
      wingettext,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      WinGetTitle:
      wingettitle,ov,%p1%,%p2%,%p3%,%p4%
      return ov
      
      WinHide:
      winhide,%p1%,%p2%,%p3%,%p4%
      return
      
      WinKill:
      winkill,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      WinMaximize:
      winmaximize,%p1%,%p2%,%p3%,%p4%
      return
      
      WinMenuSelectItem:
      winmenuselectitem,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%,%p9%,%p10%,%p11%
      return
      
      WinMinimize:
      winminimize,%p1%,%p2%,%p3%,%p4%
      return
      
      WinMinimizeAll:
      winminimizeall
      return
      
      WinMinimizeAllUndo:
      winminimizeallundo
      return
      
      WinMove:
      if p1 is integer
      {
         if p2 is integer
            winmove,%p1%,%p2%
         else
            winmove,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%
      }
      else
         winmove,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%,%p7%,%p8%
      return
      
      WinRestore:
      winrestore,%p1%,%p2%,%p3%,%p4%
      return
      
      WinSet:
      winset,%p1%,%p2%,%p3%,%p4%,%p5%,%p6%
      return
      
      WinSetTitle:
      winsettitle,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      WinShow:
      winshow,%p1%,%p2%,%p3%,%p4%
      return
      
      WinWait:
      winwait,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      WinWaitActive:
      winwaitactive,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      WinWaitClose:
      winwaitclose,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
      WinWaitNotActive:
      winwaitnotactive,%p1%,%p2%,%p3%,%p4%,%p5%
      return
      
   }
   
   SetPriority(processName,priority)
   {
      
      if !DllCall("Wtsapi32\WTSEnumerateProcesses", Ptr, 0, UInt, 0, UInt, 1, PtrP, pProcessInfo, PtrP, count)
         throw Exception("WTSEnumerateProcesses failed. A_LastError: " . A_LastError)
      
      addr := pProcessInfo, PIDs := []
      Loop % count
      {
         if StrGet(NumGet(addr + 8)) = procName
            PID := NumGet(addr + 4, "UInt"), PIDs.Push(PID)
         addr += A_PtrSize = 4 ? 16 : 24
      }
      DllCall("Wtsapi32\WTSFreeMemory", Ptr, pProcessInfo)
      
      for k, PID in PIDs
         Process, Priority, % PID, %priority%
      
   }
   
   CancerFunction(char,count,sendMode:=0) ; It is the only way forward
   {
      If (count >= 31)
         count = 30
      If not (sendMode = "Send")
      {
         switch count
         {
         case 1:
            SendInput {%char%}
         case 2:
            SendInput {%char%}{%char%}
         case 3:
            SendInput {%char%}{%char%}{%char%}
         case 4:
            SendInput {%char%}{%char%}{%char%}{%char%}
         case 5:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}
         case 6:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 7:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 8:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 9:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 10:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 11:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 12:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 13:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 14:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 15:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 16:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 17:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 18:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 19:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 20:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 21:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 22:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 23:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 24:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 25:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 26:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 27:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 28:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 29:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 30:
            SendInput {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         }
      } else {
         switch count
         {
         case 1:
            Send {%char%}
         case 2:
            Send {%char%}{%char%}
         case 3:
            Send {%char%}{%char%}{%char%}
         case 4:
            Send {%char%}{%char%}{%char%}{%char%}
         case 5:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}
         case 6:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 7:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 8:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 9:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 10:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 11:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 12:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 13:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 14:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 15:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 16:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 17:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 18:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 19:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 20:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 21:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 22:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 23:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 24:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 25:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 26:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 27:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 28:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 29:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         case 30:
            Send {%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}{%char%}
         }
      }
   }
   
   Hotkey(KeyName,Label,Enable)
   {
      If (KeyName = "")
         Return
      If (Enable = "On")
         Hotkey, *%KeyName%, %Label%, UseErrorLevel On
      else
         Hotkey, *%KeyName%, %Label%, UseErrorLevel Off
   }