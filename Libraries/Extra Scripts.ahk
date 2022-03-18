;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
;                                                               GO TO THE BOTTOM OF THE SCRIPT FOR HELP, INFO AND A QUICK TUTORIAL
; You can add your own macros in here. Put them in here and they will work, hopefully...
; Let me know if they don't work
; I did this because I want source code for my shit since a few people like to steal my shit. I think you know who I am talking about 
; blah blah blah cry about it.
; These are kind of like lua scripts in mod menus, except you can't mod people with this shit, hopefully...

;                                                                                          ———Assign Hotkeys———

Example := "F23"              ; Put your bindings here

;                                                                                           ———Hotkey Code———

Hotkey, %Example%, Example           ; Put the code to make it actually work here.
return
;                                                                                           ———Macro Code———
Example: ; Example macro that presses M and then up.
send {m}{up}
return















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
; Q: How do I change the bindings of the macros?
; A: Change the keys under the "Assign Hotkeys" section to what you want. Put the characters *$ first if you want to be able to use it while holding SHIFT, then enter the key you want to bind it to. Below here is a example.
; Example: BST := "*$X"
; Q: How do I add new macros?
; A: Go into the libraries folder included in the ZIP file, and right click on Extra Scripts.ahk. Click on "edit". Now, figure it out on your own it's not that hard i have an example there already
; Q: How do I change my weapon loadout? 
; A: Go to your CEO office or any other place with a "Weapon Locker" and then remove weapons that you don't need/want.
; Q: How do I remove macros? 
; A: Uh.... Fuck this it is way harder now just contact me on discord if you want to remove macros. Unless you're talking about the extra scripts, then you do the following:
; Go up to the "Hotkey Code" Section, and remove the specific (Hotkey, %EXAMPLE%, EXAMPLE;) that you don't want.
; Now, remove that code, and then, go up to the "Assign Hotkeys" section and remove the corressponding bind, or else the macro will not start.