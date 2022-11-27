/*
                                                                                                     ''''''
RRRRRRRRRRRRRRRRR                                                                                    '::::'                      MMMMMMMM               MMMMMMMM
R::::::::::::::::R                                                                                   '::::'                      M:::::::M             M:::::::M
R::::::RRRRRR:::::R                                                                                  ':::''                      M::::::::M           M::::::::M
RR:::::R     R:::::R                                                                                ':::'                        M:::::::::M         M:::::::::M
  R::::R     R:::::Ryyyyyyy           yyyyyyyzzzzzzzzzzzzzzzzz    eeeeeeeeeeee    nnnn  nnnnnnnn    ''''       ssssssssss        M::::::::::M       M::::::::::M  aaaaaaaaaaaaa      ccccccccccccccccrrrrr   rrrrrrrrr      ooooooooooo       ssssssssss
  R::::R     R:::::R y:::::y         y:::::y z:::::::::::::::z  ee::::::::::::ee  n:::nn::::::::nn           ss::::::::::s       M:::::::::::M     M:::::::::::M  a::::::::::::a   cc:::::::::::::::cr::::rrr:::::::::r   oo:::::::::::oo   ss::::::::::s
  R::::RRRRRR:::::R   y:::::y       y:::::y  z::::::::::::::z  e::::::eeeee:::::een::::::::::::::nn        ss:::::::::::::s      M:::::::M::::M   M::::M:::::::M  aaaaaaaaa:::::a c:::::::::::::::::cr:::::::::::::::::r o:::::::::::::::oss:::::::::::::s
  R:::::::::::::RR     y:::::y     y:::::y   zzzzzzzz::::::z  e::::::e     e:::::enn:::::::::::::::n       s::::::ssss:::::s     M::::::M M::::M M::::M M::::::M           a::::ac:::::::cccccc:::::crr::::::rrrrr::::::ro:::::ooooo:::::os::::::ssss:::::s
  R::::RRRRRR:::::R     y:::::y   y:::::y          z::::::z   e:::::::eeeee::::::e  n:::::nnnn:::::n        s:::::s  ssssss      M::::::M  M::::M::::M  M::::::M    aaaaaaa:::::ac::::::c     ccccccc r:::::r     r:::::ro::::o     o::::o s:::::s  ssssss
  R::::R     R:::::R     y:::::y y:::::y          z::::::z    e:::::::::::::::::e   n::::n    n::::n          s::::::s           M::::::M   M:::::::M   M::::::M  aa::::::::::::ac:::::c              r:::::r     rrrrrrro::::o     o::::o   s::::::s
  R::::R     R:::::R      y:::::y:::::y          z::::::z     e::::::eeeeeeeeeee    n::::n    n::::n             s::::::s        M::::::M    M:::::M    M::::::M a::::aaaa::::::ac:::::c              r:::::r            o::::o     o::::o      s::::::s
  R::::R     R:::::R       y:::::::::y          z::::::z      e:::::::e             n::::n    n::::n       ssssss   s:::::s      M::::::M     MMMMM     M::::::Ma::::a    a:::::ac::::::c     ccccccc r:::::r            o::::o     o::::ossssss   s:::::s
RR:::::R     R:::::R        y:::::::y          z::::::zzzzzzzze::::::::e            n::::n    n::::n       s:::::ssss::::::s     M::::::M               M::::::Ma::::a    a:::::ac:::::::cccccc:::::c r:::::r            o:::::ooooo:::::os:::::ssss::::::s
R::::::R     R:::::R         y:::::y          z::::::::::::::z e::::::::eeeeeeee    n::::n    n::::n       s::::::::::::::s      M::::::M               M::::::Ma:::::aaaa::::::a c:::::::::::::::::c r:::::r            o:::::::::::::::os::::::::::::::s
R::::::R     R:::::R        y:::::y          z:::::::::::::::z  ee:::::::::::::e    n::::n    n::::n        s:::::::::::ss       M::::::M               M::::::M a::::::::::aa:::a cc:::::::::::::::c r:::::r             oo:::::::::::oo  s:::::::::::ss
RRRRRRRR     RRRRRRR       y:::::y           zzzzzzzzzzzzzzzzz    eeeeeeeeeeeeee    nnnnnn    nnnnnn         sssssssssss         MMMMMMMM               MMMMMMMM  aaaaaaaaaa  aaaa   cccccccccccccccc rrrrrrr               ooooooooooo     sssssssssss
                          y:::::y
                         y:::::y
                        y:::::y
                       y:::::y
                      yyyyyyy

You can add your own macros in here. Put them in here and they will work, hopefully...
Let me know if they don't work
I did this because I want source code for my shit to be hidden since a few people like to steal my shit.
These are kind of like lua scripts in mod menus, except you can't mod people with this shit, hopefully...
Scroll down for tips!

HOTKEYS:
*/
Gosub, DoNotRemove ; If you are worried about what this does, scroll down to the very bottom of the script. DO NOT REMOVE THIS!. It will break the "Edit Dynamic Script" button in the Launcher.
Hotkey, *F24, Macro1, UseErrorLevel ; Binds the macro to F24. Swap out F24 for anything to change it.
Hotkey, *F23, Macro2, UseErrorLevel ; Binds the macro to F23. Swap out F23 for anything to change it.
Hotkey, *F22, Macro3, UseErrorLevel ; Binds the macro to F22. Swap out F22 for anything to change it.
Hotkey, *F21, Macro4, UseErrorLevel ; Binds the macro to F21. Swap out F21 for anything to change it.
Hotkey, *F20, Macro5, UseErrorLevel ; Binds the macro to F20. Swap out F20 for anything to change it.
Hotkey, *F19, Macro6, UseErrorLevel ; Binds the macro to F19. Swap out F19 for anything to change it.
Hotkey, *F18, Macro7, UseErrorLevel ; Binds the macro to F18. Swap out F18 for anything to change it.
Return

