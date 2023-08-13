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
MacroVersion := "4.2.1.1"
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
China := "Bind"
SendInputFallbackText = I have detected that it has taken a very long time to complete the chat message. First, check if the characters are being sent one by one, or in instant `"batches`". If it is being sent in batches, then your FPS is likely very low. Please complain to me on Discord and I will raise the threshold for this message. If it is being sent one by one, try this: If you are running Flawless Widescreen, you must close it, as it causes issues, and makes most macros far slower. Please open a support ticket on the Discord Server if the problem persists, or if Flawless Widescreen is not running.
WriteWasJustPerformed = 0 ; EWO Score Write was just performed
IniRead,DebugTesting,%CFG%,Debug,Debug Testing ; Checks if debug testing is true, usually false.
IniRead,WhileChat,%CFG%,Debug,Improve Chat Macros But You Can't Use Multiple Keybinds ; yes
IniWrite,%WhileChat%,%CFG%,Debug,Improve Chat Macros But You Can't Use Multiple Keybinds
IniRead,OriginalLocation, %ConfigDirectory%\FileLocationData.ini, Location, Location
IniRead,OriginalName, %ConfigDirectory%\FileLocationData.ini, Name, Name

; GTAHaX EWO Offsets:
FreemodeGlobalIndex := 262145
EWOGlobalOffset1 := 28616
; GTAHaX EWO Offsets 2:
EWOGlobalIndex := 2794162
EWOGlobalOffset0 := 6898
; GTAHaX EWO Score Offsets:
ScoreGlobalIndex := 2672524
ScoreGlobalOffset1 := 1685
ScoreGlobalOffset2 := 817
; CEO Circle Offsets:
CEOCircleGlobalIndex := 1895156
CEOCircleGlobalOffset1 := 5
CEOCircleGlobalOffset2 := 10
CEOCircleGlobalOffset3 := 11
; Interaction Menu Open Globals:
; func_1 in am_pi_menu.c
IntMenuGlobalIndex := 2672524
IntMenuGlobalOffset1 := 947
IntMenuGlobalOffset2 := 6

