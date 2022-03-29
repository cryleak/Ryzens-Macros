; You can add your own macros in here. Put them in here and they will work, hopefully...
; Let me know if they don't work
; I did this because I want source code for my shit since a few people like to steal my shit. I think you know who I am talking about 
; blah blah blah cry about it.
; These are kind of like lua scripts in mod menus, except you can't mod people with this shit, hopefully...


; Example macro that gives you armor from CEO menu
*$F23:: ; Change this to something. If you want to be able to press it while holding SHIFT, add *$ before it.
; you can add a ; to exclude it from the script and to label it this way.
send {%InteractionMenuKey%} ; This is the interaction menu key, use this instaad of m for ambiguity.
send {enter}{down 4}{enter}{down 3}{enter}
return

; IMPORTANT: Check this if you want a CEO Mode macro so it works when you aren't CEO.
*$F22:: ; same shit
GuiControlGet, CEOMode ; Checks if CEOMode is on
If (CEOMode = 0)
{
; Put the non CEO macro here (remove 1 Down key usually)
return ; Remove this if you want it to work in non CEO.
} 
else
{
send {%InteractionMenuKey%}{enter}{down 4}{enter}{down}{enter} ; Put the full macro here if you only want it to work in CEO, put the first {down} commands and {enter} command.
}
send {down 4}{enter}{down 3}{enter} ; Put the rest of the macro here unless it is for something in the CEO menu.
return