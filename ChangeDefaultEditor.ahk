If not A_IsAdmin{
Run *RunAs "%A_ScriptFullPath%" ; causes script to reload and be run as admin
}
#SingleInstance, Force ; prevent's 2nd prompt to change the editor
InputBox, UserInput, Default AutoHotKey Editor change, Please enter a full path name for your editor
if ErrorLevel
    MsgBox, Ah... Don't want - so bye :)
else
{
    MsgBox, Changing default AutoHotKey editor to "%UserInput%"
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT, AutoHotkeyScript\Shell\Edit\Command,, "%UserInput%" "`%1"
}