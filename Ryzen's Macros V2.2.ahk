;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL

#NoEnv                           ; Claims to improve performance, not sure what it actually does.
#SingleInstance, force           ; You can't start multiple instances of the macro with this on
#IfWinActive ahk_class grcWindow ; Disables hotkeys when alt-tabbed or GTA is closed. Restart macro if you decide to restart GTA with this enabled.
#IfWinActive Grand Theft Auto V  ; Same as above, just makes it more reliable.
#MaxThreadsPerHotkey 1           ; Doesn't increase speed, just improves the macro overall.
#MaxThreads 99999                ; Increases speed
#MaxThreadsBuffer On             ; Doesn't matter as long as MaxThreadsPerHotkey is 1
#MaxHotkeysPerInterval 99000000  ; Also increases speed
#KeyHistory 0                    ; Claims to increase speed 
#HotkeyInterval 99000000         ; Also increases speed
#Persistent                      ; Keeps the script running
ListLines Off                    ; Also claims to increase speed
SetDefaultMouseSpeed, 0          ; Could theoretically increase speed.
SetBatchLines, -1                ; Also increases speed
SetKeyDelay, -1, -1              ; Also increases speed 
SetWinDelay, -1                  ; Also increases speed
SetControlDelay, -1              ; Also increases speed
Process, Priority, , H           ; Sets the task priority of these macros to high, which in theory should improve speeds.
Process, Priority, GTA5.exe, H   ; Sets the task priority of GTA V to high, which in theory should improve FPS.
SetWorkingDir %A_ScriptDir%      ; Ensures a consistent starting directory.
Goto, DiscordPriority            ; Automatically excecutes DiscordPriority when you start the script, which sets Discords's priority to High, which should make it more usable now that we increased the priority of GTA to High, and changes some other applications to Low.
Macro:
;                                                                                          ———Assign Hotkeys———

THERMALHELM := ","            ;
FastSniperSwitch := "*$F1"    ;
EWO := "*$<"                  ;
BST := "*$§"                  ;
Ammo := "*$¨"                 ;
FastRespawn := "*$F3"         ;
Suspend := "F2"               ;
GTAHax := "PrintScreen"       ;
HelpWhatsThis := "F5"	      ;
EssayAboutGTA := "F7"         ;
ClipboardSpam := "F8"         ;
ShutUp := "F6"                ; 
DisableCapsLock := "Capslock" ; 
;                                                                                           ———Hotkey Code———

Hotkey, %THERMALHELM%, THERMALHELM           ;
Hotkey, %FastSniperSwitch%, FastSniperSwitch ;
Hotkey, %EWO%, EWO                           ;
Hotkey, %BST%, BST                           ;
Hotkey, %Ammo%, Ammo                         ;
Hotkey, %FastRespawn%, FastRespawn           ;
Hotkey, %Suspend%, Suspend                   ;
Hotkey, %GTAHax%, GTAHax                     ;
Hotkey, %HelpWhatsThis%, HelpWhatsThis	     ; 
Hotkey, %EssayAboutGTA%, EssayAboutGTA       ;
Hotkey, %ClipboardSpam%, ClipboardSpam       ;
Hotkey, %ShutUp%, ShutUp                     ; 
Hotkey, %DisableCapsLock%, DisableCapsLock   ; 
return
;                                                                                           ———Macro Code———

THERMALHELM: ; Toggles thermal helmet. Hold the "L" key in order to use it if you are not in a CEO or MC.
{
 If GetKeyState("L", "L") {
  Send, m{down 3}{enter}
 } Else {
  Send, m{down 4}{enter}
 }
send {down}{enter}
sleep 50
send {space}m
}
return

FastSniperSwitch: ; Switches from sniper to marksman and back to sniper rapidly. You must have the normal sniper rifle removed from your loadout for this to work.
send {1}
sleep 20
send {lbutton}
sleep 20
send {1}
sleep 20
send {lbutton}
return

EWO: ; Kills yourself instantly. Now has a 5 minute cooldown unless using GTAHax or something similar.
send {lbutton}
sendinput {end down}{c down}{lbutton up}{rbutton up}{enter down}{g down}
send m{up}
sendinput {wheelup}{enter up}
send {enter 4}
sendinput {c up}{< up}{g up}{end up}
return

BST: ; Drops BST. Must be in CEO obviously.
send m{enter}{down 4}{enter}{down}{enter}
return

