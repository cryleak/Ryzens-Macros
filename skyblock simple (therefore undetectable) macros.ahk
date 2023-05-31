if (!A_IsAdmin) ; Runs the script as an admin.
    Run *RunAs "%A_ScriptFullPath%"
#SingleInstance, force ; Forces single instance
#HotkeyModifierTimeout -1 ; Changes hotkey modifier timeout, maybe does something lmao
#IfWinActive ahk_exe javaw.exe ; Hotkeys will only work if you are tabbed in.
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
    SetTimer, KeyDown, 5000, 217483647
    
    Hotkey, *§, GhostBlock, UseErrorLevel
    Hotkey, *F4, WandOfHealing, UseErrorLevel
    ; Hotkey, *F2, Florid, UseErrorLevel
    Hotkey, *<, Farm, UseErrorLevel
    
    toggle := 0
    swordBind := 1 ; This can be anything except for the pickaxe bind
    pickaxeBind := 6
    wandBind := 5
    floridBind := 3
    aoteBind := 2
    direction := "d" ; change to "a" for other direction
    Return
    
    GhostBlock:
        Send {Blind}{%swordBind%}
        Sleep(60)
        Send {Blind}{%pickaxeBind%}
        SendInput {Blind}{lbutton down}
        Send {Blind}{f24 up}
        SendInput {Blind}{lbutton up}
        Sleep(60)
    Return
    
    WandOfHealing:
        Send {Blind}{%wandBind%}
        SendInput {Blind}{rbutton down}
        Send {Blind}{f24 up}
        SendInput {Blind}{rbutton up}
        Sleep(60)
        Send {Blind}{%swordBind%}
    Return
    
    Florid:
        Send {Blind}{%floridBind%}
        SendInput {Blind}{rbutton down}
        Send {Blind}{f24 up}
        SendInput {Blind}{rbutton up}
        Sleep(60)
        Send {Blind}{%swordBind%}
    Return
    
    Farm:
        toggle := !toggle
        Send {Blind}t
        if (!toggle)
        {
            msgbox,0,disabled!!!!!!!!,disabled!!!!!!,0.6
            Sleep(500)
            SendInput {Blind}{%direction% up}{lbutton up}
        } else
        {
            msgbox,0,enabled!!!!!!!!,enabled!!!!!!,0.6
            Sleep(500)
        }
        Send {Blind}{esc}
        Goto KeyDown
    Return
    
    KeyDown:
        If (toggle)
            SendInput {Blind}{%direction% down}{lbutton down}
    Return
    
    Sleep(ms)
    {
        DllCall("Sleep",UInt,ms)
    }