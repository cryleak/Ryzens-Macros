if (!A_IsAdmin) ; Runs the script as an admin.
    Run *RunAs "%A_ScriptFullPath%"

#InstallKeybdHook
#InstallMouseHook
#SingleInstance Force
SetKeyDelay, 50, 50

^!1::
    Send {Blind}{Numpad1}
return

^!2::
    Send {Blind}{Numpad2}
return

^!3::
    Send {Blind}{Numpad3}
return

^!4::
    Send {Blind}{Numpad4}
return

^!5::
    Send {Blind}{Numpad5}
return

^!6::
    Send {Blind}{Numpad6}
return

^!7::
    Send {Blind}{Numpad7}
return

^!8::
    Send {Blind}{Numpad8}
return

^!9::
    Send {Blind}{Numpad9}
return

^!+::
    Send {Blind}{NumpadAdd}
return

^!-::
    Send {Blind}{NumpadSub}
return

^!Enter::
    Send {Blind}{NumpadEnter}
return

^!.::
    Send {Blind}{NumpadDot}
return