; Add them together
FreemodeGlobalIndexAddedTogether := FreemodeGlobalIndex + EWOGlobalOffset1 ; 290761
EWOGlobalIndexAddedTogether := EWOGlobalIndex + EWOGlobalOffset0 ; 2801060
ScoreGlobalIndexAddedTogether := ScoreGlobalIndex + ScoreGlobalOffset1 + ScoreGlobalOffset2 ; 2675026
CEOCircleGlobalIndexAddedTogether := CEOCircleGlobalIndex + CEOCircleGlobalOffset1 + CEOCircleGlobalOffset2 + CEOCircleGlobalOffset3 ; 1895182
IntMenuGlobalIndexAddedTogether := IntMenuGlobalIndex + IntMenuGlobalOffset1 + IntMenuGlobalOffset2 ; 2673477

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
   #Requires AutoHotkey >=1.1.36.02 Unicode <1.2
   DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ; yes
   SetTitleMatchMode, 2 ; I forgor :dead_skull:
   SetDefaultMouseSpeed, 0 ; Something
   SetKeyDelay, -1, -1 ; Sets key delay to the lowest possible, there is still delay due to the keyboard hook in GTA, but this makes it excecute as fast as possible WITHOUT skipping keystrokes. Set this a lot higher if you uninstalled the keyboard hook using mods.
   SetWinDelay, -1 ; After any window modifying command, the script has a built in delay. Fuck delays.
   SetMouseDelay, -1
   SetControlDelay, -1 ; After any control modifying command, for example; ControlSend, there is a built in delay.
   Gui,Font,q5,Segoe UI Semibold ; Sets font to something
   IniRead,neverOnTop,%CFG%,Debug,Never On Top ; Secret module
   IniRead,fuckYou,%CFG%,Debug,Fuck You ; Secret module
   If (neverOnTop)
      SetTimer, NeverOnTop, 25, -2147483648
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
If (!isCompiled)
{
   MsgBox, 0, %MacroText%,If you see this`, something strange is happening. , 0.75
   Reload
}
Else
{
   Process, Close, %Gay%
   Process, Close, %ewoWriteWindow%
   Process, Close, %intMenuWindow%
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
   Process, Close, %Gay%
   Process, Close, %ewoWriteWindow%
   Process, Close, %intMenuWindow%
   Process, Close, %Gay3%
   Process, Close, %Obese11%
ExitApp
return

HideWindow: ; Hides the GUI
   Gui, Hide
return

ThermalHelmet: ; Self explanatory
   SendInput {Blind}{lbutton up}{enter down}
   GuiControlGet, NightVision
   Send {Blind}{%InteractionMenuKey%}
   SendDown(4,0)
   SendInput {Blind}{enter up}
   Send {Blind}{down down}
   SendInput {Blind}{enter down}
   Send {Blind}{down up}
   SendInput {Blind}{enter up}
   If (!NightVision)
   {
      SendDown(4,0)
   }
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
      SendDown(4,0)
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
   SetMouseDelay 10
   GuiControlGet, FasterSniper
   SendInput {Blind}{%FastSniperSwitch% up}
   If (FasterSniper)
   {
      Send {%BindSticky% down}{%BindSniper% down}{tab}
      SendInput {Blind}{%BindSniper% up}{%BindSticky% up}
   } else
   {
      Send {Blind}{%BindSniper%}
      Sleep(17)
      Send {Blind}{lbutton down}
      Sleep(12)
      Send {Blind}{lbutton up}{%BindSniper%}
      Sleep(17)
      Send {Blind}{lbutton down}
      Sleep(110)
      Send {Blind}{lbutton up}
   }
   SetMouseDelay -1
return

EWO: ; Self explanatory
   
   GuiControlGet, SmoothEWO
   GuiControlGet, SmoothEWOMode
   GuiControlGet, EWOWrite
   GuiControlGet, shootEWO
   GuiControlGet, customTime
   capsLockState := GetKeyState("CapsLock", "T")
   If (SmoothEWOMode = "Fast Respawn") && (SmoothEWO) || (SmoothEWOMode = "Sticky") && (SmoothEWO)
      Goto, MiscEWOModes
   
   ; Sometimes if you quickly switch to another weapon before you EWO it won't be instant. This fix only works if you have "Fast Switch" enabled, aka if you are an AW player most likely.
   if (fuckYou <> 1)
   {
      ; This will give me the bind of the hotkey that was last executed before this one. There will be an asterisk in the bind name, which StrReplace() removes.
      priorHotkey := StrReplace(A_PriorHotkey, "*")
      ; If the previous hotkey's bind is the same as any of the weapon-switching binds, then it will wait a few milliseconds before EWOing.
      if (priorHotkey = BindSticky) || (priorHotkey = BindRPG) || (priorHotkey = BindPistol) || (priorHotkey = BindRifle) ||(priorHotkey = BindShotgun) || (priorHotkey = BindSMG) || (priorHotkey = BindSniper)
      {
         ; If it has been less than 150ms since you pressed it, it will wait that amount of time, minus the time since the prior hotkey.
         if (A_TimeSincePriorHotkey	< 150)
            Sleep(150 - A_TimeSincePriorHotkey) ; Maths
      }
   }
   
   SendInput {Blind}{%EWOLookBehindKey% up}{lbutton up}{%EWOMelee% down}{lshift up}{rshift up}{lctrl up}{rctrl up}
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
            SetMouseDelay 10
            Send {Blind}{lbutton down}{rbutton down}
            SendInput {Blind}{rbutton up}{lbutton up}
            Sleep(80)
         case "Retarded":
            Sleep(100)
         case "Fast":
            SetMouseDelay 10
            Send {Blind}{lbutton down}{rbutton down}
            SendInput {Blind}{rbutton up}{lbutton up}
            Sleep(30)
         }
         SetMouseDelay -1
      }
      
      switch SmoothEWOMode
      {
      case "Fastest":
         SetMouseDelay 10
         Send {Blind}{lbutton down}{rbutton down}
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{up down}{%InteractionMenuKey% down}{%explodeBind% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{%EWOLookBehindKey% down}{f24 2}{f24 up}
         SendInput {Blind}{wheelup}{up up}{enter up}
         SetMouseDelay -1
      case "Fasterest":
         SetMouseDelay 10
         Send {Blind}{lbutton down}{rbutton down}
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{up down}{%InteractionMenuKey% down}{%explodeBind% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{%EWOLookBehindKey% down}{f24 2}
         SendInput {Blind}{wheelup}{up up}{enter up}
         SetMouseDelay -1
      case "Custom":
         customTimeFrames := StrSplit(customTime,"F")
         SetMouseDelay 10
         Send {Blind}{lbutton down}{rbutton down}{rbutton up}{lbutton up}
         SendInput {Blind}{%EWOLookBehindKey% down}
         If InStr(customTime,"F")
            CancerFunction("f24 up",customTimeFrames[1],"Send")
         else
            Sleep(customTime)
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{up down}{%InteractionMenuKey% down}{%explodeBind% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{f24}{f24 up}
         SendInput {Blind}{wheelup}{up up}{enter up}
         SetMouseDelay -1
      case "Fast":
         SendInput {Blind}{alt up}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}
         Sleep(28)
         SendInput {Blind}{%EWOLookBehindKey% down}
         Sleep(13)
         SendInput {Blind}{up down}
         Sleep(35)
         SendInput {Blind}{WheelUp}
         Sleep(30)
         SendInput {Blind}{enter up}{%InteractionMenuKey% up}{%EWOLookBehindKey% up}
      case "Staeni":
         /*
         SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}
         Sleep(20)
         Send {Blind}{%EWOLookBehindKey% down}{up}
         Sleep(25)
         SendInput {Blind}{WheelUp}
         Sleep(46)
         SendInput {Blind}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{enter up}{%InteractionMenuKey% up}
               */
         SendInput {Blind}{alt up}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}
         Sleep(33.5)
         SendInput {Blind}{%EWOLookBehindKey% down}
         Sleep(14)
         SendInput {Blind}{up down}
         Sleep(37.5)
         SendInput {Blind}{WheelUp}
         Sleep(50)
         SendInput {Blind}{enter up}{%InteractionMenuKey% up}{%EWOLookBehindKey% up}
      case "Faster":
         SetMouseDelay 10
         Send {Blind}{lbutton down}{rbutton down}{rbutton up}
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{lbutton up}{%EWOSpecialAbilitySlashActionKey% down}{%InteractionMenuKey% down}
         Send {Blind}{%EWOLookBehindKey% down}{f24 up}{up}{f24 up}{up}{f24 up}{enter}
         SetMouseDelay -1
      case "Retarded":
         StringUpper, EWOLookBehindKey, EWOLookBehindKey
         Random, var, 1, 4
         SendInput {Blind}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}{%EWOSpecialAbilitySlashActionKey% down}
         Sleep(25)
         Send {Blind}{up}
         Sleep(25)
         Send {Blind}{up}
         Sleep(40)
         Send {Blind}{%EWOLookBehindKey% down}
         if (var = 1) ; why the fuck did i do this
            Send {Blind}{f24}{f24 up}
         else if (var = 2)
            Send {Blind}{f24 2}{f24 up}
         else if (var = 3)
            Send {Blind}{f24 3}{f24 up}
         Send {Blind}{enter up}
         StringLower, EWOLookBehindKey, EWOLookBehindKey
      case "Retarded2":
         SendInput {Blind}{lbutton up}{rbutton up}{enter down}
         Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
         SendInput {Blind}{enter down}
         Send {Blind}{up up}
         SendInput {Blind}{enter up}
         GuiControl,1:, CEOMode, 0
         Sleep(110)
         
         SendInput {Blind}{%EWOLookBehindKey% down}{lbutton up}{rbutton up}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{%InteractionMenuKey% down}
         Sleep(13)
         Send {Blind}{shift down}{f24 up}{shift up}{up}
         Sleep(12)
         Send {Blind}{up}
         Sleep(9)
         Send {Blind}{%EWOSpecialAbilitySlashActionKey% down}{enter up}
      case "Retarded3":
         Send {Blind}{lbutton down}{rbutton down}
         SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{up down}{%InteractionMenuKey% down}{%explodeBind% down}{lbutton up}{rbutton up}{%EWOLookBehindKey% down}{%EWOSpecialAbilitySlashActionKey% down}
         Send {Blind}{space down}{f24}
         SendInput {Blind}{wheelup}{up up}{enter up}
      }
   } else
   {
      SetMouseDelay 10
      Send {Blind}{lbutton down}{rbutton down}
      SendInput {Blind}{lctrl up}{rctrl up}{lshift up}{rshift up}{enter down}{up down}{%InteractionMenuKey% down}{%explodeBind% down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% down}
      Send {Blind}{%EWOLookBehindKey% down}{f24}{f24 up}
      SendInput {Blind}{wheelup}{up up}{enter up}
      SetMouseDelay -1
   }
   SendInput {up up}{%InteractionMenuKey% up}{%EWOMelee% up}{%EWOSpecialAbilitySlashActionKey% up}{%explodeBind% up}
   Send {Blind}{enter 2}{up}{enter}{left}{down}{enter}{backspace}{space up}
   SendInput {%EWOLookBehindKey% up}
   SetCapsLockState, %capsLockState%
return

MiscEWOModes:
   GuiControlGet, SmoothEWO
   GuiControlGet, SmoothEWOMode
   GuiControlGet, EWOWrite
   GuiControlGet, shootEWO
   If (SmoothEWOMode = "Sticky") && (SmoothEWO)
   {
      SendInput {lbutton down}{rbutton up}
      Send {Blind}{%BindRifle%}
      SendInput {lbutton up}
      Send {Blind}{tab} ; {lbutton 5}
      Loop, 15 {
         if WinActive("ahk_exe GTA5.exe")
         {
            Send {Blind}{%explodeBind% 4} ; {lbutton}
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
         Sleep 25
         WinSet, ExStyle, ^0x80, ahk_pid %ewoWriteWindow% ; Makes the window not show up on Alt+Tab
         ControlSetText, Edit1, %ScoreGlobalIndexAddedTogether%, ahk_pid %ewoWriteWindow%
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
   If (KekEWO = "CapsLock")
      SetCapsLockState Off
   GuiControlGet, antiKekMode
   SendInput {Blind}{%EWOLookBehindKey% up}{%EWOSpecialAbilitySlashActionKey% up}
   if (antiKekMode = "Options Menu")
   {
      SendInput {Blind}{%EWOMelee% down}{lshift down}
      Send {Blind}{p}
      Sleep(65)
      Send {Blind}{right}
      Sleep(440)
      Send {Blind}{enter}
      Sleep(200)
      SendDown(5,0)
      Sleep(190)
      Send {Blind}{enter}
      Sleep(40)
      SendDown(6,0)
      RestartTimer()
      Loop
      {
         If (CalculateTime(originalTime) > 200)
            break
         Send {Blind}{enter}
      }
   } else if (antiKekMode = "Interaction Menu Spam")
   {
      if not (timerActive)
      {
         SetTimer, intMenuOpen, 10, 2147483647
         timerActive := 1
         Sleep 50
      }
      SendInput {Blind}{%EWOLookBehindKey% down}{lshift down}{lctrl down}{lbutton up}{rbutton up}{%EWOSpecialAbilitySlashActionKey% up}{%InteractionMenuKey% down}{%EWOMelee% down}
      RestartTimer()
      While (CalculateTime(originalTime) < 600)
      {
         If (intMenuOpen)
         {
            SendInput {Blind}{%EWOSpecialAbilitySlashActionKey% up}{enter down}
            Send {Blind}{up 2}
            SendInput {Blind}{enter up}
            Send {Blind}{f24 up}{backspace}
            Sleep 50
         }
         /*
         
         else
         {
            Sleep 50
            if (!intMenuOpen)
            {
               Send {Blind}{backspace}{f24 2}{%InteractionMenuKey% down}
               Sleep 50
            }
         }
         */
         
      }
      SendInput {Blind}{%InteractionMenuKey% up}
   }
   SendInput {Blind}{%EWOMelee% up}{%EWOLookBehindKey% up}{%InteractionMenuKey% up}{up up}{lshift up}{lctrl up}
return

intMenuOpen:
   ; Create the window
   if !WinExist("ahk_pid " intMenuWindow) ; If window doesn't exist, make it exist and add shit to it
   {
      Run, GTAHaXUI.exe, %ConfigDirectory%,Min,intMenuWindow ; "Min" is a launch option you can specify. This makes the window invsible; however, it will still show up on Alt+Tab. I fix that 2 lines below.
      WinWait, ahk_pid %intMenuWindow% ; Waits for GTAHaX to actually exist before continuing
      Sleep 25
      WinSet, ExStyle, ^0x80, ahk_pid %intMenuWindow% ; Makes the window not show up on Alt+Tab
      ControlSetText, Edit1, %IntMenuGlobalIndexAddedTogether%, ahk_pid %intMenuWindow%
   } else
   {
      ControlGet, currentValue2,Line,1,Edit7,ahk_pid %intMenuWindow% ; This is the current value. This is next to the lowest global variable-related line. It gets the current value of the global.
      If (currentValue2 = 0)
         intMenuOpen := 1
      else
         intMenuOpen := 0
   }
Return

BST: ; Self explanatory
   SendInput {Blind}{lbutton up}{enter down}
   GuiControlGet, CEOMode
   GuiControlGet, BSTMC
   If (!CEOMode)
      MsgBox, 0, Warning!, You are not in a CEO! , 0.75
   else
   {
      Send {Blind}{%InteractionMenuKey%}{enter up}
      SendDown(3,0)
      SendInput {Blind}{enter down}
      SendDown(1,1)
      Send {Blind}{enter up}{down down}
      SendInput {Blind}{enter down}
      Send {Blind}{down up}
      SendInput {Blind}{enter up}
   }
return

Ammo: ; Self explanatory
   
   ; Creates an array with how long it has been since any of the weapon binds were pressed
   timesinceWeapons := []
   timesinceWeapons.Push(CalculateTime(sniperBindTime)), timesinceWeapons.Push(CalculateTime(rpgBindTime)), timesinceWeapons.Push(CalculateTime(stickyBindTime)), timesinceWeapons.Push(CalculateTime(pistolBindTime)), timesinceWeapons.Push(CalculateTime(rifleBindTime)), timesinceWeapons.Push(CalculateTime(shotgunBindTime)), timesinceWeapons.Push(CalculateTime(smgBindTime)), timesinceWeapons.Push(CalculateTime(fistsBindTime)),
   currentSmallest := 10000000
   for index, value in timesinceWeapons
   {
      if (value = "")
         Continue
      if (value < currentSmallest)
      {
         currentSmallest := value
         arrayLocation := index
      }
   }
   
   SendInput {Blind}{lbutton up}{enter down}
   Send {Blind}{%InteractionMenuKey%}
   SendDown(3,0)
   SendInput {Blind}{enter up}
   SendDown(4,0)
   SendInput {Blind}{enter down}
   SendDown(2,0)
   SendInput {Blind}{enter up}
   If (arrayLocation = 2)
      Send {Blind}{enter}
   else if (arrayLocation = 3)
      Send {Blind}{enter 2}
   else
      Send {Blind}{f24 up}{left}
   Send {Blind}{up down}
   SendInput {Blind}{enter down}
   Send {Blind}{up up}
   SendInput {Blind}{enter up}
   Send {Blind}{%InteractionMenuKey%}
   Sleep(110)
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
   GuiControlGet, BugRespawnMode
   sleepTime := 200
   SendInput {Blind}{ctrl up}{lshift up}{rshift up}{lbutton up}{rbutton up}
   If (BugRespawnMode = "Sticky")
   {
      SendInput {Blind}{%FranklinBind% down}
      Sleep(350)
      Send {Blind}{%explodeBind% down}
      SendInput {Blind}{%FranklinBind% up}
      Sleep sleepTime
      Send {Blind}{backspace}{lbutton up}{%explodeBind% up}
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
Return

GTAHax: ; EWO Cooldown
   Run, GTAHaXUI.exe, %ConfigDirectory%,,Gay
   WinWait, ahk_pid %Gay%
   Sleep(25)
   ControlSetText, Edit1, %FreemodeGlobalIndexAddedTogether%, ahk_pid %Gay%
   Sleep(100)
   ControlClick, Button1, ahk_pid %Gay%
   Sleep(100)
   ControlSetText, Edit2, 1, ahk_pid %Gay%
   Sleep(100)
   ControlClick, Button1, ahk_pid %Gay%
   Sleep(100)
   ControlSetText, Edit1, %EWOGlobalIndexAddedTogether%, ahk_pid %Gay%
   ControlSetText, Edit2, 0, ahk_pid %Gay%
   Sleep(100)
   ControlClick, Button1, ahk_pid %Gay%
   MsgBox, 0, Complete!, You should now have no EWO cooldown. Kill yourself with a Sticky/RPG if you currently have a cooldown.
   Process, Close, %Gay%
return

GTAHaxCEO: ; GTAHaX CEO Circle
   Run, GTAHaXUI.exe, %ConfigDirectory%,,Gay
   WinWait, ahk_pid %Gay%
   Sleep(25)
   ControlSetText, Edit1, %CEOCircleGlobalIndexAddedTogether%, ahk_pid %Gay%
   Sleep(30)
   ControlClick, Button1, ahk_pid %Gay%
   Sleep(30)
   
   Loop, 32 ; Recreates the function that determines what memory address this global should be in, and tests every possible combination of that.
   {
      PlayerID := a_index
      PlayerID1 := PlayerID * 609
      ControlSetText, Edit2, %PlayerID1%, ahk_pid %Gay%
      Sleep(30)
      ControlClick, Button1, ahk_pid %Gay%
      Sleep(30)
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
   Send {Blind}{%InteractionMenuKey%}
   SendUp(11,2)
   Send {Blind}{enter up}
   SendDown(3,0)
   Send {Blind}{enter}{%InteractionMenuKey%}
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

ShowUI:
   Gui, Show
return

ToggleCEO:
   SendInput {Blind}{lbutton up}{enter down}
   GuiControlGet, CEOMode
   If (!CEOMode)
   {
      Send {Blind}{%InteractionMenuKey%}{down}
      SendInput {Blind}{enter up}
      Send {Blind}{enter}{enter}
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
   isInMC := 0
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
            Process, Close, %intMenuWindow%
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

WeaponSwitch(labelName)
{
   GuiControlGet TabWeapon
   
   currentBind := labelName[2] ; This works in conjunction with the label names to split the variable. The StrSplit below splits it into "Bind" and for example "Sniper". The currentBind variable is now equal to the previously executed label name, minus Bind, so for example it will now just be "Sniper"
   thisWasHorribleToMake := Bind%currentBind% ; Using this, I will access the variable named "Bind" and then for example "Sniper", which is "BindSniper", which is the variable name. This is what we want to access.
   
   SendInput {Blind}{tab up}
   If (!TabWeapon)
      Send {Blind}{%thisWasHorribleToMake%}
   else
   {
      Send {Blind}{%thisWasHorribleToMake% down}{tab}
      SendInput {Blind}{%thisWasHorribleToMake% up}
   }
}

BindSniper:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global sniperBindTime := A_TickCount
return

BindRPG:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global rpgBindTime := A_TickCount
return

BindSticky:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global stickyBindTime := A_TickCount
Return

BindPistol:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global pistolBindTime := A_TickCount
return

BindRifle:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global rifleBindTime := A_TickCount
return

BindShotgun:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global shotgunBindTime := A_TickCount
Return

BindSMG:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global smgBindTime := A_TickCount
Return

BindFists:
   WeaponSwitch(StrSplit(A_ThisLabel, "B" "i" "n" "d"))
   global fistsBindTime := A_TickCount
Return

RPGSpam:
   Send {%BindSticky% down}{%BindRPG% down}{tab}
   SendInput {%BindRPG% up}{%BindSticky% up}
   global rpgBindTime := A_TickCount
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
   Send {Blind}{%InteractionMenuKey%}
   SendUp(8,0)
   SendInput {Blind}{enter up}
   Send {Blind}{down down}
   SendInput {Blind}{enter down}
   Send {Blind}{down up}
   SendInput {Blind}{WheelDown}{enter up}
   Send {Blind}{enter}{%InteractionMenuKey%}
return

MCCEO:
   ; Unregisters as a CEO/MC President
   SendInput {lbutton up}{enter down}
   Send {Blind}{%InteractionMenuKey%}{enter up}{up down}
   SendInput {Blind}{enter down}
   Send {Blind}{up up}
   SendInput {Blind}{enter up}
   Sleep(150)
   
   SendInput {Blind}{enter down}
   Send {Blind}{%InteractionMenuKey%}{down down}{enter up}
   SendInput {Blind}{down up}
   If (isInMC)
      Send {Blind}{up}
   SendInput {Blind}{up up}
   
   RestartTimer()
   Loop
   {
      timeElapsed := CalculateTime(originalTime)
      If (timeElapsed > 1250)
         break
      Send {Blind}{backspace down}
      SendInput {Blind}{enter down}
      Send {Blind}{backspace up}{enter up}{enter down}
      If (isInMC)
         Send {Blind}{up down}
      else
         Send {Blind}{f24 up}
      SendInput {Blind}{enter up}
      Send {Blind}{enter}
      SendInput {Blind}{up up}
   }
   
   Sleep(25)
   GuiControl,1:, CEOMode, 1
   If (!isInMC)
      isInMC := 1
   else
      isInMC := 0
return

LaunchCycle:
   GuiControlGet, Paste ; Checks if pasting chat messages is enabled, and then it will enable it.
   If (!Paste)
      Hotkey, ^v, Paste, Off
   else
      Hotkey, ^v, Paste, On
   Hotkey(BindSniper,"BindSniper","On")
   Hotkey(BindRPG,"BindRPG","On")
   Hotkey(BindSticky,"BindSticky","On")
   Hotkey(BindPistol,"BindPistol","On")
   Hotkey(BindRifle,"BindRifle","On")
   Hotkey(BindShotgun,"BindShotgun","On")
   Hotkey(BindSMG,"BindSMG","On")
   Hotkey(BindFists,"BindFists","On")
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
   Hotkey(closeGTABind,"CloseGTAProcesses","Off")
   Hotkey(beAloneBind,"BeAlone","Off")
Return

NotExist1:
   IfNotExist, %CFG%
   {
      GuiControl,1:,InteractionMenuKey,m
      GuiControl,1:,FranklinBind,F6
      GuiControl,1:,ThermalHelmet,
      GuiControl,1:,jetThermal,
      GuiControl,1:,FastSniperSwitch,
      GuiControl,1:,EWO,
      GuiControl,1:,EWOWrite,0
      GuiControl,1:,EWOLookBehindKey,c
      GuiControl,1:,EWOSpecialAbilitySlashActionKey,CapsLock
      GuiControl,1:,EWOMelee,r
      GuiControl,1:,BST,
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
      GuiControl,1:,Reverse,0
      GuiControl,1:,SpecialBuy,0
      GuiControl,1:,ProcessCheck2,0
      GuiControl,1:,NightVision,0
      GuiControl,1:,RPGSpam,
      GuiControl,1:,BindRPG,4
      GuiControl,1:,BindSticky,5
      GuiControl,1:,BindPistol,6
      GuiControl,1:,BindSniper,9
      GuiControl,1:,BindRifle,8
      GuiControl,1:,BindShotgun,3
      GuiControl,1:,BindSMG,7
      GuiControl,1:,BindFists,1
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
      GuiControl,Choose,clumsyLagMode,sending
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
   Gui, Add, Link,, Fast Switch: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Fast-Switch">(?)</a>
   
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
   Gui, Add, Checkbox, vTabWeapon,
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
   Gui, Add, Checkbox, vRawText h21,
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
   Gui, Add, Link,, Shotgun: <a href="">(?)</a>
   Gui, Add, Link,, SMG: <a href="">(?)</a>
   Gui, Add, Link,, Melee: <a href="">(?)</a>
   Gui, Add, Link,, Swap to Franklin Bind: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Swap-to-Franklin-Bind">(?)</a>
   Gui, Add, Link,, Sticky Explode Bind: <a href="">(?)</a>
   
   Gui, Add, Hotkey,vInteractionMenuKey x+15 y60,
   Gui, Add, Hotkey,vBindSniper,
   Gui, Add, Hotkey,vEWOLookBehindKey,
   Gui, Add, Hotkey,vEWOSpecialAbilitySlashActionKey,
   Gui, Add, Hotkey,vEWOMelee,
   Gui, Add, Hotkey,vBindRPG,
   Gui, Add, Hotkey,vBindSticky,
   Gui, Add, Hotkey,vBindPistol,
   Gui, Add, Hotkey,vBindRifle,
   Gui, Add, Hotkey,vBindShotgun,
   Gui, Add, Hotkey,vBindSMG,
   Gui, Add, Hotkey,vBindFists,
   Gui, Add, Hotkey,vFranklinBind,
   Gui, Add, Hotkey,vexplodeBind,
Return

MacroOptions:
   Gui, Tab, 4
   Gui, Add, Link,x+5 y60, Check if GTA open <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Check-if-GTA-is-Open">(?)</a>
   Gui, Add, Link,, Faster Sniper Switch <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Faster-Sniper-Switch">(?)</a>
   Gui, Add, Link,, Crosshair: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Crosshair">(?)</a>
   Gui, Add, Link,, Crosshair position: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Crosshair-position">(?)</a>
   Gui, Add, Link,, Night Vision Thermal <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Night-Vision-Thermal">(?)</a>
   Gui, Add, Link,, Slower EWO? <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a>
   Gui, Add, Link,, Shoot EWO? <a href="">(?)</a>
   Gui, Add, Link,, Custom EWO Sleep Time: <a href="">(?)</a>
   Gui, Add, Link,, CEO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/CEO-Mode">(?)</a>
   Gui, Add, Link,, Show EWO Score: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-EWO-Score">(?)</a>
   Gui, Add, Link,, Sing: <a href="">(?)</a>
   If (DebugTesting)
   {
      Gui, Add, Link,, Passive Disable Spam: <a href="">(?)</a>
      Gui, Add, Link,, clumsy ping: <a href="">(?)</a>
      Gui, Add, Link,, clumsy lag mode: <a href="">(?)</a>
   }
   Gui, Add, Link,, Slower EWO Mode: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Slower-EWO">(?)</a>
   Gui, Add, Link,, AntiKek Mode: <a href="">(?)</a>
   Gui, Add, Link,, Optimize Fast Respawn EWO for: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Optimize-Fast-Respawn-EWO-For">(?)</a>
   
   Gui, Add, CheckBox, gProcessCheck3 vProcessCheck2 h21 x+105 y60,
   Gui, Add, CheckBox, vFasterSniper h21,
   Gui, Add, Checkbox, gCrossHair5 vCrossHair h21,
   Gui, Add, Edit, gCrosshair5 vCrosshairPos h21,
   Gui, Add, CheckBox, vNightVision h21,
   Gui, Add, Checkbox, vSmoothEWO h21,
   Gui, Add, Checkbox, vshootEWO h21,
   Gui, Add, Edit, vcustomTime h21,
   Gui, Add, CheckBox, vCEOMode h21,
   Gui, Add, Checkbox, gEWOWrite vEWOWrite h21
   Gui, Add, Checkbox, gToggleSing vsingEnabled h21
   If (DebugTesting)
   {
      Gui, Add, Checkbox, gPassiveDisableSpamCheck vPassiveDisableSpam h21
      Gui, Add, Edit, gClumsyPing vclumsyPing h21,
      Gui, Add, DropDownList, gclumsyLagMode vclumsyLagMode, sending|recieving
   }
   Gui, Add, DropDownList, vSmoothEWOMode, Sticky|Retarded|Retarded2|Retarded3|Staeni|Fast|Faster|Fastest|Fasterest|Custom
   Gui, Add, DropDownList, vantiKekMode, Options Menu|Interaction Menu Spam
   Gui, Add, DropDownList, vBugRespawnMode, Sticky|Homing|RPG
Return

MiscMacros:
   Gui, Tab, 5
   Gui, Add, Link,x+5 y60, AntiKek: (120+ FPS Only) <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Kek-EWO">(?)</a>
   Gui, Add, Link,, Show UI: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Show-UI">(?)</a>
   Gui, Add, Link,, Toggle CEO: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-CEO">(?)</a>
   Gui, Add, Link,, Reload Outfit: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Reload-Outfit">(?)</a>
   Gui, Add, Link,, Toggle Jobs: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Toggle-Jobs">(?)</a>
   Gui, Add, Link,, Copy Paste: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Copy-Paste">(?)</a>
   Gui, Add, Link,, MCCEO toggle: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/MCCEO-Toggle">(?)</a>
   Gui, Add, Link,, Instantly Close GTA: <a href="">(?)</a>
   Gui, Add, Link,, Be Alone: <a href="">(?)</a>
   
   If (DebugTesting)
      Gui, Add, Link,, Passive Disable Spam Toggle: <a href="">(?)</a>
   
   Gui, Add, Link,, Press a Key: <a href="https://github.com/cryleak/RyzensMacrosWiki/wiki/Press-a-Key">(?)</a>
   
   Gui, Add, Hotkey,vKekEWO x+100 y60
   Gui, Add, Hotkey,vShowUI,
   Gui, Add, Hotkey,vToggleCEO,
   Gui, Add, Hotkey,vReloadOutfit,
   Gui, Add, Hotkey,vJobs
   Gui, Add, Checkbox, gPaste2 vPaste h21
   Gui, Add, Hotkey,vMCCEO
   Gui, Add, Hotkey,vcloseGTABind
   Gui, Add, Hotkey,vbeAloneBind
   
   If (DebugTesting)
      Gui, Add, Hotkey,vPassiveDisableSpamToggle
   
   Gui, Add, Edit, vkeyToSend
   Gui, Add, Button, x-10 y-10 w1 h1 +default gAwaitKeyPress vThisDoesNotFuckingExist ; This will only trigger when you press "enter". Thanks "n-i-l-d" from the AHK forums whoever you are!
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
   
   Gui -DPIScale
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
      IniWrite,%explodeBind%,%CFG%,Keybinds,Explode Key
      IniWrite,%ThermalHelmet%,%CFG%,PVP Macros,Thermal Helmet
      IniWrite,%jetThermal%,%CFG%,PVP Macros,Jet Thermal
      IniWrite,%FastSniperSwitch%,%CFG%,PVP Macros,Fast Sniper Switch
      IniWrite,%BindSniper%,%CFG%,Keybinds,Sniper Bind
      IniWrite,%BindRifle%,%CFG%,Keybinds,Rifle Bind
      IniWrite,%BindShotgun%,%CFG%,Keybinds,Shotgun Bind
      IniWrite,%BindSMG%,%CFG%,Keybinds,SMG Bind
      IniWrite,%BindFists%,%CFG%,Keybinds,Fists Bind
      IniWrite,%EWO%,%CFG%,PVP Macros,EWO
      IniWrite,%EWOWrite%,%CFG%,PVP Macros,EWO Write
      IniWrite,%KekEWO%,%CFG%,PVP Macros,Kek EWO
      IniWrite,%EWOLookBehindKey%,%CFG%,Keybinds,EWO Look Behind Button
      IniWrite,%EWOSpecialAbilitySlashActionKey%,%CFG%,Keybinds,EWO Special Ability/Action Key
      IniWrite,%EWOMelee%,%CFG%,Keybinds,EWO Melee Key
      IniWrite,%BST%,%CFG%,PVP Macros,BST
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
      IniWrite,%antiKekMode%,%CFG%,PVP Macros,AntiKek Mode
      IniWrite,%BindRPG%,%CFG%,Keybinds,RPG Bind
      IniWrite,%BindSticky%,%CFG%,Keybinds,Sticky Bind
      IniWrite,%BindPistol%,%CFG%,Keybinds,Pistol Bind
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
      IniWrite,%closeGTABind%,%CFG%,Misc,Close GTA Bind
      IniWrite,%beAloneBind%,%CFG%,Misc,Be Alone Bind
      IniWrite,%PassiveDisableSpamToggle%,%CFG%,Misc,Passive Disable Spam Toggle
      IniWrite,%clumsyPing%,%CFG%,Debug,clumsy ping
      IniWrite,%clumsyLagMode%,%CFG%,Debug,clumsy lag mode
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
   Hotkey(closeGTABind,"CloseGTAProcesses","On")
   Hotkey(beAloneBind,"BeAlone","On")
   
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
   Process, Close, %intMenuWindow%
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
   If FileExist(CFG)
   {
      IniRead,Read_InteractionMenuKey,%CFG%,Keybinds,Interaction Menu Key
      IniRead,Read_FranklinBind,%CFG%,Keybinds,Franklin Key
      IniRead,Read_explodeBind,%CFG%,Keybinds,Explode Key
      IniRead,Read_ThermalHelmet,%CFG%,PVP Macros,Thermal Helmet
      IniRead,Read_jetThermal,%CFG%,PVP Macros,Jet Thermal
      IniRead,Read_FastSniperSwitch,%CFG%,PVP Macros,Fast Sniper Switch
      IniRead,Read_BindSniper,%CFG%,Keybinds,Sniper Bind
      IniRead,Read_BindRifle,%CFG%,Keybinds,Rifle Bind
      IniRead,Read_BindShotgun,%CFG%,Keybinds,Shotgun Bind
      IniRead,Read_BindSMG,%CFG%,Keybinds,SMG Bind
      IniRead,Read_BindFists,%CFG%,Keybinds,Fists Bind
      IniRead,Read_EWO,%CFG%,PVP Macros,EWO
      IniRead,Read_EWOWrite,%CFG%,PVP Macros,EWO Write
      IniRead,Read_KekEWO,%CFG%,PVP Macros,Kek EWO
      IniRead,Read_EWOLookBehindKey,%CFG%,Keybinds,EWO Look Behind Button
      IniRead,Read_EWOSpecialAbilitySlashActionKey,%CFG%,Keybinds,EWO Special Ability/Action Key
      IniRead,Read_EWOMelee,%CFG%,Keybinds,EWO Melee Key
      IniRead,Read_BST,%CFG%,PVP Macros,BST
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
      IniRead,Read_antiKekMode,%CFG%,PVP Macros,AntiKek Mode
      IniRead,Read_BindRPG,%CFG%,Keybinds,RPG Bind
      IniRead,Read_BindSticky,%CFG%,Keybinds,Sticky Bind
      IniRead,Read_BindPistol,%CFG%,Keybinds,Pistol Bind
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
      IniRead,Read_closeGTABind,%CFG%,Misc,Close GTA Bind
      IniRead,Read_beAloneBind,%CFG%,Misc,Be Alone Bind
      IniRead,Read_PassiveDisableSpamToggle,%CFG%,Misc,Passive Disable Spam Toggle
      IniRead,Read_clumsyPing,%CFG%,Debug,clumsy ping
      IniRead,Read_clumsyLagMode,%CFG%,Debug,clumsy lag mode
      
      GuiControl,1:,InteractionMenuKey,%Read_InteractionMenuKey%
      GuiControl,1:,FranklinBind,%Read_FranklinBind%
      GuiControl,1:,explodeBind,%Read_explodeBind%
      GuiControl,1:,ThermalHelmet,%Read_ThermalHelmet%
      GuiControl,1:,jetThermal,%Read_jetThermal%
      GuiControl,1:,FastSniperSwitch,%Read_FastSniperSwitch%
      GuiControl,1:,BindSniper,%Read_BindSniper%
      GuiControl,1:,BindRifle,%Read_BindRifle%
      GuiControl,1:,BindShotgun,%Read_BindShotgun%
      GuiControl,1:,BindSMG,%Read_BindSMG%
      GuiControl,1:,BindFists,%Read_BindFists%
      GuiControl,1:,EWO,%Read_EWO%
      GuiControl,1:,EWOWrite,%Read_EWOWrite%
      GuiControl,1:,KekEWO,%Read_KekEWO%
      GuiControl,1:,EWOLookBehindKey,%Read_EWOLookBehindKey%
      GuiControl,1:,EWOSpecialAbilitySlashActionKey,%Read_EWOSpecialAbilitySlashActionKey%
      GuiControl,1:,EWOMelee,%Read_EWOMelee%
      GuiControl,1:,BST,%Read_BST%
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
      GuiControl,1:,Reverse,%Read_Reverse%
      GuiControl,1:,ProcessCheck2,%Read_ProcessCheck2%
      GuiControl,1:,NightVision,%Read_NightVision%
      GuiControl,1:,RPGSpam,%Read_RPGSpam%
      GuiControl,1:Choose,antiKekMode,%Read_antiKekMode%
      GuiControl,1:,BindRPG,%Read_BindRPG%
      GuiControl,1:,BindSticky,%Read_BindSticky%
      GuiControl,1:,BindPistol,%Read_BindPistol%
      GuiControl,1:,TabWeapon,%Read_TabWeapon%
      GuiControl,1:,Crosshair,%Read_Crosshair%
      GuiControl,1:,CrosshairPos,%Read_CrosshairPos%
      GuiControl,1:,Jobs,%Read_Jobs%
      GuiControl,1:,Paste,%Read_Paste%
      GuiControl,1:,MCCEO,%Read_MCCEO%
      GuiControl,1:,SmoothEWO,%Read_SmoothEWO%
      GuiControl,1:,shootEWO,%Read_shootEWO%
      GuiControl,1:,customTime,%Read_customTime%
      GuiControl,1:Choose,SmoothEWOMode,%Read_SmoothEWOMode%
      GuiControl,1:Choose,BugRespawnMode,%Read_BugRespawnMode%
      GuiControl,1:,FasterSniper,%Read_FasterSniper%
      GuiControl,1:,closeGTABind,%Read_closeGTABind%
      GuiControl,1:,beAloneBind,%Read_beAloneBind%
      GuiControl,1:,PassiveDisableSpamToggle,%Read_PassiveDisableSpamToggle%
      GuiControl,1:,clumsyPing,%Read_clumsyPing%
      GuiControl,1:Choose,clumsyLagMode,%Read_clumsyLagMode%
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

NeverOnTop:
   WinSet, AlwaysOnTop, Off, ahk_exe GTA5.exe
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

ClumsyLagMode:
   GuiControlGet, clumsyLagMode
   if (clumsyLagMode = "sending")
      Control, Choose, 4, ComboBox1, ahk_pid %Gay3%
   else if (clumsyLagMode = "recieving")
      Control, Choose, 5, ComboBox1, ahk_pid %Gay3%
Return

ClumsyPing:
   GuiControlGet, clumsyPing
   ControlSetText,Edit2,%clumsyPing%,ahk_pid %Gay3%
Return

Clumsy:
   GuiControlGet, clumsyPing
   GuiControlGet, clumsyLagMode
   if (!clumsyEnabled)
   {
      Process, Close, %Gay3%
      Run, *RunAs clumsy.exe, %ConfigDirectory%\clumsy,Min,Gay3
      WinWait, ahk_pid %Gay3%
      WinGet, ID3, ID, ahk_pid %Gay3%
      WinSet, ExStyle, ^0x80, ahk_id %ID3%
      if (clumsyLagMode = "sending")
         Control, Choose, 4, ComboBox1, ahk_pid %Gay3%
      else if (clumsyLagMode = "recieving")
         Control, Choose, 5, ComboBox1, ahk_pid %Gay3%
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

ProcessExist(PID_or_Name="") ; For convenience's sake
{
   Process, Exist, % (PID_or_Name="") ? DllCall("GetCurrentProcessID") : PID_or_Name
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
   
   CalculateTime(original)
   {
      return A_TickCount - original
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
   
   ; This will send the specified key once you press K.
   AwaitKeyPress:
      Gui, Submit, NoHide
      {
         MsgBox, 0, Press K to send the key!, Press K to send the key. Use this to bind something to a random bind, up to F15 if you are using function keys. Please note that many keys are not able to be used as binds for GTA.
         Hotkey, *K, SendKey, On
      }
   Return
   
   SendKey:
      If WinActive(ahk_exe GTA5.exe)
         Send {Blind}{%keyToSend%}
      Hotkey, *K, SendKey, Off
   Return
   
   BeAlone:
      SoundPlay, %ConfigDirectory%\assets\pending.wav
      ProcessSuspend("GTA5.exe")
      Sleep 10000
      SoundPlay, %ConfigDirectory%\assets\sweeped.wav
      ProcessResume("GTA5.exe")
   Return
   
   /*
   Thanks heresy!
   https://www.autohotkey.com/board/topic/30341-process-suspendresume-exampleexe/
   Thank you for reminding me that tenerary if statements exist btw
   */
   
   ProcessSuspend(PID_or_Name)
   {
      PID := (InStr(PID_or_Name,".")) ? ProcessExist(PID_or_Name) : PID_or_Name
      
      h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
      If !h
         Return -1
      
      DllCall("ntdll.dll\NtSuspendProcess", "Int", h)
      DllCall("CloseHandle", "Int", h)
   }
   
   ProcessResume(PID_or_Name)
   {
      PID := (InStr(PID_or_Name,".")) ? ProcessExist(PID_or_Name) : PID_or_Name
      
      h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
      If !h
         Return -1
      
      DllCall("ntdll.dll\NtResumeProcess", "Int", h)
      DllCall("CloseHandle", "Int", h)
   }
   
   SendDown(amount:=1,sleepAfter:=0)
   {
      If (amount = 1)
         SendInput {Blind}{WheelDown}
      
      else if IsEven(amount) && (amount >= 2)
      {
         Loop % amount/2
         {
            Send {Blind}{down}
            SendInput {Blind}{WheelDown}
            If (amount >= 4)
               Send {Blind}{f24 up}
         }
         
      } else if not IsEven(Amount) && (amount >= 3)
      {
         Loop % (amount/2) - 0.5
         {
            Send {Blind}{down}
            SendInput {Blind}{Wheeldown}
            If (amount >= 5)
               Send {Blind}{f24 up}
         }
         If (amount = 3)
            Send {Blind}{f24 up}
         Send {Blind}{down}
      }
   }
   
   SendUp(amount:=1,sleepAfter:=0)
   {
      If (amount = 1)
         SendInput {Blind}{WheelUp}
      
      else if IsEven(amount) && (amount >= 2)
      {
         Loop % amount/2
         {
            Send {Blind}{up}
            SendInput {Blind}{WheelUp}
            If (amount >= 4)
               Send {Blind}{f24 up}
         }
         
      } else if not IsEven(Amount) && (amount >= 3)
      {
         Loop % (amount/2) - 0.5
         {
            Send {Blind}{up}
            SendInput {Blind}{WheelUp}
            If (amount >= 5)
               Send {Blind}{f24 up}
         }
         If (amount = 3)
            Send {Blind}{f24 up}
         Send {Blind}{up}
      }
      
      If IsEven(Amount)
      {
         Send % "{Blind}" . (sleepAfter = 1 ? "{f24 up}" : sleepAfter = 2 ? "{f24}" : "") ; This basically just makes it send "{Blind}{f24 up}" or "{Blind}{f24}"
      }
   }
   
   IsEven(num)
   {
      return (Num & 1) != 0 ? 0 : 1
   }
   
   /*
   DllCall("QueryPerformanceFrequency", "Int64*", freq)
   DllCall("QueryPerformanceCounter", "Int64*", CounterBefore)
   
   DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)
   MsgBox % "Elapsed QPC time is " . (CounterAfter - CounterBefore) / freq * 1000 " ms"
   */