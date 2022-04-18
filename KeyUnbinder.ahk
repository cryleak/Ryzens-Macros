#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.


Delete := "K"
Hotkey, *$%Delete%, Delete

Delete:
send {f23 down}
sleep 100
send {f23 up}
return