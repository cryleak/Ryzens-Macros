#IfWinActive ahk_class grcWindow
SetBatchLines, -1
Process, Priority, , L

send {lbutton 30}
ExitApp