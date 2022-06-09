#NoEnv
#IfWinActive ahk_exe javaw.exe
SetBatchLines, -1
SetKeyDelay, 25, 25
#Persistent
#MaxThreadsPerHotkey 1
#MaxThreads 1
#MaxThreadsBuffer Off
;
aotetp:		; 
*$2::
Send 2
Sleep 100
Send {rbutton}
Sleep 100
Send 1
return ;

;
roguesword:		; 
*$4::
Send 4
Sleep 100
Send {rbutton}
Sleep 100
Send 1
return ;

;
wandofmending:		; 
*$5::
Send 5
Sleep 100
Send {rbutton}
Sleep 100
Send 1
return ;

;
radiantpowerorb:		; 
*$7::
Send 7
Sleep 100
Send {rbutton}
Sleep 100
Send 1
return ;