; Example macro that gives you armor from CEO menu
Macro1: ; The label for the macro.
    Send {Blind}{%InteractionMenuKey%} ; This is the interaction menu key, use this instead of M for ambiguity. Also, you can have all your inputs in the same line. This is just so I can make a comment for help.
    Send {Blind}{enter}{down 4}{enter}{down 3}{enter}
return

; IMPORTANT: Check this if you want a CEO Mode macro so it works when you aren't CEO.
Macro2: ; same shit
    GuiControlGet, CEOMode ; Checks if CEOMode is on
    If (CEOMode = 0) {
        Send {Blind}{%InteractionMenuKey%}{down 2}{enter} ; Put the non CEO macro here (remove 1 Down key usually)
    }
    else {
        Send {Blind}{%InteractionMenuKey%}{down 3}{enter} ; CEO Macro here
    }
    Send {Blind}{down 5}{enter}{right}{up}{enter} ; Put the rest of the macro here, once you no longer need to make sure you are CEO or not.
return

Macro3:
    Send {Blind}{f24}
Return

Macro4:
    Send {Blind}{f24}
Return

Macro5:
    Send {Blind}{f24}
Return

Macro6:
    Send {Blind}{f24}
Return

Macro7:
    Send {Blind}{f24}
Return

/*
                             
         tttt            iiii                                       
      ttt:::t           i::::i                                      
      t:::::t            iiii                                       
      t:::::t                                                       
ttttttt:::::ttttttt    iiiiiii ppppp   ppppppppp       ssssssssss   
t:::::::::::::::::t    i:::::i p::::ppp:::::::::p    ss::::::::::s  
t:::::::::::::::::t     i::::i p:::::::::::::::::p ss:::::::::::::s 
tttttt:::::::tttttt     i::::i pp::::::ppppp::::::ps::::::ssss:::::s
      t:::::t           i::::i  p:::::p     p:::::p s:::::s  ssssss 
      t:::::t           i::::i  p:::::p     p:::::p   s::::::s      
      t:::::t           i::::i  p:::::p     p:::::p      s::::::s   
      t:::::t    tttttt i::::i  p:::::p    p::::::pssssss   s:::::s 
      t::::::tttt:::::ti::::::i p:::::ppppp:::::::ps:::::ssss::::::s
      tt::::::::::::::ti::::::i p::::::::::::::::p s::::::::::::::s 
        tt:::::::::::tti::::::i p::::::::::::::pp   s:::::::::::ss  
          ttttttttttt  iiiiiiii p::::::pppppppp      sssssssssss    
                                p:::::p                             
                                p:::::p                             
                               p:::::::p                            
                               p:::::::p                            
                               p:::::::p                            
                               ppppppppp                            

Instead of using {m} as an example for the Interaction Menu key, you can instead use the variable {%InteractionMenuKey%}. This helps your macros keep working even if you switch binds.
You can do almost anything with these macros, including very advanced code, if you want to. You don't specifically need to use a Hotkey, you can create Functions inside of here, and much more. If you have any questions, ask me.
You could even make code that interacts with my macros, although how you would do that, I don't know. A full list of Variables that are available to you in your coding adventures can be found below:
EWOLookBehindKey (Looking backwards bind, usually C)
EWOSpecialAbilitySlashActionKey (Quick action bind, in the keybinds settings ingame, it is referred to as Special Ability key).
InteractionMenuKey
You can also use every single hotkey as a variable, altough the names of those may be a bit harder to find. It is usually the same as the name in the Configs file, without spaces. You can use MsgBox to check, which will make a box show up with whatever contents the variable has.
Check the documentation to figure out how to use MsgBox.



*/


















































































DoNotRemove: ; DO NOT REMOVE THIS, IT WILL BREAK SHIT IF YOU DO
If not (RunningInScript = 1) { ; DO NOT REMOVE THIS, IT WILL BREAK SHIT IF YOU DO
    Edit ; DO NOT REMOVE THIS, IT WILL BREAK SHIT IF YOU DO
    ExitApp ; DO NOT REMOVE THIS, IT WILL BREAK SHIT IF YOU DO
} ; DO NOT REMOVE THIS, IT WILL BREAK SHIT IF YOU DO
Return ; DO NOT REMOVE THIS, IT WILL BREAK SHIT IF YOU DO