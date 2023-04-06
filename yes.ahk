#noenv
#persistent
#singleinstance force
#ifwinactive ahk_class grcWindow
#maxhotkeysperinterval 99000000
#hotkeyinterval 99000000
#maxthreads 99999
#maxthreadsperhotkey 1
#keyhistory 0
#installkeybdhook

listlines off
setbatchlines -1
setkeydelay -1, -1
setdefaultmousespeed 0
setwindelay -1
setcontroldelay -1
process priority,, high
process priority, GTA5.exe, high
Return

*q::
Send {LButton down}{RButton down}{RButton up}{LButton up}
sendinput {r down}{c down}{enter down}
send {m}{up 2}
sendinput {k down}{enter up}{c up}{r up}
sleep, 150
sendinput {k up}
SetCapsLockState, Off
return