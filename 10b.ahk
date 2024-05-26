if (!A_IsAdmin) ; Runs the script as an admin.
    Run *RunAs "%A_ScriptFullPath%"
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
    DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ; yes
    SetDefaultMouseSpeed, 0 ; Something
    SetKeyDelay, -1, -1 ; Sets key delay to the lowest possible, there is still delay due to the keyboard hook in GTA, but this makes it excecute as fast as possible WITHOUT skipping keystrokes. Set this a lot higher if you uninstalled the keyboard hook using mods.
    SetWinDelay, -1 ; After any window modifying command, the script has a built in delay. Fuck delays.
    SetMouseDelay, -1
    SetControlDelay, 0 ; After any control modifying command, for example; ControlSend, there is a built in delay. Set to 0 instead of -1 because having a slight delay may improve reliability, and is unnoticable anyways.
    SetBatchLines, -1 ; Removes the built in 10ms Sleep that happens after every line of code normally. It should never Sleep now. It comes at the cost of CPU usage, but anyone with a half decent PC should be fine.
    
    fuckyou = 0
    fuckyou2 = 0
    CheatCodeKey := "§"
    
    Hotkey, *K, Why, P21473647
    SetTimer, SpamShit, 0, -2147483648
    
    Goto Testing
    
    Why:
        global originalTime := A_TickCount
        fuckyou := !fuckyou
        if (fuckyou = 0)
        {
            Minutes := TimeRan/60
            Msgbox Time ran is %Minutes% minutes.
        }
    Return
    
    SpamShit:
        if (fuckyou = 1) && WinActive("ahk_exe GTA5.exe")
        {
            TimeRan := (A_TickCount - originalTime)/1000
            ToolTip, Amount of time you have run this is %TimeRan% seconds
            Send {Blind}{%CheatCodeKey%}
            SendInput {Blind}{enter down}`10b
            Send {Blind}{enter up}
        } Else if (fuckyou = 0)
        {
            ToolTip
        }
    Return
    
    Why2:
        global originalTime := A_TickCount
        fuckyou2 := !fuckyou2
    Return
    
    SpamShit2:
        if (fuckyou2 = 1) && WinActive("ahk_exe GTA5.exe")
        {
            TimeRan := A_TickCount - originalTime
            ToolTip, %TimeRan%
            Send {Blind}{%CheatCodeKey%}
            SendInput {Blind}10b
            Send {Blind}{enter}
            if (TimeRan >= 4000)
                fuckyou2 := !fuckyou2
        } Else if (fuckyou = 0)
            ToolTip
    Return
    
    Testing:
    ; Hotkey, *J, Why2, P21473647
    ; SetTimer, SpamShit2, 0, -2147483648
    Return