Ammo: ; Buys ammo. Hold the "L" key in order to use it if you are not in a CEO or MC.
{
 If GetKeyState("L", "L") {
  Send, m{down 2}{enter}
 } Else {
  Send, m{down 3}{enter}
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
send {enter 2} ; end of cycle 6
send m
}
return 

FastRespawn: ; Respawns extremely fast.
send {lbutton 30}
return

Suspend: ; Suspends the entire macro until you press it again.
Suspend
return
;                                             EXTREMELY LONG AND CONFUSING MACROS BELOW, DON'T MESS WITH THEM UNLESS YOU WANT TO HAVE A BRAIN HEMMORAGE WHEN YOU TRY TO UNDERSTAND HOW THEY WORK























GTAHax: ; Applies the EWO no cooldown code using GTAHax.
sendinput {printscreen up}
Run, GTAHaXUI.exe, %A_ScriptDir%\Libraries, , Max
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
sendinput {f5 up}
send {t}
send d
sendinput on’t care {Numpadadd} didn't ask {Numpadadd} cry a
send b
sendinput out it {Numpadadd} stay mad {Numpadadd} get real {Numpadadd} L {Numpadadd} 
send {space}
sendinput mald {Numpadadd} seethe {Numpadadd} cope harder {Numpadadd}
send {space}
sendinput hoes mad {Numpadadd} basic {Numpadadd} skill issue{Numpadadd} 
send {space}
sendinput {Numpadadd} ratio
send {enter}
send {t}
send {Numpadadd} 
sendinput {space}you fell off {Numpadadd} the audacity 
send {space}{Numpadadd}
sendinput {space}triggered {Numpadadd} any askers {Numpadadd} redp
send i
sendinput lled {Numpadadd} get a life {Numpadadd} ok and? 
send {space}
sendinput {Numpadadd} cringe {Numpadadd} touch grass {Numpadadd} donow
send a
sendinput lled {Numpadadd} not based
send {enter}
send {t}
send {Numpadadd} 
sendinput {space}you’re a (insert stereotype)
send {space}
sendinput {Numpadadd} not funny didn't laugh {Numpadadd} you
send ’
sendinput re* {Numpadadd} grammar issue {Numpadadd} go outsi
send d
sendinput e {Numpadadd} get good {Numpadadd} reported
send {enter}
send {t}
send {Numpadadd}
sendinput {space}ad hominem {Numpadadd} GG{shift down}1{shift up} {Numpadadd} ur mom
send {enter}
return

EssayAboutGTA: ; Complains about how bad the FPS is in GTA Online.
sendinput {f7 up}
send {t}
send w
sendinput hy is my fps so shlt this game
send {space}h
sendinput as terrible optimization its c
send h
sendinput inese as shlt man i hate this
send {space}g
sendinput ame im gonna swat the r* headq
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
send {space}m
sendinput ulti billion 
send {enter}
send {t}
send d
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
sendinput utdated gta online is and how
send b
sendinput ad the fps is fr its so cpu bo 
send u
sendinput nd its stupid and thanks for{space}
send l
sendinput istening to my essay about how
send {space}
sendinput bad gta online i
send s
send {enter}
return

ClipboardSpam: ; Spams whatever your clipboard is. Copy anything to your clipboard for it to work.
sendinput {f8 up}
send t{shift up}
sendinput {raw}%Clipboard%
Send {enter}
return

ShutUp: ; Spams "shut up"
sendinput {f6 up}
send t{shift up}
sendinput {raw}shut up
send {enter}
return

DisableCapsLock: ; Disables CapsLock, so you can't press it.
send {CapsLock}
setcapslockstate, off
return

DiscordPriority: ; Sets the process priority of various applications.
SetDiscordPriority:
{
processName := "Discord.exe"

PIDs := EnumProcessesByName(processName)
for k, PID in PIDs
   Process, Priority, % PID, H

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
Goto, Macro

;                                                                                        ———END OF CODE. INFO AND OTHER STUFF BELOW———

; Info:
; Welcome to these fast and otherwise terrible macros! This is a heavily modified version of the macros found on the Motmus Discord server. The macros were pretty bad, so I decided to rewrite basically all the macros, only the system to bind keys has been kept.
; Contact me on Discord for more help, but please check the information below first, and don't be so lazy that you can't read my wall of text. (smilla kult#4725)


; NOTES:
; Chat macros are way slower when using Flawless widescreen with GTA V. I don't know why this is, but it makes them far slower. Watch out for that, I guess. Also makes EWO slower.
; I know the standard binds are absolute dogshit, but that is because I'm left handed. If someone wants to suggest good default binds for right handed people, which is basically everyone but you already know that, let me know, i'll change them, and credit you.
; These macros are for PVP ONLY. They may also be useful for non-PVP purposes, but this is not a macro with 5000 different hotkeys to do every thing imaginable.
; DO NOT delete the "Libraries" folder or else the script will crash when you try to use GTAHax.

; KNOWN ISSUES:
; No.


; Changelog:
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
; Q: How do I change the bindings of the macros?
; A: Change the keys under the "Assign Hotkeys" section to what you want. Put the characters *$ first if you want to be able to use it while holding SHIFT, then enter the key you want to bind it to. Below here is a example.
; Example: BST := "*$X"
; Q: How do I change my weapon loadout? 
; A: Go to your CEO office or any other place with a "Weapon Locker" and then remove weapons that you don't need/want.
; Q: How do I remove macros? 
; A: Go up to the "Hotkey Code" Section, and remove the specific (Hotkey, %EXAMPLE%, EXAMPLE;) that you don't want. Now, remove that code, and then, go up to the "Assign Hotkeys" section and remove the corressponding bind, or else the macro will not start.

