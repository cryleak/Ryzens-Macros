SendMode Input
SetBatchLines -1
#NoEnv
#NoTrayIcon
#SingleInstance Off
PreprocessScript(ByRef ScriptText, AhkScript, ExtraFiles, FileList := "", FirstScriptDir := "", Options := "", iOption := 0)
{	global DirDone, BinFile
    SplitPath, AhkScript, ScriptName, ScriptDir
    if !IsObject(FileList)
    {
        FileList := [AhkScript]
        ScriptText := "; <COMPILER: v" A_AhkVersion ">`n"
        FirstScriptDir := ScriptDir
        IsFirstScript := true
        Options := { comm: ";", esc: "``", directives: [] }
        OldWorkingDir := A_WorkingDir
        SetWorkingDir, %ScriptDir%
        global priorlines := []
    }
    oldLineFile := DerefIncludeVars.A_LineFile
    DerefIncludeVars.A_LineFile := AhkScript
    if SubStr(DerefIncludeVars.A_AhkVersion,1,1)=2
    {
        OldWorkingDirv2 := A_WorkingDir
        SetWorkingDir %ScriptDir%
    }
    IfNotExist, %AhkScript%
        if !iOption
            Util_Error((IsFirstScript ? "Script" : "#include") " file cannot be opened.", 0x32, """" AhkScript """")
        else return
            cmtBlock := false, contSection := false, ignoreSection := false
    Loop, Read, %AhkScript%
    {
        tline := Trim(A_LoopReadLine)
        if !cmtBlock
        {
            if ignoreSection
            {
                if StrStartsWith(tline, Options.comm "@Ahk2Exe-IgnoreEnd")
                    ignoreSection := false
                continue
            }
            if !contSection
            {
                if StrStartsWith(tline, Options.comm)
                {
                    StringTrimLeft, tline, tline, % StrLen(Options.comm)
                    if !StrStartsWith(tline, "@Ahk2Exe-")
                        continue
                    StringTrimLeft, tline, tline, 9
                    if StrStartsWith(tline, "IgnoreBegin")
                        ignoreSection := true
                    else if Trim(tline) != "" && !(DirDone[A_Index] && IsFirstScript)
                        Options.directives.Insert(RegExReplace(tline
                            , "\s+" RegExEscape(Options.comm) ".*$"))
                            , priorlines.Push(priorline)
                    continue
                }
                else if tline =
                    continue
                else if StrStartsWith(tline, "/*")
                {
                    if !StrStartsWith(tline, "/*@Ahk2Exe-Keep")
                        if !(SubStr(DerefIncludeVars.A_AhkVersion,1,1)=2 && tline~="\*/$")
                            cmtBlock := true
                    continue
                }
                else if StrStartsWith(tline, "*/")
                    continue
            }
            if StrStartsWith(tline, "(") && !IsFakeCSOpening(SubStr(tline,2))
                contSection := true
            else if StrStartsWith(tline, ")")
                contSection := false
            priorline := tline
            tline := RegExReplace(tline, "\s+" RegExEscape(Options.comm) ".*$", "")
            if !contSection
                && RegExMatch(tline, "i)^#Include(Again)?[ \t]*[, \t]\s*(.*)$", o)
            {
                if InStr(o2,":",,3)
                    continue
                IsIncludeAgain := (o1 = "Again")
                IgnoreErrors := false
                IncludeFile := o2
                if RegExMatch(IncludeFile, "\*[iI]\s+?(.*)", o)
                    IgnoreErrors := true, IncludeFile := Trim(o1)
                if RegExMatch(IncludeFile, "^<(.+)>$", o)
                {
                    if IncFile2 := FindLibraryFile(o1, FirstScriptDir)
                    {
                        IncludeFile := IncFile2
                        goto _skip_findfile
                    }
                }
                IncludeFile := DerefIncludePath(IncludeFile, DerefIncludeVars)
                if InStr(FileExist(IncludeFile), "D")
                {
                    SetWorkingDir, %IncludeFile%
                    continue
                }
                _skip_findfile:
                    IncludeFile := Util_GetFullPath(IncludeFile)
                    AlreadyIncluded := false
                    for k,v in FileList
                        if (v = IncludeFile)
                        {
                            AlreadyIncluded := true
                            break
                        }
                    if(IsIncludeAgain || !AlreadyIncluded)
                    {
                        if !AlreadyIncluded
                            FileList.Insert(IncludeFile)
                        PreprocessScript(ScriptText, IncludeFile, ExtraFiles, FileList, FirstScriptDir, Options, IgnoreErrors)
                    }
            }else if !contSection && tline ~= "i)^FileInstall[, \t]"
            {
                if tline ~= "^\w+\s+(:=|\+=|-=|\*=|/=|//=|\.=|\|=|&=|\^=|>>=|<<=)"
                    continue
                EscapeChar := Options.esc
                EscapeCharChar := EscapeChar EscapeChar
                EscapeComma := EscapeChar ","
                EscapeTmp := chr(2)
                EscapeTmpD := chr(3)
                StringReplace, tline, tline, %EscapeCharChar%, %EscapeTmpD%, All
                StringReplace, tline, tline, %EscapeComma%, %EscapeTmp%, All
                if !RegExMatch(tline, "i)^FileInstall[ \t]*[, \t][ \t]*([^,]+?)[ \t]*(,|$)", o) || o1 ~= "[^``]%"
                    Util_Error("Error: Invalid ""FileInstall"" syntax found. Note that the first parameter must not be specified using a continuation section.", 0x12)
                _ := Options.esc
                StringReplace, o1, o1, %_%`%, `%, All
                StringReplace, o1, o1, %_%`,, `,, All
                StringReplace, o1, o1, %_%%_%,, %_%,, All
                StringReplace, o1, o1, %EscapeTmp%, `,, All
                StringReplace, o1, o1, %EscapeTmpD%, %EscapeChar%, All
                StringReplace, tline, tline, %EscapeTmp%, %EscapeComma%, All
                StringReplace, tline, tline, %EscapeTmpD%, %EscapeCharChar%, All
                ExtraFiles.Insert(o1)
                ScriptText .= tline "`n"
            }else if !contSection && RegExMatch(tline, "i)^#CommentFlag\s+(.+)$", o)
                Options.comm := o1, ScriptText .= tline "`n"
            else if !contSection && RegExMatch(tline, "i)^#EscapeChar\s+(.+)$", o)
                Options.esc := o1, ScriptText .= tline "`n"
            else if !contSection && RegExMatch(tline, "i)^#DerefChar\s+(.+)$", o)
                Util_Error("Error: #DerefChar is not supported.", 0x21)
            else if !contSection && RegExMatch(tline, "i)^#Delimiter\s+(.+)$", o)
                Util_Error("Error: #Delimiter is not supported.", 0x22)
            else
                ScriptText .= (contSection ? A_LoopReadLine : tline) "`n"
        }	else if (tline~="^\*/"
            || SubStr(DerefIncludeVars.A_AhkVersion,1,1)=2 && tline~="\*/$")
            cmtBlock := false
    }
    Loop, % !!IsFirstScript
    {
        global AhkPath := UseAhkPath
        if (AhkPath = "")
            AhkPath := SubStr(BinFile,-5)="SC.bin" ? SubStr(BinFile,1,-6) ".exe" : BinFile
        IfNotExist, %AhkPath%
        {	Util_Error("Warning: AutoHotkey.exe could not be located!`n`nAuto-include"
            . "s from Function Libraries, and 'Obey' directives will not be processed.",0)
        break
    }
    Util_Status("Auto-including any functions called from a library...")
    AhkTypeRet := AHKType(AhkPath)
    if !AhkTypeRet
        Util_Error("Error: The AutoHotkey build used for auto-inclusion of library functions is not recognized.", 0x25, AhkPath)
    if (AhkTypeRet.Era = "Legacy")
        Util_Error("Error: Legacy AutoHotkey versions (prior to v1.1) can not be used to do auto-inclusion of library functions.", 0x26, AhkPath)
    tmpErrorLog := Util_TempFile(, "err~")
    ilibfile := Util_TempFile(, "ilib~")
    RunWait, "%comspec%" /c ""%AhkPath%" /iLib "%ilibfile%" /ErrorStdOut "%AhkScript%" 2>"%tmpErrorLog%"", %FirstScriptDir%, UseErrorLevel Hide
    if (ErrorLevel = 2)
    {
        FileRead,tmpErrorData,%tmpErrorLog%
        Util_Error("Error: The script contains syntax errors.", 0x11,tmpErrorData)
    }
    FileDelete,%tmpErrorLog%
    IfExist, %ilibfile%
    {
        PreprocessScript(ScriptText, ilibfile, ExtraFiles, FileList, FirstScriptDir, Options)
        FileDelete, %ilibfile%
    }
    StringTrimRight, ScriptText, ScriptText, 1
}
DerefIncludeVars.A_LineFile := oldLineFile
if OldWorkingDir
    SetWorkingDir, %OldWorkingDir%
if SubStr(DerefIncludeVars.A_AhkVersion,1,1)=2
    SetWorkingDir %OldWorkingDirv2%
if IsFirstScript
    return Options.directives
}
IsFakeCSOpening(tline)
{
    Loop, Parse, tline, %A_Space%%A_Tab%
        if !StrStartsWith(A_LoopField, "Join") && InStr(A_LoopField, ")")
            return true
    return false
}
FindLibraryFile(name, ScriptDir)
{
    libs := [ScriptDir "\Lib", A_MyDocuments "\AutoHotkey\Lib", A_ScriptDir "\..\Lib"]
    p := InStr(name, "_")
    if p
        name_lib := SubStr(name, 1, p-1)
    for each,lib in libs
    {
        file := lib "\" name ".ahk"
        IfExist, %file%
            return file
        if !p
            continue
        file := lib "\" name_lib ".ahk"
        IfExist, %file%
            return file
    }
}
StrStartsWith(ByRef v, ByRef w)
{
    return SubStr(v, 1, StrLen(w)) = w
}
RegExEscape(t)
{
    static _ := "\.*?+[{|()^$"
    Loop, Parse, _
        StringReplace, t, t, %A_LoopField%, \%A_LoopField%, All
    return t
}
Util_TempFile(d := "", f := "", xep := "")
{ static xe := ""
    if xep
        xe := xep
    if ( !StrLen(d) || !FileExist(d) )
        d := A_Temp
    Loop
    { DllCall("QueryPerformanceCounter", "Int64*", Counter)
        tempName := d "\~Ahk2Exe~" xe "~" f Counter ".tmp"
    } until !FileExist(tempName)
    return tempName
}
class DerefIncludeVars
{
    static A_IsCompiled := true
}
DerefIncludePath(path, vars, dosubset := 0)
{
    static SharedVars := {A_AhkPath:1, A_AppData:1, A_AppDataCommon:1, A_ComputerName:1, A_ComSpec:1, A_Desktop:1, A_DesktopCommon:1, A_MyDocuments:1, A_ProgramFiles:1, A_Programs:1, A_ProgramsCommon:1, A_Space:1, A_StartMenu:1, A_StartMenuCommon:1, A_Startup:1, A_StartupCommon:1, A_Tab:1, A_Temp:1, A_UserName:1, A_WinDir:1}
    p := StrSplit(path, "%")
    path := p[1]
    n := 2
    while n < p.Length()
    {
        vn := p[n]
        subs := StrReplace(StrReplace(vn, "````", "chr(2)"), "``~", "chr(3)")
        subs := dosubset ? StrSplit(subs, "~",, 3) : [vn]
        subs.2 := StrReplace(StrReplace(subs.2, "chr(2)", "``"), "chr(3)", "~")
        subs.3 := StrReplace(StrReplace(subs.3, "chr(2)", "``"), "chr(3)", "~")
        if ObjHasKey(vars, subs.1)
            path .= subset(vars[subs.1], subs) . p[++n]
        else if SharedVars[subs.1]
            vn := subs.1, path .= subset(%vn%, subs) . p[++n]
        else path .= "%" vn
            ++n
    }
    if (n = p.Length())
        path .= "%" p[n]
    return path
}
subset(val, subs)
{
    return subs.2="" ? val : RegExReplace(val, subs.2, subs.3)
}
AddOrReplaceIcon(re, IcoFile, ExeFile, iconID := 0)
{
    global _CI_HighestIconID, _CIG_HighestIconGroupID
    CountIcons(ExeFile)
    if !iconID
    {
        CountIconGroups(ExeFile)
        iconID := ++ _CIG_HighestIconGroupID
    }
    ids := EnumIcons(ExeFile, iconID)
    if !IsObject(ids)
        return false
    f := FileOpen(IcoFile, "r")
    if !IsObject(f)
        return false
    VarSetCapacity(igh, 8), f.RawRead(igh, 6)
    if NumGet(igh, 0, "UShort") != 0 || NumGet(igh, 2, "UShort") != 1
        return false
    wCount := NumGet(igh, 4, "UShort")
    VarSetCapacity(rsrcIconGroup, rsrcIconGroupSize := 6 + wCount*14)
    NumPut(NumGet(igh, "Int64"), rsrcIconGroup, "Int64")
    ige := &rsrcIconGroup + 6
    Loop, % ids.MaxIndex()
        DllCall("UpdateResource", "ptr", re, "ptr", 3, "ptr", ids[A_Index], "ushort", 0x409, "ptr", 0, "uint", 0, "uint")
    Loop, %wCount%
    {
        thisID := ids[A_Index]
        if !thisID
            thisID := ++ _CI_HighestIconID
        f.RawRead(ige+0, 12)
        NumPut(thisID, ige+12, "UShort")
        imgOffset := f.ReadUInt()
        oldPos := f.Pos
        f.Pos := imgOffset
        VarSetCapacity(iconData, iconDataSize := NumGet(ige+8, "UInt"))
        f.RawRead(iconData, iconDataSize)
        f.Pos := oldPos
        if !DllCall("UpdateResource", "ptr", re, "ptr", 3, "ptr", thisID, "ushort", 0x409, "ptr", &iconData, "uint", iconDataSize, "uint")
            return false
        ige += 14
    }
    return !!DllCall("UpdateResource", "ptr", re, "ptr", 14, "ptr", iconID, "ushort", 0x409, "ptr", &rsrcIconGroup, "uint", rsrcIconGroupSize, "uint")
}
CountIcons(ExeFile)
{
    global _CI_HighestIconID
    if _CI_HighestIconID
        return
    static pEnumFunc := RegisterCallback("CountIcons_Enum")
    hModule := DllCall("LoadLibraryEx", "str", ExeFile, "ptr", 0, "ptr", 2, "ptr")
    if !hModule
        return
    _CI_HighestIconID := 0
    DllCall("EnumResourceNames", "ptr", hModule, "ptr", 3, "ptr", pEnumFunc, "uint", 0)
    DllCall("FreeLibrary", "ptr", hModule)
}
CountIconGroups(ExeFile)
{
    global _CIG_HighestIconGroupID
    if _CIG_HighestIconGroupID
        return
    static pEnumFunc := RegisterCallback("CountIconGroups_Enum")
    hModule := DllCall("LoadLibraryEx", "str", ExeFile, "ptr", 0, "ptr", 2, "ptr")
    if !hModule
        return
    _CIG_HighestIconGroupID := 0
    DllCall("EnumResourceNames", "ptr", hModule, "ptr", 14, "ptr", pEnumFunc, "uint", 0)
    DllCall("FreeLibrary", "ptr", hModule)
}
EnumIcons(ExeFile, iconID)
{
    hModule := DllCall("LoadLibraryEx", "str", ExeFile, "ptr", 0, "ptr", 2, "ptr")
    if !hModule
        return
    hRsrc := DllCall("FindResource", "ptr", hModule, "ptr", iconID, "ptr", 14, "ptr")
    hMem := DllCall("LoadResource", "ptr", hModule, "ptr", hRsrc, "ptr")
    pDirHeader := DllCall("LockResource", "ptr", hMem, "ptr")
    pResDir := pDirHeader + 6
    wCount := NumGet(pDirHeader+4, "UShort")
    iconIDs := []
    Loop, %wCount%
    {
        pResDirEntry := pResDir + (A_Index-1)*14
        iconIDs[A_Index] := NumGet(pResDirEntry+12, "UShort")
    }
    DllCall("FreeLibrary", "ptr", hModule)
    return iconIDs
}
CountIcons_Enum(hModule, type, name, lParam)
{
    global _CI_HighestIconID
    if (name < 0x10000) && name > _CI_HighestIconID
        _CI_HighestIconID := name
    return 1
}
CountIconGroups_Enum(hModule, type, name, lParam)
{
    global _CIG_HighestIconGroupID
    if (name < 0x10000) && name > _CIG_HighestIconGroupID
        _CIG_HighestIconGroupID := name
    return 1
}
class VersionRes
{
    Name := ""
        ,Data := ""
        ,IsText := true
        ,DataSize := 0
        ,Children := []
    __New(addr := 0)
    {
        if !addr
            return this
        wLength := NumGet(addr+0, "UShort"), addrLimit := addr + wLength, addr += 2
            ,wValueLength := NumGet(addr+0, "UShort"), addr += 2
            ,wType := NumGet(addr+0, "UShort"), addr += 2
            ,szKey := StrGet(addr, "UTF-16"), addr += 2*(StrLen(szKey)+1), addr := (addr+3)&~3
            ,ObjSetCapacity(this, "Data", size := wValueLength*(wType+1))
            ,this.Name := szKey
            ,this.DataSize := wValueLength
            ,this.IsText := wType
            ,DllCall("msvcrt\memcpy", "ptr", this.GetDataAddr(), "ptr", addr, "ptr", size, "cdecl"), addr += size, addr := (addr+3)&~3
        while addr < addrLimit
        {
            size := (NumGet(addr+0, "UShort") + 3) & ~3
                ,this.Children.Insert(new VersionRes(addr))
                ,addr += size
        }
    }
    _NewEnum()
    {
        return this.Children._NewEnum()
    }
    AddChild(node)
    {
        this.Children.Insert(node)
    }
    GetChild(name)
    {
        for k,v in this
            if v.Name = name
                return v
    }
    GetText()
    {
        if this.IsText
            return this.Data
    }
    SetText(txt)
    {
        this.Data := txt
        this.IsText := true
            ,this.DataSize := StrLen(txt)+1
    }
    GetDataAddr()
    {
        return ObjGetAddress(this, "Data")
    }
    Save(addr)
    {
        orgAddr := addr
            ,addr += 2
            ,NumPut(ds:=this.DataSize, addr+0, "UShort"), addr += 2
            ,NumPut(it:=this.IsText, addr+0, "UShort"), addr += 2
            ,addr += 2*StrPut(this.Name, addr+0, "UTF-16")
            ,addr := (addr+3)&~3
            ,realSize := ds*(it+1)
            ,DllCall("msvcrt\memcpy", "ptr", addr, "ptr", this.GetDataAddr(), "ptr", realSize, "cdecl"), addr += realSize
            ,addr := (addr+3)&~3
        for k,v in this
            addr += v.Save(addr)
        size := addr - orgAddr
            ,NumPut(size, orgAddr+0, "UShort")
        return size
    }
}
ProcessDirectives(ExeFile, module, cmds, IcoFile, UseCompression, UsePassword)
{	state := { ExeFile: ExeFile, module: module, resLang: 0x409, verInfo: {}
        , IcoFile: IcoFile, PostExec:[], PostExec0:[], PostExec1:[], PostExec2:[] }
global priorlines
for k, cmdline in cmds
{	while SubStr(cmds[k+A_Index], 1, 4) = "Cont"
    cmdline .= SubStr(cmds[k+A_Index], 6)
    Util_Status("Processing directive: " cmdline)
    state["cmdline"] := cmdline
    DerefIncludeVars.A_PriorLine := priorlines.RemoveAt(1)
    if !RegExMatch(cmdline, "^(\w+)(?:\s+(.+))?$", o)
        Util_Error("Error: Invalid directive: (D1)", 0x63, cmdline)
    args := [], nargs := 0
    StringReplace, o2, o2, ```,, `n, All
    Loop, Parse, o2, `,, %A_Space%%A_Tab%
    {
        StringReplace, ov, A_LoopField, `n, `,, All
        StringReplace, ov, ov, ``n, `n, All
        StringReplace, ov, ov, ``r, `r, All
        StringReplace, ov, ov, ``t, `t, All
        StringReplace, ov, ov,````, ``, All
        args.Insert(DerefIncludePath(ov, DerefIncludeVars, 1)), nargs++
    }
    fn := Func("Directive_" o1)
    if !fn
        Util_Error("Error: Invalid directive: (D2)" , 0x63, cmdline)
    if (!fn.IsVariadic && (fn.MinParams-1 > nargs || nargs > fn.MaxParams-1))
        Util_Error("Error: Wrongly formatted directive: (D1)", 0x64, cmdline)
    fn.(state, args*)
}
if Util_ObjNotEmpty(state.verInfo)
{	Util_Status("Changing version information...")
    ChangeVersionInfo(ExeFile, module, state.verInfo)
}
if IcoFile := state.IcoFile
{	Util_Status("Changing the main icon...")
    if !FileExist(IcoFile)
        Util_Error("Error changing icon: File does not exist.", 0x35, IcoFile)
    if !AddOrReplaceIcon(module, IcoFile, ExeFile, 159)
        Util_Error("Error changing icon: Unable to read icon or icon was of the wrong format.", 0x42, IcoFile)
}
return state
}
Directive_ConsoleApp(state)
{	state.ConsoleApp := true
}
Directive_Cont(state, txt*)
{
}
Directive_Debug(state, txt)
{	Util_Error( "Debug: " txt, 0)
}
Directive_ExeName(state, txt)
{	global ExeFileG
    SplitPath ExeFileG,, gdir,,gname
    SplitPath txt ,, idir,,iname
    ExeFileG := (idir ? idir : gdir) "\" (iname ? iname : gname) ".exe"
}
Directive_Let(state, txt*)
{	for k in txt
    {	wk := StrSplit(txt[k], "=", "`t ", 2)
        if (wk.Length() != 2)
            Util_Error("Error: Wrongly formatted directive: (D2)",0x64, state.cmdline)
        DerefIncludeVars[(name ~= "i)^U_" ? "" : "U_") wk.1] := wk.2
}	}
Directive_Obey(state, name, txt, extra:=0)
{	global ahkpath
    IfExist %ahkpath%
    {	if !(extra ~= "^[0-9]$")
        Util_Error("Error: Wrongly formatted directive: (D3)",0x64, state.cmdline)
        wk := Util_TempFile(, "Obey~")
        FileAppend % (txt~="^=" ? name ":" : "") txt "`nFileAppend % " name "," wk 0
            . "`n#NoEnv", %wk%, UTF-8
        Loop % extra
            FileAppend % "`nFileAppend % " name A_Index "," wk A_Index, %wk%, UTF-8
        RunWait "%ahkpath%" "%wk%",,Hide
        Loop % extra + 1
        {	FileRead result, % wk (cnt := A_Index - 1)
            DerefIncludeVars[(name~="i)^U_"?"":"U_") name (cnt ? cnt : "")] := result
        }
        FileDelete %wk%?
}	}
Directive_OutputPreproc(state, fileName)
{	state.OutPreproc := fileName
}
Directive_PostExec(state, txt, when="", WorkingDir="", Hidden=0, IgnoreErrors=0)
{	if !({"":1,0:1,1:1,2:1}[when] && {"":1,0:1,1:1}[Hidden]
    && {"":1,0:1,1:1}[IgnoreErrors])
Util_Error("Error: Wrongly formatted directive: (D4)",0x64, state.cmdline)
state["PostExec" when].Push([txt, WorkingDir, Hidden, IgnoreErrors])
}
Directive_Set(state, name, txt)
{	state.verInfo[name] := txt
}
Directive_SetCompanyName(state, txt)
{	state.verInfo.CompanyName := txt
}
Directive_SetCopyright(state, txt)
{	state.verInfo.LegalCopyright := txt
}
Directive_SetDescription(state, txt)
{	state.verInfo.FileDescription := txt
}
Directive_SetFileVersion(state, txt)
{	state.verInfo.FileVersion := txt
}
Directive_SetInternalName(state, txt)
{	state.verInfo.InternalName := txt
}
Directive_SetLanguage(state, txt)
{	state.verInfo.Language := txt
}
Directive_SetLegalTrademarks(state, txt)
{	state.verInfo.LegalTrademarks := txt
}
Directive_SetMainIcon(state, txt := "")
{	state.IcoFile := txt
}
Directive_SetName(state, txt)
{	state.verInfo.InternalName := state.verInfo.ProductName := txt
}
Directive_SetOrigFilename(state, txt)
{	state.verInfo.OriginalFilename := txt
}
Directive_SetProductName(state, txt)
{	state.verInfo.ProductName := txt
}
Directive_SetProductVersion(state, txt)
{	state.verInfo.ProductVersion := txt
}
Directive_SetVersion(state, txt)
{	state.verInfo.FileVersion := state.verInfo.ProductVersion := txt
}
Directive_UpdateManifest(state, admin, name = "", version = "", uiaccess = "")
{	xml := ComObjCreate("Msxml2.DOMDocument")
    xml.async := false
    xml.setProperty("SelectionLanguage", "XPath")
    xml.setProperty("SelectionNamespaces"
        , "xmlns:v1='urn:schemas-microsoft-com:asm.v1' "
        . "xmlns:v3='urn:schemas-microsoft-com:asm.v3'")
    if !xml.load("res://" state.ExeFile "/#24/#1")
        Util_Error("Error: Error opening destination file. (D2)", 0x31)
    node := xml.selectSingleNode("/v1:assembly/v1:assemblyIdentity")
    if !node
        Util_Error("Error: Error opening destination file. (D3)", 0x31)
(version && node.setAttribute("version", version))
(name && node.setAttribute("name", name))
node := xml.selectSingleNode("/v1:assembly/v3:trustInfo/v3:security"
. "/v3:requestedPrivileges/v3:requestedExecutionLevel")
if !node
Util_Error("Error: Error opening destination file. (D4)", 0x31)
(admin=1  && node.setAttribute("level", "requireAdministrator"))
(admin=2  && node.setAttribute("level", "highestAvailable"))
(uiaccess && node.setAttribute("uiAccess", "true"))
xml := RTrim(xml.xml, "`r`n")
VarSetCapacity(data, data_size := StrPut(xml, "utf-8") - 1)
StrPut(xml, &data, "utf-8")
if !DllCall("UpdateResource", "ptr", state.module, "ptr", 24, "ptr", 1
, "ushort", 1033, "ptr", &data, "uint", data_size, "uint")
Util_Error("Error changing the version information. (D2)", 0x67)
}
Directive_UseResourceLang(state, resLang)
{
if resLang is not integer
Util_Error("Error: Resource language must be an integer between 0 and 0xFFFF.", 0x65, resLang)
if resLang not between 0 and 0xFFFF
Util_Error("Error: Resource language must be an integer between 0 and 0xFFFF.", 0x65, resLang)
state.resLang := resLang+0
}
Directive_AddResource(state, rsrc, resName := "", UseCompression := false)
{
resType := ""
if RegExMatch(rsrc, "^\*(\w+)\s+(.+)$", o)
resType := o1, rsrc := o2
resFile := Util_GetFullPath(rsrc)
if !FileExist(rsrc)
Util_Error("Error: specified resource does not exist:", 0x36, rsrc)
SplitPath, resFile, resFileName,, resExt
if !resName
resName := resFileName, defResName := true
StringUpper, resName, resName
if resType =
{
if resExt in bmp,dib
resType := 2
else if resExt = ico
resType := 14
else if resExt = cur
Util_Error("Error: Cursor resource adding is not supported yet!", 0x27)
else if resExt in htm,html,mht
resType := 23
else if resExt = manifest
{
resType := 24
if defResName
resName := 1
} else
resType := 10
}
if resType = 14
{
if resName is not integer
resName := 0
AddOrReplaceIcon(state.module, resFile, state.ExeFile, resName)
return
}
typeType := "str"
nameType := "str"
if resType is integer
if resType between 0 and 0xFFFF
typeType := "uint"
if resName is integer
if resName between 0 and 0xFFFF
nameType := "uint"
If UseCompression && resType=10{
FileRead, tempdata, *c %resFile%
FileGetSize, tempsize, %resFile%
If !fSize := ZipRawMemory(&tempdata, tempsize, fData)
Util_Error("Error: Could not compress the file to: " file, 0x46)
}
if resType in 4,5,6,9,23,24
{
FileRead fData, %resFile%
fData1 := DerefIncludePath(fData, DerefIncludeVars, 1)
VarSetCapacity(fData, fSize := StrPut(fData1, "utf-8") - 1)
StrPut(fData1, &fdata, "utf-8")
} else {
FileGetSize, fSize, %resFile%
VarSetCapacity(fData, fSize)
FileRead, fData, *c %resFile%
}
pData := &fData
if resType = 2
{
if fSize < 14
Util_Error("Error: Impossible BMP file!", 0x66)
pData += 14, fSize -= 14
}
if !DllCall("UpdateResource", "ptr",state.module, typeType,resType, nameType
, resName, "ushort",state.resLang, "ptr",pData, "uint",fSize, "uint")
Util_Error("Error adding resource:", 0x46, rsrc)
VarSetCapacity(fData, 0)
}
ChangeVersionInfo(ExeFile, hUpdate, verInfo)
{
hModule := DllCall("LoadLibraryEx", "str", ExeFile, "ptr", 0, "ptr", 2, "ptr")
if !hModule
Util_Error("Error: Error opening destination file. (D1)", 0x31)
hRsrc := DllCall("FindResource", "ptr", hModule, "ptr", 1, "ptr", 16, "ptr")
hMem := DllCall("LoadResource", "ptr", hModule, "ptr", hRsrc, "ptr")
vi := new VersionRes(DllCall("LockResource", "ptr", hMem, "ptr"))
DllCall("FreeLibrary", "ptr", hModule)
ffi := vi.GetDataAddr()
props := SafeGetViChild(SafeGetViChild(vi, "StringFileInfo"), "040904b0")
for k,v in verInfo
{
if !(k = "Language")
SafeGetViChild(props, k).SetText(v)
if k in FileVersion,ProductVersion
{	ver := VersionTextToNumber(v)
hiPart := (ver >> 32)&0xFFFFFFFF, loPart := ver & 0xFFFFFFFF
if (k = "FileVersion")
NumPut(hiPart, ffi+8,  "UInt"), NumPut(loPart, ffi+12, "UInt")
else NumPut(hiPart, ffi+16, "UInt"), NumPut(loPart, ffi+20, "UInt")
}	}
VarSetCapacity(newVI, 16384)
viSize := vi.Save(&newVI)
if (wk := verInfo.Language)
{	NumPut(verInfo.Language, newVI, viSize-4, "UShort")
}
DllCall("UpdateResource", "ptr", hUpdate, "ptr", 16, "ptr", 1
, "ushort", 0x409, "ptr", 0, "uint", 0, "uint")
if !DllCall("UpdateResource", "ptr", hUpdate, "ptr", 16, "ptr", 1, "ushort"
, wk ? wk : 0x409, "ptr", &newVI, "uint", viSize, "uint")
Util_Error("Error changing the version information. (D1)", 0x67)
}
VersionTextToNumber(v)
{
r := 0, i := 0
while i < 4 && RegExMatch(v, "O)^(\d+).?", o)
{
StringTrimLeft, v, v, % o.Len
val := o[1] + 0
r |= (val&0xFFFF) << ((3-i)*16)
i ++
}
return r
}
SafeGetViChild(vi, name)
{
c := vi.GetChild(name)
if !c
{
c := new VersionRes()
c.Name := name
vi.AddChild(c)
}
return c
}
AhkCompile(ByRef AhkFile, ExeFile := "", ByRef CustomIcon := "", BinFile := "", UseMPRESS := "", fileCP:="", UseCompression := "", UseInclude := "", UseIncludeResource := "", UsePassword := "AutoHotkey")
{
global ExeFileTmp, ExeFileG
SetWorkingDir %AhkWorkingDir%
SplitPath AhkFile,, Ahk_Dir,, Ahk_Name
SplitPath ExeFile,, Edir,,    Ename
ExeFile := (Edir ? Edir : Ahk_Dir) "\" (xe:= Ename ? Ename : Ahk_Name ) ".exe"
ExeFile := Util_GetFullPath(ExeFile)
if (CustomIcon != "")
{	SplitPath CustomIcon,, Idir,, Iname
CustomIcon := (Idir ? Idir : Ahk_Dir) "\" (Iname ? Iname : Ahk_Name ) ".ico"
CustomIcon := Util_GetFullPath(CustomIcon)
}
SetWorkingDir %Ahk_Dir%
ExeFileTmp := Util_TempFile(, "exe~", RegExReplace(xe,"^.*/"))
if BinFile =
BinFile = %A_ScriptDir%\AutoHotkeySC.bin
Util_DisplayHourglass()
IfNotExist, %BinFile%
Util_Error("Error: The selected AutoHotkeySC binary does not exist. (C1)"
, 0x34, """" BinFile """")
try FileCopy, %BinFile%, %ExeFileTmp%, 1
catch
Util_Error("Error: Unable to copy AutoHotkeySC binary file to destination."
, 0x41, """" ExeFileTmp """")
DerefIncludeVars.Delete("U_", "V_")
DerefIncludeVars.Delete("A_WorkFileName")
DerefIncludeVars.Delete("A_PriorLine")
BinType := AHKType(ExeFileTmp)
DerefIncludeVars.A_AhkVersion := BinType.Version
DerefIncludeVars.A_PtrSize := BinType.PtrSize
DerefIncludeVars.A_IsUnicode := BinType.IsUnicode
ExeFileG := ExeFile
BundleAhkScript(ExeFileTmp, AhkFile, UseMPRESS, CustomIcon, fileCP, UseCompression, UsePassword)
Util_Status("Moving .exe to destination")
Loop
{	FileMove, %ExeFileTmp%, %ExeFileG%, 1
if !ErrorLevel
break
Util_HideHourglass()
DetectHiddenWindows On
if !WinExist("ahk_exe " ExeFileG)
Util_Error("Error: Could not move final compiled binary file to "
. "destination. (C1)", 0x45, """" ExeFileG """")
else
{	SetTimer Buttons, 50
wk := """" RegExReplace(ExeFileG, "^.+\\") """"
MsgBox 51,Ahk2Exe Query,% "Warning: " wk " is still running, "
.  "and needs to be unloaded to allow replacement with this new version."
. "`n`n Press the appropriate button to continue."
. " ('Reload' unloads and reloads the new " wk " without any parameters.)"
IfMsgBox Cancel
Util_Error("Error: Could not move final compiled binary file to "
. "destination. (C2)", 0x45, """" ExeFileG """")
WinClose     ahk_exe %ExeFileG%
WinWaitClose ahk_exe %ExeFileG%,,1
IfMsgBox No
Reload := 1
}	}
if Reload
run "%ExeFileG%", %ExeFileG%\..
Util_HideHourglass()
Util_Status("")
}
Buttons()
{	IfWinNotExist Ahk2Exe Query
return
SetTimer,, Off
WinActivate
ControlSetText Button1, &Unload
ControlSetText Button2, && &Reload
}
BundleAhkScript(ExeFile, AhkFile, UseMPRESS, IcoFile="", fileCP="", UseCompression := 0, UsePassword := "")
{
global AhkPath := UseAhkPath
if (AhkPath = "")
AhkPath := SubStr(BinFile,"SC.bin") ? SubStr(BinFile,1,-5) ".exe" ? BinFile
if fileCP is space
if SubStr(DerefIncludeVars.A_AhkVersion,1,1) = 2
fileCP := "UTF-8"
else fileCP := A_FileEncoding
try FileEncoding, %fileCP%
catch e
Util_Error("Error: Invalid codepage parameter """ fileCP """ was given.", 0x53)
SplitPath, AhkFile,, ScriptDir
ExtraFiles := []
,Directives := PreprocessScript(ScriptBody, AhkFile, ExtraFiles)
,ScriptBody :=Trim(ScriptBody,"`n")
If UseCompression {
FileDelete, %A_AhkDir%\BinScriptBody.ahk
FileAppend, %ScriptBody%, %A_AhkDir%\BinScriptBody.ahk, UTF-8
If SubStr(DerefIncludeVars.A_AhkVersion,1,1) = 2
PID:=DynaRun("
      (
        UsePassword:=''
        buf:=Buffer(bufsz:=10485760,00),totalsz:=0,buf1:=Buffer(10485760)
        Loop Read, '" A_AhkDir "\BinScriptBody.ahk'
        {
          If (A_LoopReadLine=''){
            NumPut('Char', 10, buf.Ptr + totalsz)
            ,totalsz+=1
            continue
          }
          data:=StrBuf(A_LoopReadLine,'UTF-8')
          ,zip:=UsePassword?ZipRawMemory(data,, '" UsePassword "' ):ZipRawMemory(data)
          ,CryptBinaryToStringA(zip, zip.size, 0x1|0x40000000, 0, getvar(cryptedsz:=0))
          ,tosavesz:=cryptedsz
          ,CryptBinaryToStringA(zip, zip.size, 0x1|0x40000000, buf1, getvar(cryptedsz))
          ,NumPut('Char', 10, buf1.Ptr+cryptedsz)
          if (totalsz+tosavesz>bufsz)
            newbuf:=Buffer(bufsz*=2),RtlMoveMemory(newbuf,buf,totalsz),buf:=newbuf
          RtlMoveMemory(buf.Ptr + totalsz,buf1,tosavesz)
          ,totalsz+=tosavesz
        }
        NumPut('Char', 0, buf.Ptr + totalsz - 1)
        If !BinScriptBody := ZipRawMemory(buf.Ptr,totalsz,'" UsePassword "')
          ExitApp
        f:=FileOpen(A_AhkDir '\..\BinScriptBody.bin','w -rwd'),f.RawWrite(BinScriptBody),f.Close()
)","BinScriptBody","",A_AhkDir "\v2\AutoHotkeyU.exe")
    else
        PID:=DynaRun("
      (
        VarSetCapacity(buf,bufsz:=10485760,00),totalsz:=0,VarSetCapacity(buf1,10485760)
        Loop, Read, " A_AhkDir "\BinScriptBody.ahk
        {
          If (A_LoopReadLine=""""){
            NumPut(10, &buf, totalsz,""Char"")
            ,totalsz+=1
            continue
          }
          len:=StrPutVar(A_LoopReadLine,data,""UTF-8"")
          ,sz:=ZipRawMemory(&data, len, zip, """ UsePassword """)
          ,DllCall(""crypt32\CryptBinaryToStringA"",""PTR"", &zip,""UInt"", sz,""UInt"", 0x1|0x40000000,""UInt"", 0,""UIntP"", cryptedsz:=0)
          ,tosavesz:=cryptedsz
          ,DllCall(""crypt32\CryptBinaryToStringA"",""PTR"", &zip,""UInt"", sz,""UInt"", 0x1|0x40000000,""PTR"", &buf1,""UIntP"", cryptedsz)
          ,NumPut(10,&buf1,cryptedsz,""Char"")
          if (totalsz+tosavesz>bufsz)
            VarSetCapacity(buf,bufsz*=2)
          RtlMoveMemory((&buf) + totalsz,&buf1,tosavesz)
          ,totalsz+=tosavesz
        }
        NumPut(0,&buf,totalsz-1,""Char"")
        If !BinScriptBody_Len := ZipRawMemory(&buf,totalsz,BinScriptBody,""" UsePassword """)
          ExitApp
        f:=FileOpen(A_AhkDir ""\BinScriptBody.bin"",""w -rwd""),f.RawWrite(&BinScriptBody,BinScriptBody_Len),f.Close()
)","BinScriptBody","",DerefIncludeVars.A_IsUnicode ? A_AhkDir "\AutoHotkeyU.exe" : A_AhkDir "\AutoHotkeyA.exe")
    Loop {
        Process, Exist, %PID%
    } Until (!ErrorLevel)
    FileRead,BinScriptBody, *c %A_AhkDir%\BinScriptBody.bin
    FileGetSize, BinScriptBody_Len, %A_AhkDir%\BinScriptBody.bin
    FileDelete, %A_AhkDir%\BinScriptBody.ahk
    FileDelete, %A_AhkDir%\BinScriptBody.bin
} else
    VarSetCapacity(BinScriptBody, BinScriptBody_Len:=StrPut(ScriptBody, "UTF-8"))
        ,StrPut(ScriptBody, &BinScriptBody, "UTF-8")
module := DllCall("BeginUpdateResource", "str", ExeFile, "uint", 0, "ptr")
if !module
    Util_Error("Error: Error opening the destination file. (C1)", 0x31)
SetWorkingDir % ScriptDir
DerefIncludeVars.A_WorkFileName := ExeFile
dirState := ProcessDirectives(ExeFile, module, Directives, IcoFile, UseCompression, UsePassword)
IcoFile := dirState.IcoFile
if outPreproc := dirState.OutPreproc
{
    f := FileOpen(outPreproc, "w", "UTF-8-RAW")
    f.RawWrite(BinScriptBody, BinScriptBody_Len)
    f.Close()
    f := ""
}
Util_Status("Adding: Master Script")
if !DllCall("UpdateResource", "ptr", module, "ptr", 10, "str", "E4847ED08866458F8DD35F94B37001C0"
    , "ushort", 0x409, "ptr", &BinScriptBody, "uint", BinScriptBody_Len, "uint")
    goto _FailEnd
for each,file in ExtraFiles
{
    Util_Status("Adding: " file)
    StringUpper, resname, file
    IfNotExist, %file%
        goto _FailEnd2
    If UseCompression{
        FileRead, tempdata, *c %file%
        FileGetSize, tempsize, %file%
        If !filesize := ZipRawMemory(&tempdata, tempsize, filedata)
            Util_Error("Error: Could not compress the file to: " file, 0x43)
    } else {
        FileRead, filedata, *c %file%
        FileGetSize, filesize, %file%
    }
    if !DllCall("UpdateResource", "ptr", module, "ptr", 10, "str", resname
        , "ushort", 0x409, "ptr", &filedata, "uint", filesize, "uint")
        goto _FailEnd2
    VarSetCapacity(filedata, 0)
}
gosub _EndUpdateResource
if dirState.ConsoleApp
{
    Util_Status("Marking executable as a console application...")
    if !SetExeSubsystem(ExeFile, 3)
        Util_Error("Could not change executable subsystem!", 0x61)
}
SetWorkingDir %A_ScriptDir%
RunPostExec(dirState)
for k,v in [{MPRESS:"-x"},{UPX:"--all-methods --compress-icons=0"}][UseMPRESS]
{	Util_Status("Compressing final executable with " k " ...")
    if FileExist(wk := A_ScriptDir "\" k ".exe")
        RunWait % """" wk """ -q " v " """ ExeFile """",, Hide
    else Util_Error("Warning: """ wk """ not found.`n`n'Compress exe with " k
        . "' specified, but freeware " k ".EXE is not in compiler directory.",0)
        , UseMPRESS := 9
}
RunPostExec(dirState, UseMPRESS)
return
_FailEnd:
    gosub _EndUpdateResource
    Util_Error("Error adding script file:`n`n" AhkFile, 0x43)
_FailEnd2:
    gosub _EndUpdateResource
    Util_Error("Error adding FileInstall file:`n`n" file, 0x44)
_EndUpdateResource:
    if !DllCall("EndUpdateResource", "ptr", module, "uint", 0)
    {	Util_Error("Error: Error opening the destination file. (C2)", 0
        ,,"This error may be caused by your anti-virus checker.`n"
        . "Press 'OK' to try again, or 'Cancel' to abandon.")
    goto _EndUpdateResource
}
return
}
class CTempWD
{
    __New(newWD)
    {
        this.oldWD := A_WorkingDir
        SetWorkingDir % newWD
    }
    __Delete()
    {
        SetWorkingDir % this.oldWD
    }
}
RunPostExec(dirState, UseMPRESS := "")
{	for k, v in dirState["PostExec" UseMPRESS]
    {	Util_Status("PostExec" UseMPRESS ": " v.1)
        RunWait % v.1, % v.2 ? v.2 : A_ScriptDir, % "UseErrorLevel " (v.3?"Hide":"")
        if (ErrorLevel != 0 && !v.4)
            Util_Error("Command failed with RC=" ErrorLevel ":`n" v.1, 0x62)
}	}
Util_GetFullPath(path)
{
    VarSetCapacity(fullpath, 260 * (!!A_IsUnicode + 1))
    return DllCall("GetFullPathName", "str", path, "uint", 260, "str", fullpath, "ptr", 0, "uint") ? fullpath : ""
}
If !A_IsCompiled
    Menu,Tray,Icon,%A_ScriptDir%\Ahk2Exe.ico
OnExit("Util_HideHourglass")
CompressCode := {-1:2, 0:-1, 1:-1, 2:-1}
global UseAhkPath := "", AhkWorkingDir := A_WorkingDir
ScriptFileCP := A_FileEncoding
RegRead wk, HKCR\\AutoHotkeyScript\Shell\Open\Command
if (wk != "" && RegExMatch(wk, "i)/(CP\d+)", o))
    ScriptFileCP := o1
gosub BuildBinFileList
gosub LoadSettings
gosub ParseCmdLine
if !CustomBinFile
    gosub CheckAutoHotkeySC
if UseMPRESS =
    UseMPRESS := LastUseMPRESS
if IcoFile =
    IcoFile := LastIcon
if CLIMode
{
    gosub ConvertCLI
    ExitApp, 0
}
BinFileId := FindBinFile(LastBinFile)
ToolTip:=TT("Parent=1")
Menu, FileMenu, Add, S&ave Script Settings Asâ€¦`tCtrl+S, SaveAsMenu
Menu, FileMenu, Disable, S&ave Script Settings Asâ€¦`tCtrl+S
Menu, FileMenu, Add, &Convert, Convert
Menu, FileMenu, Add
Menu, FileMenu, Add, E&xit`tAlt+F4, GuiClose
Menu, HelpMenu, Add, &Help`tF1, Help
Menu, HelpMenu, Add
Menu, HelpMenu, Add, &About, About
Menu, MenuBar, Add, &File, :FileMenu
Menu, MenuBar, Add, &Help, :HelpMenu
Gui, Menu, MenuBar
Gui, +LastFound +Resize +MinSize594x390
GuiHwnd := WinExist("")
Gui, Add, Link, x303 y1,
(
Â©2004-2009 Chris Mallet
Â©2008-2011 Steve Gray (Lexikos)
Â©2011-2016 fincs
Â©2012-%A_Year% HotKeyIt
Â©2019-%A_Year% TAC109
<a href="https://www.autohotkey.com">https://www.autohotkey.com</a>
Note: Compiling does not guarantee source code protection.
)
Gui, Add, Text, x11 y97 w570 h2 +0x1007
Gui, Font, Bold
Gui, Add, GroupBox, x11 y104 w570 h81, Required Parameters
Gui, Font, Normal
Gui, Add, Text, x17 y126, &Source (script file)
Gui, Add, Edit, x137 y121 w315 h23 aw1 +ReadOnly -WantTab vAhkFile, %AhkFile%
ToolTip.Add("Edit1","Select path of AutoHotkey Script to compile")
Gui, Add, Button, x459 y121 w53 h23 ax1 gBrowseAhk, &Browse
ToolTip.Add("Button2","Select path of AutoHotkey Script to compile")
Gui, Add, Text, x17 y155, &Destination (.exe file)
Gui, Add, Edit, x137 y151 w315 h23 awr aw1 +ReadOnly -WantTab vExeFile, %Exefile%
ToolTip.Add("Edit2","Select path to resulting exe / dll")
Gui, Add, Button, x459 y151 w53 h23 axr ax1 gBrowseExe, B&rowse
ToolTip.Add("Button3","Select path to resulting exe / dll")
Gui, Font, Bold
Gui, Add, GroupBox, x11 y187 w570 h148 awr aw1, Optional Parameters
Gui, Font, Normal
Gui, Add, Text, x18 y208, Custom Icon (.ico file)
Gui, Add, Edit, x138 y204 w315 h23 awr aw1 +ReadOnly vIcoFile, %IcoFile%
ToolTip.Add("Edit3","Select Icon to use in resulting exe / dll")
Gui, Add, Button, x461 y204 w53 h23 axr ax1 gBrowseIco, Br&owse
ToolTip.Add("Button5","Select Icon to use in resulting exe / dll")
Gui, Add, Button, x519 y204 w53 h23 axr ax1 gDefaultIco, D&efault
ToolTip.Add("Button6","Use default Icon")
Gui, Add, Text, x18 y237, Base File (.bin)`n`nUse Win32a for ANSI`nand Win32w or x64w`nfor Unicode compilation!
Gui, Add, DDL, x138 y233 w315 h23 R10 awr aw1 AltSubmit vBinFileId Choose%BinFileId%, %BinNames%
ToolTip.Add("ComboBox1","Select AutoHotkey binary file to use for compilation")
Gui, Add, CheckBox, x138 y260 w315 h20 gCheckCompression vUseCompression Checked%LastUseCompression%, Use compression to reduce size of resulting executable
ToolTip.Add("Button7","Compress all resources")
Gui, Add, CheckBox, x138 y282 w230 h20 vUseEncrypt gCheckCompression Checked%LastUseEncrypt%, Encrypt. Enter password used in executable:
ToolTip.Add("Button8","Use AES encryption for resources (requires a Password)")
Gui, Add, Edit,x370 y282 w85 h20 awr aw1 Password vUsePassword,AutoHotkey
ToolTip.Add("Edit4","Enter password for encryption (default = AutoHotkey).`nAutoHotkey binary must be using this password internally")
Gui, Add, DDL,% "x138 y304 w75 AltSubmit gCompress vUseMPress Choose" UseMPRESS+1, (none)|MPRESS|UPX
ToolTip.Add("ComboBox2","Makes executables smaller and decreases start time when loaded from slow media")
Gui, Add, Button, x235 y338 w125 h28 axr ax0.5 +Default gConvert, > &Compile Executable <
ToolTip.Add("Button10","Convert script to executable file")
Gui, Add, StatusBar,, Ready
gosub AddPicture
GuiControl, Focus, Button1
Gui, Show, w594 h390, Ahk2Exe for AutoHotkey_H v%A_AhkVersion% -- Script to EXE Converter
gosub compress
return
CheckCompression:
    Gui,Submit,NoHide
    If (A_GuiControl="UseCompression" && !UseCompression)
    {
        GuiControl,,UseEncrypt,0
        GuiControl,,UseCompression,0
    } else If (A_GuiControl="UseEncrypt" && UseEncrypt)
    {
        GuiControl,,UseCompression,1
    }
Return
CheckInclude:
    Gui,Submit,NoHide
    If (A_GuiControl="UseInclude" && UseInclude)
    {
        GuiControl,,UseIncludeResource,0
        GuiControl,,UseIncludeLib,0
    } else If (A_GuiControl="UseIncludeResource" && UseIncludeResource)
    {
        GuiControl,,UseInclude,0
        GuiControl,,UseIncludeLib,0
    } else If (A_GuiControl="UseIncludeLib" && UseIncludeLib)
    {
        GuiControl,,UseInclude,0
        GuiControl,,UseIncludeResource,0
    } else If (A_GuiControl="UseInclude" && !UseInclude)
    {
        GuiControl,,UseIncludeResource,1
        GuiControl,,UseIncludeLib,0
    } else If (A_GuiControl="UseIncludeResource" && !UseIncludeResource)
    {
        GuiControl,,UseInclude,1
        GuiControl,,UseIncludeLib,0
    } else If (A_GuiControl="UseIncludeLib" && !UseIncludeLib)
    {
        GuiControl,,UseInclude,1
        GuiControl,,UseIncludeResource,0
    }
Return
GuiClose:
    Gui, Submit
    UseMPRESS--
    gosub SaveSettings
ExitApp
compress:
    gui, Submit, NoHide
    if (UseMPRESS !=1
        && !FileExist(wk := A_ScriptDir "\" . {2:"MPRESS.exe",3:"UPX.exe"}[UseMPRESS]))
        Util_Status("Warning: """ wk """ not found.")
    else Util_Status("Ready")
        return
GuiDropFiles:
    if A_EventInfo > 4
        Util_Error("You cannot drop more than one file of each type into this window!", 0x51)
    loop, parse, A_GuiEvent, `n
    {
        SplitPath, A_LoopField,,, dropExt
        if SubStr(dropExt,1,2) = "ah"
            GuiControl,, AhkFile, %A_LoopField%
        else GuiControl,, %dropExt%File, %A_LoopField%
            if (dropExt = "bin")
                CustomBinFile:=1, BinFile := A_LoopField
                    , Util_Status("""" BinFile """ will be used for this compile only.")
    }
return
AddPicture:
    Gui, Add, Text, x5 y16 w295 h78 +0xE hwndhPicCtrl
    hRSrc := DllCall("FindResource", "PTR", 0,"STR", "LOGO.PNG", "PTR", 10, "PTR")
    sData := SizeofResource(0, hRSrc)
    hRes := LoadResource(0, hRSrc)
    pData := LockResource(hRes)
    If (NumGet(pData+0,0,"UInt")=0x04034b50)
        sData:=UnZipRawMemory(pData,sData,resLogo),pData:=&resLogo
    hGlob := GlobalAlloc(2, sData)
    pGlob := GlobalLock(hGlob)
    #DllImport,memcpy,msvcrt\memcpy,ptr,,ptr,,ptr,,CDecl
    memcpy(pGlob, pData, sData)
    GlobalUnlock(hGlob)
    CreateStreamOnHGlobal(hGlob, 1, getvar(pStream:=0))
    hGdip := LoadLibrary("gdiplus")
    VarSetCapacity(si, 16, 0), NumPut(1, &si, "UChar")
    GdiplusStartup(getvar(gdipToken:=0), &si)
    GdipCreateBitmapFromStream(pStream, getvar(pBitmap:=0))
    GdipCreateHBITMAPFromBitmap(pBitmap, getvar(hBitmap:=0))
    SendMessage, 0x172, 0, hBitmap,, ahk_id %hPicCtrl%
    GuiControl, Move, %hPicCtrl%, w295 h78
    GdipDisposeImage(pBitmap)
    GdiplusShutdown(gdipToken)
    FreeLibrary(hGdip)
    ObjRelease(pStream)
return
BuildBinFileList:
    BinFiles := ["AutoHotkeySC.bin"]
    BinNames := "AutoHotkeySC.bin (default)"
    Loop, %A_ScriptDir%\..\*.bin,0,1
    {
        SplitPath,A_LoopFileFullPath,,d,, n
        FileGetVersion, v, %A_LoopFileFullPath%
        BinFiles.Insert(A_LoopFileFullPath)
        BinNames .= "|v" v " " n ".bin (" StrReplace(A_LoopFileDir,A_AhkDir "\") ")"
    }
    Loop, %A_ScriptDir%\..\*.exe,0,1
    {
        SplitPath,A_LoopFileFullPath,,d,, n
        FileGetVersion, v, %A_LoopFileFullPath%
        If !InStr(FileGetInfo(A_LoopFileFullPath,"FileDescription"),"AutoHotkey")
            continue
        BinFiles.Insert(A_LoopFileFullPath)
        BinNames .= "|v" v " " n ".exe" " (" StrReplace(A_LoopFileDir,A_AhkDir "\") ")"
    }
    Loop, %A_ScriptDir%\..\*.dll,0,1
    {
        SplitPath, A_LoopFileFullPath,,d,, n
        FileGetVersion, v, %A_LoopFileFullPath%
        If !InStr(FileGetInfo(A_LoopFileFullPath,"FileDescription"),"AutoHotkey")
            continue
        BinFiles.Insert(A_LoopFileFullPath)
        BinNames .= "|v" v " " n ".dll" " (" StrReplace(A_LoopFileDir,A_AhkDir "\") ")"
    }
return
CheckAutoHotkeySC:
return
FindBinFile(name)
{
    global BinFiles
    for k,v in BinFiles
        if (v = name)
            return k
    return 1
}
ParseCmdLine:
    if 0 = 0
        return
    Error_ForceExit := true
    p := []
    Loop, %0%
        p.Insert(%A_Index%)
    CLIMode := true
    while p.MaxIndex()
    {
        p1 := p.RemoveAt(1)
        if SubStr(p1,1,1) != "/" || !(p1fn := Func("CmdArg_" SubStr(p1,2)))
            BadParams("Error: Unrecognised parameter:`n" p1)
        if p1fn.MaxParams
        {
            p2 := p.RemoveAt(1)
            if p2 =
                BadParams("Error: Blank or missing parameter for " p1 ".")
        }
        %p1fn%(p2)
    }
    if (AhkFile = "" && CLIMode)
        BadParams("Error: No input file specified.")
    if BinFile =
        BinFile := A_ScriptDir "\" LastBinFile
return
BadParams(Message, ErrorCode=0x3)
{ Util_Error(Message, ErrorCode,, "Command Line Parameters:`n`n" A_ScriptName "`n`t /in infile.ahk`n`t [/out outfile.exe]`n`t [/icon iconfile.ico]`n`t [/bin AutoHotkeySC.bin]`n`t [/compress 0 (none), 1 (MPRESS), or 2 (UPX)]`n`t [/cp codepage]`n`t [/ahk path\name]`n`t [/gui]")
}
CmdArg_Gui() {
    global
    CLIMode := false
    Error_ForceExit := false
}
CmdArg_In(p2) {
    global AhkFile := p2
}
CmdArg_Out(p2) {
    global ExeFile := p2
}
CmdArg_Icon(p2) {
    global IcoFile := p2
}
CmdArg_Bin(p2) {
    global
    CustomBinFile := true
    BinFile := p2
}
CmdArg_MPRESS(p2) {
    CmdArg_Compress(p2)
}
CmdArg_Compress(p2) {
    global
    if !CompressCode[p2]
        BadParams("Error: " p1 " parameter invalid:`n" p2)
    if CompressCode[p2] > 0
        p2 := CompressCode[p2]
    UseMPRESS := p2
}
CmdArg_Ahk(p2) {
    global
    if !FileExist(p2)
        Util_Error("Error: Specified resource does not exist.", 0x36
            , "Command line parameter /ahk`n""" p2 """")
    UseAhkPath := Util_GetFullPath(p2)
}
CmdArg_CP(p2) {
    global
    if p2 is number
        ScriptFileCP := "CP" p2
    else
        ScriptFileCP := p2
}
CmdArg_Pass(p2) {
    global
    UsePassword:=p2
}
CmdArg_NoDecompile(p2) {
    global
    UseCompression := p2=0 ? false : true
}
BrowseAhk:
    Gui, +OwnDialogs
    FileSelectFile, ov, 1, %LastScriptDir%, Open, AutoHotkey files (*.ahk)
    if ErrorLevel
        return
    SplitPath ov,, LastScriptDir
    GuiControl,, AhkFile, %ov%
    menu, FileMenu, Enable, S&ave Script Settings Asâ€¦`tCtrl+S
return
BrowseExe:
    Gui, +OwnDialogs
    FileSelectFile, ov, S16, %LastExeDir%, Save As, Executable files (*.exe)
    if ErrorLevel
        return
    if !RegExMatch(ov, "\.[^\\/]+$")
        ov .= ".exe"
    SplitPath ov,, LastExeDir
    GuiControl,, ExeFile, %ov%
return
BrowseIco:
    Gui, +OwnDialogs
    FileSelectFile, ov, 1, %LastIconDir%, Open, Icon files (*.ico)
    if ErrorLevel
        return
    SplitPath ov,, LastIconDir
    GuiControl,, IcoFile, %ov%
return
DefaultIco:
    GuiControl,, IcoFile
return
SaveAsMenu:
    Gui, +OwnDialogs
    Gui, Submit, NoHide
    BinFile := A_ScriptDir "\" BinFiles[BinFileId]
    SaveAs := ""
    FileSelectFile, SaveAs, S,% RegExReplace(AhkFile,"\.[^.]+$") "_Compile"
        , Save Script Settings As, *.ahk
    If (SaveAs = "") or ErrorLevel
        Return
    If !RegExMatch(SaveAs,"\.ahk$")
        SaveAs .= ".ahk"
    FileDelete %SaveAs%
    FileAppend % "RunWait """ A_ScriptDir "\Ahk2Exe.exe"" /in """ AhkFile """"
        . (ExeFile ? " /out """ ExeFile """" : "")
        . (IcoFile ? " /icon """ IcoFile """": "")
        . (UseCompression ? " /NoDecompile": "")
        . (UseEncryption ? " /pass """ UsePassword """": "")
        . " /bin """ BinFile """ /compress " UseMpress-1, %SaveAs%
Return
Convert:
    Gui, +OwnDialogs
    Gui, Submit, NoHide
    UseMPRESS--
    if !CustomBinFile
        BinFile := BinFiles[BinFileId]
    else CustomBinFile := ""
        ConvertCLI:
    AhkFile := Util_GetFullPath(AhkFile)
    if AhkFile =
        Util_Error("Error: Source file not specified.", 0x33)
    SplitPath, AhkFile, ScriptName, ScriptDir
    DerefIncludeVars.A_ScriptFullPath := AhkFile
    DerefIncludeVars.A_ScriptName := ScriptName
    DerefIncludeVars.A_ScriptDir := ScriptDir
    SetWorkingDir %A_ScriptDir%
    global DirDone := []
    DirBinsWk := [], DirBins := [], DirExe := [], DirCP := [], Cont := 0
    Loop Read, %AhkFile%
    {	if (Cont=1 && RegExMatch(A_LoopReadLine,"i)^\s*\S{1,2}@Ahk2Exe-Cont (.*$)",o))
        DirBinsWk[DirBinsWk.MaxIndex()] .= RegExReplace(o1,"\s+;.*$")
            , DirDone[A_Index] := 1
        else if (Cont!=2)
            && RegExMatch(A_LoopReadLine,"i)^\s*\S{1,2}@Ahk2Exe-Bin (.*$)",o)
            DirBinsWk.Push(RegExReplace(o1, "\s+;.*$")), Cont := 1, DirDone[A_Index]:= 1
        else if SubStr(LTrim(A_LoopReadLine),1,2) = "/*"
            Cont := 2
        else if Cont != 2
            Cont := 0
        if (Cont = 2) && A_LoopReadLine~="^\s*\*/|\*/\s*$"
            Cont := 0
    }
    for k, v1 in DirBinsWk
    {	Util_Status("Processing directive: " v1)
        StringReplace, v, v1, ```,, `n, All
        Loop Parse, v, `,, %A_Space%%A_Tab%
        {	if A_LoopField =
            continue
            StringReplace, o1, A_LoopField, `n, `,, All
            StringReplace, o,o1, ``n, `n, All
            StringReplace, o, o, ``r, `r, All
            StringReplace, o, o, ``t, `t, All
            StringReplace, o, o,````, ``, All
            o := DerefIncludePath(o, DerefIncludeVars, 1)
            if A_Index = 1
            {	o .= RegExReplace(o, "\.[^\\]*$") = o ? ".bin" : ""
                if !(FileExist(o) && FileExist(o:= A_AhkDir "\" o) && (RegExReplace(o,"^.+\.") = "bin" || RegExReplace(o,"^.+\.") = "exe" || RegExReplace(o,"^.+\.") = "dll"))
                    Util_Error("Error: The selected AutoHotkeySC binary does not exist. (A1)"
                        , 0x34, """" o1 """")
                Loop Files, % o
                    DirBins.Push(A_LoopFileLongPath), DirExe.Push(ExeFile), Cont := A_Index
            } else if A_Index = 2
            {	SplitPath ExeFile ,, edir,,ename
                SplitPath A_LoopField,, idir,,iname
                Loop % Cont
                    DirExe[DirExe.MaxIndex()-A_Index+1]
                        := (idir ? idir : edir) "\" (iname ? iname : ename) ".exe"
            }	else if A_Index = 3
            {	wk := A_LoopField~="^\d+$" ? "CP" A_LoopField : A_LoopField
                Loop % Cont
                    DirCP[DirExe.MaxIndex()-A_Index+1] := wk
            }	else Util_Error("Error: Wrongly formatted directive. (A1)", 0x64, v1)
    }	}
if Util_ObjNotEmpty(DirBins)
    for k in DirBins
        AhkCompile(AhkFile, DirExe[k], IcoFile, DirBins[k],UseMpress
            , DirCP[k] ? DirCP[k] : ScriptFileCP, UseCompression, UseInclude, UseIncludeResource, UsePassword)
else AhkCompile(AhkFile, ExeFile, IcoFile, BinFile, UseMpress, ScriptFileCP, UseCompression, UseInclude, UseIncludeResource, UsePassword)
    if !CLIMode
        Util_Info("Conversion complete.")
    else
        FileAppend, Successfully compiled: %ExeFile%`n, *
return
LoadSettings:
    RegRead, LastScriptDir, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastScriptDir
    RegRead, LastExeDir, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastExeDir
    RegRead, LastIconDir, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastIconDir
    RegRead, LastIcon, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastIcon
    RegRead, LastBinFile, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastBinFile
    RegRead, LastUseMPRESS, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastUseMPRESS
    RegRead, UseCompression, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastUseCompression
    RegRead, LastUseEncrypt,HKCU, Software\AutoHotkey\Ahk2Exe_H, LastUseEncrypt
    if !FileExist(LastIcon)
        LastIcon := ""
    if (LastBinFile = "") || !FileExist(LastBinFile)
        LastBinFile = AutoHotkeySC.bin
    if !CompressCode[LastUseMPRESS]
        LastUseMPRESS := false
    if CompressCode[LastUseMPRESS] > 0
        LastUseMPRESS := CompressCode[LastUseMPRESS]
return
SaveSettings:
    SplitPath, AhkFile,, AhkFileDir
    if ExeFile
        SplitPath, ExeFile,, ExeFileDir
    else
        ExeFileDir := LastExeDir
    if IcoFile
        SplitPath, IcoFile,, IcoFileDir
    else
        IcoFileDir := ""
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastScriptDir, %AhkFileDir%
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastExeDir, %ExeFileDir%
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastIconDir, %IcoFileDir%
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastIcon, %IcoFile%
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastUseMPRESS, %UseMPRESS%
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastUseCompression, %UseCompression%
    RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastUseEncrypt, %UseEncrypt%
    if !CustomBinFile
        RegWrite, REG_SZ, HKCU, Software\AutoHotkey\Ahk2Exe_H, LastBinFile, % BinFiles[BinFileId]
return
Help:
    helpfile = %A_ScriptDir%\..\AutoHotkey.chm
    IfNotExist, %helpfile%
        Util_Error("Error: cannot find AutoHotkey help file!", 0x52)
    #DllImport,HtmlHelp,hhctrl.ocx\HtmlHelp,PTR,,Str,,UInt,,PTR,
    VarSetCapacity(ak, ak_size := 8+5*A_PtrSize+4, 0)
        ,NumPut(ak_size, ak, 0, "UInt"),name := "Ahk2Exe",NumPut(&name, ak, 8)
        ,HtmlHelp(GuiHwnd, helpfile, 0x000D, &ak)
return
About:
    Gui, +OwnDialogs
    MsgBox, 64, About Ahk2Exe,
(
Ahk2Exe - Script to EXE Converter

Original version:
  Copyright @1999-2003 Jonathan Bennett & AutoIt Team
  Copyright @2004-2009 Chris Mallet
  Copyright @2008-2011 Steve Gray (Lexikos)

Script rewrite:
  Copyright @2011-%A_Year% fincs
  Copyright @2012-%A_Year% HotKeyIt

Special thanks:
  joedf, benallred, aviaryan, TAC109
)
return
Util_Status(s)
{	SB_SetText(s)
}
Util_Error(txt, exitcode, extra := "", extra1 := "")
{
    global CLIMode, Error_ForceExit, ExeFileTmp
    if extra
        txt .= "`n`nSpecifically:`n" extra
    if extra1
        txt .= "`n`n" extra1
    Util_HideHourglass()
    if exitcode
        MsgBox, 16, Ahk2Exe Error, % txt
    else {
        MsgBox, 49, Ahk2Exe Warning, % txt
            . (extra||extra1 ? "" : "`n`nPress 'OK' to continue, or 'Cancel' to abandon.")
        IfMsgBox Cancel
            exitcode := 2
    }
    if (exitcode && ExeFileTmp && FileExist(ExeFileTmp))
    {	FileDelete, %ExeFileTmp%
        ExeFileTmp =
    }
    if CLIMode && exitcode
        FileAppend, Failed to compile: %ExeFile%`n, *
    Util_Status("Ready")
    if exitcode
        if !Error_ForceExit
            Exit, exitcode
        else ExitApp, exitcode
            Util_DisplayHourglass()
}
Util_Info(txt)
{	MsgBox, 64, Ahk2Exe, % txt
}
Util_DisplayHourglass()
{	DllCall("SetSystemCursor", "Ptr",DllCall("LoadCursor", "Ptr",0, "Ptr",32512)
    ,"Ptr",32650)
}
Util_HideHourglass()
{	DllCall("SystemParametersInfo", "Ptr",0x57, "Ptr",0, "Ptr",0, "Ptr",0)
}
Util_ObjNotEmpty(obj)
{	for _,__ in obj
    return true
}
AHKType(exeName)
{
    FileGetVersion, vert, %exeName%
    if !vert
        return
    StringSplit, vert, vert, .
    vert := vert4 | (vert3 << 8) | (vert2 << 16) | (vert1 << 24)
    exeFile := FileOpen(exeName, "r")
    if !exeFile
        return
    exeFile.RawRead(exeData, exeFile.Length)
    exeFile.Close()
    Type := {}
    exeMachine := NumGet(exeData, NumGet(exeData, 60, "uint") + 4, "ushort")
    Type.PtrSize := {0x8664: 8, 0x014C: 4}[exeMachine]
    if !Type.PtrSize
        return
    Type.IsUnicode := (!RegExMatch(exeData, "MsgBox\0") = !A_IsUnicode) ? 1 : ""
    if !(VersionInfoSize := DllCall("version\GetFileVersionInfoSize", "str", exeName, "uint*", null, "uint"))
        return
    VarSetCapacity(VersionInfo, VersionInfoSize)
    if !DllCall("version\GetFileVersionInfo", "str", exeName, "uint", 0, "uint", VersionInfoSize, "ptr", &VersionInfo)
        return
    if !DllCall("version\VerQueryValue", "ptr", &VersionInfo, "str", "\VarFileInfo\Translation", "ptr*", lpTranslate, "uint*", cbTranslate)
        return
    wLanguage := NumGet(lpTranslate+0, "UShort")
    wCodePage := NumGet(lpTranslate+2, "UShort")
    id := Format("{:04X}{:04X}", wLanguage, wCodePage)
    if !DllCall("version\VerQueryValue", "ptr", &VersionInfo, "str", "\StringFileInfo\" id "\FileVersion", "ptr*", pField, "uint*", cbField)
        return
    Type.Version := StrGet(pField, cbField)
    Type.Era := vert >= 0x01010000 ? "Modern" : "Legacy"
    return Type
}
DynaRun(s,pn:="",pr:="",exe:=""){
    static AhkPath,h2o
    if !AhkPath
        AhkPath:="""" A_AhkPath """" (A_IsCompiled||(A_IsDll&&DllCall(A_AhkPath "\ahkgetvar","Str","A_IsCompiled","CDecl"))?" /E":"")
            ,h2o:="B29C2D1CA2C24A57BC5E208EA09E162F(){`nPLACEHOLDERB29C2D1CA2C24A57BC5E208EA09E162FVarSetCapacity(dmp,sz:=StrLen(hex)//2,0)`nLoop,Parse,hex`nIf (""""!=h.=A_LoopField) && !Mod(A_Index,2)`nNumPut(""0x"" h,&dmp,A_Index/2-1,""UChar""),h:=""""`nreturn ObjLoad(&dmp)`n}`n"
    if (-1=p1:=DllCall("CreateNamedPipe","str",pf:="\\.\pipe\" (pn!=""?pn:"AHK" A_TickCount),"uint",2,"uint",0,"uint",255,"uint",0,"uint",0,"Ptr",0,"Ptr",0))
        || (-1=p2:=DllCall("CreateNamedPipe","str",pf,"uint",2,"uint",0,"uint",255,"uint",0,"uint",0,"Ptr",0,"Ptr",0))
        Return 0
    Run % (exe?exe:AhkPath) " """ pf """ " (IsObject(pr)?"": " " pr),,UseErrorLevel HIDE,P
    If ErrorLevel
        return DllCall("CloseHandle","Ptr",p1),DllCall("CloseHandle","Ptr",p2),0
    If IsObject(pr) {
        sz:=ObjDump(pr,dmp),hex:=BinToHex(&dmp,sz)
        While % _hex:=SubStr(Hex,1 + (A_Index-1)*16370,16370)
            _s.= "hex" (A_Index=1?":":".") "=""" _hex """`n"
        Arg:=StrReplace(h2o,"PLACEHOLDERB29C2D1CA2C24A57BC5E208EA09E162F",_s) "global A_Args:=B29C2D1CA2C24A57BC5E208EA09E162F()`n"
    }
    DllCall("ConnectNamedPipe","Ptr",p1,"Ptr",0),DllCall("CloseHandle","Ptr",p1),DllCall("ConnectNamedPipe","Ptr",p2,"Ptr",0)
    if !DllCall("WriteFile","Ptr",p2,"Wstr",s:=(A_IsUnicode?chr(0xfeff):"Ã¯Â»Â¿") Arg s,"UInt",StrLen(s)*(A_IsUnicode?2:1)+(A_IsUnicode?4:3),"uint*",0,"Ptr",0)
        P:=0
    DllCall("CloseHandle","Ptr",p2)
    Return P
}
SetExeSubsystem(exepath, subSys)
{
    exe := FileOpen(exepath, "rw", "UTF-8-RAW")
    if !exe
        return false
    exe.Seek(60), exe.Seek(exe.ReadUInt()+92)
    exe.WriteUShort(subSys)
    return true
}
TT_Init(){
    global _TOOLINFO:="cbSize,uFlags,PTR hwnd,PTR uId,_RECT rect,PTR hinst,LPTSTR lpszText,PTR lParam,void *lpReserved"
        ,_RECT:="left,top,right,bottom"
        ,_NMHDR:="HWND hwndFrom,UINT_PTR idFrom,UINT code"
        ,_NMTVGETINFOTIP:="_NMHDR hdr,UINT uFlags,UInt link"
        ,_CURSORINFO:="cbSize,flags,HCURSOR hCursor,x,y"
        ,_ICONINFO:="fIcon,xHotspot,yHotSpot,HBITMAP hbmMask,HBITMAP hbmColor"
        ,_BITMAP:="LONG bmType,LONG bmWidth,LONG bmHeight,LONG bmWidthBytes,WORD bmPlanes,WORD bmBitsPixel,LPVOID bmBits"
        ,_SHFILEINFO:="HICON hIcon,iIcon,DWORD dwAttributes,TCHAR szDisplayName[260],TCHAR szTypeName[80]"
        ,_TBBUTTON:="iBitmap,idCommand,BYTE fsState,BYTE fsStyle,BYTE bReserved[" (A_PtrSize=8?6:2) "],DWORD_PTR dwData,INT_PTR iString"
    static _:={base:{__Delete:"TT_Delete"}}
    return _
}
TT(options:="",text:="",title:=""){
    global _RECT,_TOOLINFO
    static HWND_TOPMOST:=-1,SWP_NOMOVE:=0x2, SWP_NOSIZE:=0x1, SWP_NOACTIVATE:=0x10
    static _:=TT_Init(),base:={Color:"TT_Color",Show:"TT_Show",Hide:"TTM_Trackactivate",Close:"TT_Close",Add:"TT_Add",AddTool:"TTM_AddTool"
        ,Del:"TT_Del",Title:"TTM_SetTitle",Text:"TT_Text",ACTIVATE:"TTM_ACTIVATE",Set:"TT_Set"
        ,ADDTOOL:"TTM_ADDTOOL",Remove:"TT_Remove",Icon:"TT_Icon",Font:"TT_Font",ADJUSTRECT:"TTM_ADJUSTRECT"
        ,DELTOOL:"TTM_DELTOOL",ENUMTOOLS:"TTM_ENUMTOOLS",GETBUBBLESIZE:"TTM_GETBUBBLESIZE"
        ,GETCURRENTTOOL:"TTM_GETCURRENTTOOL",GETDELAYTIME:"TTM_GETDELAYTIME",GETMARGIN:"TTM_GETMARGIN"
        ,GETMAXTIPWIDTH:"TTM_GETMAXTIPWIDTH",GETTEXT:"TTM_GETTEXT",GETTIPBKCOLOR:"TTM_GETTIPBKCOLOR"
        ,GETTIPTEXTCOLOR:"TTM_GETTIPTEXTCOLOR",GETTITLE:"TTM_GETTITLE",GETTOOLCOUNT:"TTM_GETTOOLCOUNT"
        ,GETTOOLINFO:"TTM_GETTOOLINFO",HITTEST:"TTM_HITTEST",NEWTOOLRECT:"TTM_NEWTOOLRECT",POP:"TTM_POP"
        ,POPUP:"TTM_POPUP",RELAYEVENT:"TTM_RELAYEVENT",SETDELAYTIME:"TTM_SETDELAYTIME",SETMARGIN:"TTM_SETMARGIN"
        ,SETMAXTIPWIDTH:"TTM_SETMAXTIPWIDTH",SETTIPBKCOLOR:"TTM_SETTIPBKCOLOR",SETTIPTEXTCOLOR:"TTM_SETTIPTEXTCOLOR"
        ,SETTITLE:"TTM_SETTITLE",SETTOOLINFO:"TTM_SETTOOLINFO",SETWINDOWTHEME:"TTM_SETWINDOWTHEME"
        ,TRACKACTIVATE:"TTM_TRACKACTIVATE",TRACKPOSITION:"TTM_TRACKPOSITION",UPDATE:"TTM_UPDATE"
        ,UPDATETIPTEXT:"TTM_UPDATETIPTEXT",WINDOWFROMPOINT:"TTM_WINDOWFROMPOINT"
        ,"base":{__Call:"TT_Set"}}
    Parent:="",Gui:="",ClickTrough:="",Style:="",NOFADE:="",NoAnimate:="",NOPREFIX:="",AlwaysTip:="",ParseLinks:="",CloseButton:="",Balloon:="",maxwidth:=""
        ,INITIAL:="",AUTOPOP:="",RESHOW:="",OnClick:="",OnClose:="",OnShow:="",ClickHide:="",HWND:="",Center:="",RTL:="",SUB:="",Track:="",Absolute:=""
        ,TRANSPARENT:="",Color:="",Background:="",icon:=0
    if (options+0!="")
        Parent:=options
    else If (options){
        Loop,Parse,options,%A_Space%,%A_Space%
            If (istext){
                If (SubStr(A_LoopField,0)="'")
                    %istext%:=string A_Space SubStr(A_LoopField,1,StrLen(A_LoopField)-1),istext:="",string:=""
                else
                    string.= A_Space A_LoopField
            } else If (A_LoopField ~= "i)AUTOPOP|INITIAL|PARENT|RESHOW|MAXWIDTH|ICON|Color|BackGround|OnClose|OnClick|OnShow|GUI|NOPREFIX|TRACK")
            {
                RegExMatch(A_LoopField,"^(\w+)=?(.*)?$",option)
                If ((Asc(option2)=39 && SubStr(A_LoopField,0)!="'") && (istext:=option1) && (string:=SubStr(option2,2)))
                    Continue
                %option1%:=option2
            } else if ( option2:=InStr(A_LoopField,"=")){
                option1:=SubStr(A_LoopField,1,option2-1)
                %option1%:=SubStr(A_LoopField,option2+1)
            } else if (A_LoopField)
                %A_LoopField% := 1
    }
    If (Parent && Parent<100 && !DllCall("IsWindow","PTR",Parent)){
        Gui,%Parent%:+LastFound
        Parent:=WinExist()
    } else if (GUI){
        Gui, %GUI%:+LastFound
        Parent:=WinExist()
    } else if (Parent=""){
        Parent:=A_ScriptHwnd
    }
    T:=Object("base",base)
        ,T.HWND := DllCall("CreateWindowEx", "UInt", (ClickTrough?0x20:0)|0x8, "str", "tooltips_class32", "PTR", 0
        , "UInt",0x80000000|(Style?0x100:0)|(NOFADE?0x20:0)|(NoAnimate?0x10:0)|((NOPREFIX+1)?(NOPREFIX?0x2:0x2):0x2)|(AlwaysTip?0x1:0)|(ParseLinks?0x1000:0)|(CloseButton?0x80:0)|(Balloon?0x40:0)
        , "int",0x80000000,"int",0x80000000,"int",0x80000000,"int",0x80000000, "PTR",Parent?Parent:0,"PTR",0,"PTR",0,"PTR",0,"PTR")
        ,DllCall("SetWindowPos","PTR",T.HWND,"PTR",HWND_TOPMOST,"Int",0,"Int",0,"Int",0,"Int",0
        ,"UInt",SWP_NOMOVE|SWP_NOSIZE|SWP_NOACTIVATE)
        ,_.Insert(T)
        ,T.SETMAXTIPWIDTH(MAXWIDTH?MAXWIDTH:A_ScreenWidth)
    If !(AUTOPOP INITIAL RESHOW)
        T.SETDELAYTIME()
    else T.SETDELAYTIME(2,AUTOPOP?AUTOPOP:-1),T.SETDELAYTIME(3,INITIAL?INITIAL:-1),T.SETDELAYTIME(1,RESHOW?RESHOW:-1)
        T.fulltext:=text,T.maintext:=RegExReplace(text,"<a\K[^<]*?>",">")
    If (OnClick)
        ParseLinks:=1
    T.rc:=Struct(_RECT)
        ,T.P:=Struct(_TOOLINFO),P:=T.P,P.cbSize:=sizeof(_TOOLINFO)
        ,P.uFlags:=(HWND?0x1:0)|(Center?0x2:0)|(RTL?0x4:0)|(SUB?0x10:0)|(Track+1?(Track?0x20:0):0x20)|(Absolute?0x80:0)|(TRANSPARENT?0x100:0)|(ParseLinks?0x1000:0)
        ,P.hwnd:=Parent
        ,P.uId:=Parent
        ,P.lpszText[""]:=T.GetAddress("maintext")?T.GetAddress("maintext"):0
        ,T.AddTool(P[])
    If (Theme)
        T.SETWINDOWTHEME()
    If (Color)
        T.SETTIPTEXTCOLOR(Color)
    If (Background)
        T.SETTIPBKCOLOR(BackGround)
    T.SetTitle(T.maintitle:=title,icon)
    If ((T.OnClick:=OnClick)||(T.OnClose:=OnClose)||(T.OnShow:=OnShow))
        T.OnClose:=OnClose,T.OnShow:=OnShow,T.ClickHide:=ClickHide,OnMessage(0x4e,A_ScriptHwnd,"TT_OnMessage")
    Return T
}
TT_Delete(this){
    Loop % this.MaxIndex()
    {
        this[i:=A_Index].DelTool(this[i].P[])
            ,DllCall("DestroyWindow","PTR",this[i].HWND)
        for id,tool in this[i].T
            this[i].DelTool(tool[])
        this.Remove(i)
    }
    TT_GetIcon()
}
TT_Remove(T:=""){
    static _:=TT_Init()
    for id,Tool in _
    {
        If (T=Tool){
            _[id]:=_[_.MaxIndex()],_.Remove(id)
            for id,tools in Tool.T
                Tool.DelTool(tools[])
            Tool.DelTool(Tool.P[])
                ,DllCall("DestroyWindow","PTR",Tool.HWND)
            break
        }
    }
}
TT_OnMessage(wParam,lParam,msg,hwnd){
    global _NMTVGETINFOTIP,_NMHDR
    static TTN_FIRST:=0xfffffdf8, _:=TT_Init()
        ,HDR:=Struct(_NMTVGETINFOTIP)
    HDR[]:=lParam
    If !InStr(".1.2.3.","." (m:= TTN_FIRST-HDR.hdr.code) ".")
        Return
    p:=HDR.hdr.hwndFrom
    for id,T in _
        If (p=T.hwnd)
            break
    for id,object in _
        If (p=object.hwnd && T:=object)
            break
    text:=T.fulltext
    If (m=1){
        If IsFunc(T.OnShow)
            T.OnShow(T,"")
    } else If (m=2){
        If IsFunc(T.OnClose)
            T.OnClose(T,"")
        T.TRACKACTIVATE(0,T.P[])
    } else If InStr(text,"<a"){
        If (T.ClickHide)
            T.TRACKACTIVATE(0,T.P[])
        If (SubStr(LTrim(text:=SubStr(text,InStr(text,"<a",0,1,HDR.link+1)+2)),1,1)=">")
            action:=SubStr(text,InStr(text,">")+1,InStr(text,"</a>")-InStr(text,">")-1)
        else action:=Trim(action:=SubStr(text,1,InStr(text,">")-1))
            If IsFunc(func:=T.OnClick)
                T.OnClick(T,action)
    }
    Return true
}
TT_ADD(T,Control,Text:="",uFlags:="",Parent:=""){
    Global _TOOLINFO
    DetectHiddenWindows:=A_DetectHiddenWindows
    DetectHiddenWindows,On
    if (Parent){
        If (Parent && Parent<100 and !DllCall("IsWindow","PTR",Parent)){
            Gui %Parent%:+LastFound
            Parent:=WinExist()
        }
        T["T",Abs(Parent)]:=Tool:=Struct(_TOOLINFO)
            ,Tool.uId:=Parent,Tool.hwnd:=Parent,Tool.uFlags:=(0|16)
            ,DllCall("GetClientRect","PTR",T.HWND,"PTR", T[Abs(Parent)].rect[""])
            ,T.ADDTOOL(T["T",Abs(Parent)][])
    }
    If (text="")
        ControlGetText,text,%Control%,% "ahk_id " (Parent?Parent:T.P.hwnd)
    If (Control+0="")
        ControlGet,Control,Hwnd,,%Control%,% "ahk_id " (Parent?Parent:T.P.hwnd)
    If (uFlags)
        If (uFlags+0="")
        {
            Loop,Parse,uflags,%A_Space%,%A_Space%
                If (A_LoopField)
                    %A_LoopField% := 1
            uFlags:=(HWND?0x1:HWND=""?0x1:0)|(Center?0x2:0)|(RTL?0x4:0)|(SUB?0x10:0)|(Track?0x20:0)|(Absolute?0x80:0)|(TRANSPARENT?0x100:0)|(ParseLinks?0x1000:0)
        }
    Tool:=T["T",Abs(Control)]:=Struct(_TOOLINFO)
        ,Tool.cbSize:=sizeof(_TOOLINFO)
        ,T[Abs(Control),"text"]:=RegExReplace(text,"<a\K[^<]*?>",">")
        ,Tool.uId:=Control,Tool.hwnd:=Parent?Parent:T.P.hwnd,Tool.uFlags:=uFlags?(uFlags|16):(1|16)
        ,Tool.lpszText[""]:=T[Abs(Control)].GetAddress("text")
        ,DllCall("GetClientRect","PTR",T.HWND,"PTR",Tool.rect[""])
    T.ADDTOOL(Tool[])
    DetectHiddenWindows,%DetectHiddenWindows%
}
TT_DEL(T,Control){
    If (!Control)
        Return 0
    If (Control+0="")
        ControlGet,Control,Hwnd,,%Control%,% "ahk_id " t.P.hwnd
    T.DELTOOL(T.T[Abs(Control)][]),T.T.Remove(Abs(Control))
}
TT_Color(T,Color:="",Background:=""){
    static TTM_SETTIPBKCOLOR:=0x413,TTM_SETTIPTEXTCOLOR:=0x414
        ,Black:=0x000000,Green:=0x008000,Silver:=0xC0C0C0,Lime:=0x00FF00,Gray:=0x808080,Olive:=0x808000
        ,White:=0xFFFFFF,Yellow:=0xFFFF00,Maroon:=0x800000,Navy:=0x000080,Red:=0xFF0000,Blue:=0x0000FF
        ,Purple:=0x800080,Teal:=0x008080,Fuchsia:=0xFF00FF,Aqua:=0x00FFFF
    If (Color!="")
        T.SETTIPTEXTCOLOR(Color)
    If (BackGround!="")
        T.SETTIPBKCOLOR(BackGround)
}
TT_Text(T,text){
    static TTM_UPDATETIPTEXT:=0x400+(A_IsUnicode?57:12),TTM_UPDATE:=0x400+29
    T.fulltext:=text,T.maintext:=RegExReplace(text,"<a\K[^<]*?>",">"),T.P.lpszText[""]:=text!=""?T.GetAddress("maintext"):0
        ,T.UPDATETIPTEXT()
}
TT_Icon(T,icon:=0,icon_:=1,default:=1){
    static TTM_SETTITLE := 0x400 + (A_IsUnicode ? 33 : 32)
    If icon
        If (icon+0="")
            If !icon:=TT_GetIcon(icon,icon_)
                icon:=default
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETTITLE,"PTR",icon+0,"PTR",T.GetAddress("maintitle"),"PTR"),T.UPDATE()
}
TT_GetIcon(File:="",Icon_:=1){
    global _ICONINFO,_SHFILEINFO
    static hIcon:={},AW:=A_IsUnicode?"W":"A",pToken:=0
        ,temp1:=DllCall( "LoadLibrary", "Str","gdiplus","PTR"),temp2:=VarSetCapacity(si, 16, 0) (si := Chr(1)) DllCall("gdiplus\GdiplusStartup", "PTR*",pToken, "PTR",&si, "PTR",0)
    static sfi:=Struct(_SHFILEINFO),sfi_size:=sizeof(_SHFILEINFO),SmallIconSize:=DllCall("GetSystemMetrics","Int",49)
    If !File {
        for file,obj in hIcon
            If IsObject(obj){
                for icon,handle in obj
                    DllCall("DestroyIcon","PTR",handle)
            } else
                DllCall("DestroyIcon","PTR",handle)
        Return
    }
    If (CR:=InStr(File,"`r") || LF:=InStr(File,"`n"))
        File:=SubStr(file,1,CR<LF?CR-1:LF-1)
    If (hIcon[File,Icon_])
        Return hIcon[file,Icon_]
    else if (hIcon[File] && !IsObject(hIcon[File]))
        return hIcon[File]
    SplitPath,File,,,Ext
    if (hIcon[Ext] && !IsObject(hIcon[Ext]))
        return hIcon[Ext]
    else If (ext = "cur")
        Return hIcon[file,Icon_]:=DllCall("LoadImageW", "PTR", 0, "str", File, "uint", ext="cur"?2:1, "int", 0, "int", 0, "uint", 0x10,"PTR")
    else if InStr(",EXE,ICO,DLL,LNK,","," Ext ","){
        If (ext="LNK"){
            FileGetShortcut,%File%,Fileto,,,,FileIcon,FileIcon_
            File:=!FileIcon ? FileTo : FileIcon
        }
        SplitPath,File,,,Ext
        DllCall("PrivateExtractIcons", "Str", File, "Int", Icon_-1, "Int", SmallIconSize, "Int", SmallIconSize, "PTR*", Icon, "PTR*", 0, "UInt", 1, "UInt", 0, "Int")
        Return hIcon[File,Icon_]:=Icon
    } else if (Icon_=""){
        If !FileExist(File){
            if RegExMatch(File,"^[0-9A-Fa-f]+$")
            {
                nSize := StrLen(File)//2
                VarSetCapacity( Buffer,nSize )
                Loop % nSize
                    NumPut( "0x" . SubStr(File,2*A_Index-1,2), Buffer, A_Index-1, "Char" )
            } else Return
        } else {
            FileGetSize,nSize,%file%
            FileRead,Buffer,*c %file%
        }
        hData := DllCall("GlobalAlloc", "UInt",2, "UInt", nSize,"PTR")
            ,pData := DllCall("GlobalLock", "PTR",hData,"PTR")
            ,DllCall( "RtlMoveMemory", "PTR",pData, "PTR",&Buffer, "UInt",nSize )
            ,DllCall( "GlobalUnlock", "PTR",hData )
            ,DllCall( "ole32\CreateStreamOnHGlobal", "PTR",hData, "Int",True, "PTR*",pStream )
            ,DllCall( "gdiplus\GdipCreateBitmapFromStream", "UInt",pStream, "PTR*",pBitmap )
            ,DllCall( "gdiplus\GdipCreateHBITMAPFromBitmap", "PTR",pBitmap, "PTR*",hBitmap, "UInt",0 )
            ,DllCall( "gdiplus\GdipDisposeImage", "PTR",pBitmap )
            ,ii:=Struct(_ICONINFO)
            ,ii.ficon:=1,ii.hbmMask:=hBitmap,ii.hbmColor:=hBitmap
        return hIcon[File]:=DllCall("CreateIconIndirect","PTR",ii[],"PTR")
    } else If DllCall("Shell32\SHGetFileInfo" AW, "str", File, "uint", 0, "PTR", sfi[], "uint", sfi_size, "uint", 0x101,"PTR")
        Return hIcon[Ext] := sfi.hIcon
}
TT_Close(T){
    T.text("")
}
TT_Show(T,text:="",x:="",y:="",title:="",icon:=0,icon_:=1,defaulticon:=1){
    global _TBBUTTON,_BITMAP,_ICONINFO,_CURSORINFO,_RECT
    static pcursor:= Struct(_CURSORINFO),init:=(pcursor.cbSize:=sizeof(_CURSORINFO))
        ,picon:=Struct(_ICONINFO) ,pbitmap:=Struct(_BITMAP)
        ,TB:=Struct(_TBBUTTON) ,RC:=Struct(_RECT)
    xo:=0,xs:=0,yo:=0,ys:=0
    If (Text!="")
        T.Text(text)
    If (title!="")
        T.SETTITLE(title,icon,icon_,defaulticon)
    If (x="TrayIcon" || y="TrayIcon"){
        DetectHiddenWindows,% (DetectHiddenWindows:=A_DetectHiddenWindows ? "On" : "On")
        PID:=DllCall("GetCurrentProcessId")
        hWndTray:=WinExist("ahk_class Shell_TrayWnd")
        ControlGet,hWndToolBar,Hwnd,,ToolbarWindow321,ahk_id %hWndTray%
        WinGet, procpid, Pid, ahk_id %hWndToolBar%
        DataH := DllCall( "OpenProcess", "uint", 0x38, "int", 0, "uint", procpid,"PTR")
            ,bufAdr := DllCall( "VirtualAllocEx", "PTR", DataH, "PTR", 0, "uint", sizeof(_TBBUTTON), "uint", MEM_COMMIT:=0x1000, "uint", PAGE_READWRITE:=0x4,"PTR")
        Loop % max:=DllCall("SendMessage","PTR",hWndToolBar,"UInt",0x418,"PTR",0,"PTR",0,"PTR")
        {
            i:=max-A_Index
            DllCall("SendMessage","PTR",hWndToolBar,"UInt",0x417,"PTR",i,"PTR",bufAdr,"PTR")
                ,DllCall("ReadProcessMemory", "PTR", DataH, "PTR", bufAdr, "PTR", TB[], "ptr", sizeof(TB), "ptr", 0)
                ,DllCall("ReadProcessMemory", "PTR", DataH, "PTR", TB.dwData, "PTR", RC[], "PTR", 8, "PTR", 0)
            WinGet,BWPID,PID,% "ahk_id " NumGet(RC[],0,"PTR")
            If (BWPID!=PID)
                continue
            If (TB.fsState>7){
                ControlGetPos,xc,yc,xw,yw,Button2,ahk_id %hWndTray%
                xc+=xw/2, yc+=yw/4
            } else {
                ControlGetPos,xc,yc,,,ToolbarWindow321,ahk_id %hWndTray%
                DllCall("SendMessage","PTR",hWndToolBar,"UInt",0x41d,"PTR",i,"PTR",bufAdr,"PTR")
                    ,DllCall( "ReadProcessMemory", "PTR", DataH, "PTR", bufAdr, "PTR", RC[], "PTR", sizeof(RC), "PTR", 0 )
                    ,halfsize:=RC.bottom/2
                    ,xc+=RC.left + halfsize
                    ,yc+=RC.top + (halfsize/1.5)
            }
            WinGetPos,xw,yw,,,ahk_id %hWndTray%
            xc+=xw,yc+=yw
            break
        }
        If (!xc && !yc){
            If (A_OsVersion~="i)Win_7|WIN_VISTA")
                ControlGetPos,xc,yc,xw,yw,Button1,ahk_id %hWndTray%
            else
                ControlGetPos,xc,yc,xw,yw,Button2,ahk_id %hWndTray%
            xc+=xw/2, yc+=yw/4
            WinGetPos,xw,yw,,,ahk_id %hWndTray%
            xc+=xw,yc+=yw
        }
        DllCall( "VirtualFreeEx", "PTR", DataH, "PTR", bufAdr, "PTR", 0, "uint", MEM_RELEASE:=0x8000)
            ,DllCall( "CloseHandle", "PTR", DataH )
        DetectHiddenWindows % DetectHiddenWindows
        If (x="TrayIcon")
            x:=xc
        If (y="TrayIcon")
            y:=yc
    }
    If (x ="" || y =""){
        pCursor.cbSize:=sizeof(pCursor)
            ,DllCall("GetCursorInfo", "ptr", pCursor[])
            ,DllCall("GetIconInfo", "ptr", pCursor.hCursor, "ptr", pIcon[])
        If (picon.hbmColor)
            DllCall("DeleteObject", "ptr", pIcon.hbmColor)
        DllCall("GetObject", "ptr", pIcon.hbmMask, "uint", sizeof(_BITMAP), "ptr", pBitmap[])
            ,hbmo := DllCall("SelectObject", "ptr", cdc:=DllCall("CreateCompatibleDC", "ptr", sdc:=DllCall("GetDC","ptr",0,"ptr"),"ptr"), "ptr", pIcon.hbmMask)
            ,w:=pBitmap.bmWidth,h:=pBitmap.bmHeight, h:= h=w*2 ? (h//2,c:=0xffffff,s:=32) : (h,c:=s:=0)
        Loop % w {
            xi := A_Index - 1
            Loop % h {
                yi := A_Index - 1 + s
                if (DllCall("GetPixel", "ptr", cdc, "uint", xi, "uint", yi) = c) {
                    if (xo < xi)
                        xo := xi
                    if (xs = "" || xs > xi)
                        xs := xi
                    if (yo < yi)
                        yo := yi
                    if (ys = "" || ys > yi)
                        ys := yi
                }
            }
        }
        DllCall("ReleaseDC", "ptr", 0, "ptr", sdc)
            ,DllCall("DeleteDC", "ptr", cdc)
            ,DllCall("DeleteObject", "ptr", hbmo)
            ,DllCall("DeleteObject", "ptr", picon.hbmMask)
        If (y=""){
            SysGet,yl,77
            SysGet,yr,79
            y:=pCursor.y-pIcon.yHotspot+ys+(yo-ys)-s+1
            If !(y >= yl && y <= yr)
                y:=y<yl ? yl : yr
            If (y > yr - 20)
                y := yr - 20
        }
        If (x=""){
            SysGet,xr,78
            SysGet,xl,76
            x:=pCursor.x-pIcon.xHotspot+xs+(xo-xs)+1
            If !(x >= xl && x <= xr)
                x:=x<xl ? xl : xr
        }
    }
    T.TRACKPOSITION(x,y),T.TRACKACTIVATE(1)
}
TT_Set(T,option:="",OnOff:=1){
    static Style:=0x100,NOFADE:=0x20,NoAnimate:=0x10,NOPREFIX:=0x2,AlwaysTip:=0x1,ParseLinks:=0x1000,CloseButton:=0x80,Balloon:=0x40,ClickTrough:=0x20
    If (option ~="i)Style|NOFADE|NoAnimate|NOPREFIX|AlwaysTip|ParseLinks|CloseButton|Balloon"){
        If ((opt:=DllCall("GetWindowLong","PTR",T.HWND,"UInt",-16) & %option%) && !OnOff) || (!opt && OnOff)
            DllCall("SetWindowLong","PTR",T.HWND,"UInt",-16,"UInt",DllCall("GetWindowLong","PTR",T.HWND,"UInt",-16)+(OnOff?(%option%):(-%option%)))
        T.Update()
    } else If (option="ClickTrough"){
        If ((opt:=DllCall("GetWindowLong","PTR",T.HWND,"UInt",-20) & %option%) && !OnOff) || (!opt && OnOff)
            DllCall("SetWindowLong","PTR",T.HWND,"UInt",-20,"UInt",DllCall("GetWindowLong","PTR",T.HWND,"UInt",-20)+(OnOff?(%option%):(-%option%)))
        T.Update()
    } else if !InStr(",__Delete,Push,Pop,InsertAt,Remove,RemoveAt,GetCapacity,SetCapacity,GetAddress,Length,_NewEnum,NewEnum,HasKey,Clone,Count,","," option ",")
        MsgBox Invalid option: %option%
}
TT_Font(T, pFont:="") {
    static WM_SETFONT := 0x30
    italic := InStr(pFont, "italic") ? 1 : 0
    underline := InStr(pFont, "underline") ? 1 : 0
    strikeout := InStr(pFont, "strikeout") ? 1 : 0
    weight := InStr(pFont, "bold") ? 700 : 400
    RegExMatch(pFont, "O)(?<=[S|s])(\d{1,2})(?=[ ,])?", height)
    if (!height.count())
        height := [10]
    RegRead,LogPixels,HKEY_LOCAL_MACHINE,SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontDPI, LogPixels
    height := -DllCall("MulDiv", "int", Height.1, "int", LogPixels, "int", 72)
    RegExMatch(pFont, "O)(?<=,).+", fontFace)
    if (fontFace.Value())
        fontFace := Trim( fontFace.Value())
    else fontFace := "MS Sans Serif"
        If (pFont && !InStr(pFont,",") && (italic+underline+strikeout+weight)=400)
            fontFace:=pFont
    If (T.hFont)
        DllCall("DeleteObject","PTR",T.hfont)
    T.hFont := DllCall("CreateFont", "int", height, "int", 0, "int", 0, "int", 0
        ,"int", weight, "Uint", italic, "Uint", underline
        ,"uint", strikeOut, "Uint", nCharSet, "Uint", 0, "Uint", 0, "Uint", 0, "Uint", 0, "str", fontFace,"PTR")
    Return DllCall("SendMessage","PTR",T.hwnd,"UInt",WM_SETFONT,"PTR",T.hFont,"PTR",TRUE,"PTR")
}
TTM_ACTIVATE(T,Activate:=0){
    static TTM_ACTIVATE := 0x400 + 1
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_ACTIVATE,"PTR",activate,"PTR",0,"PTR")
}
TTM_ADDTOOL(T,pTOOLINFO){
    static TTM_ADDTOOL := A_IsUnicode ? 0x432 : 0x404
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_ADDTOOL,"PTR",0,"PTR",pTOOLINFO,"PTR")
}
TTM_ADJUSTRECT(T,action,prect){
    static TTM_ADJUSTRECT := 0x41f
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_ADJUSTRECT,"PTR",action,"PTR",prect,"PTR")
}
TTM_DELTOOL(T,pTOOLINFO){
    static TTM_DELTOOL := A_IsUnicode ? 0x433 : 0x405
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_DELTOOL,"PTR",0,"PTR",pTOOLINFO,"PTR")
}
TTM_ENUMTOOLS(T,idx,pTOOLINFO){
    static TTM_ENUMTOOLS := A_IsUnicode?0x43a:0x40e
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_ENUMTOOLS,"PTR",idx,"PTR",pTOOLINFO,"PTR")
}
TTM_GETBUBBLESIZE(T,pTOOLINFO){
    static TTM_GETBUBBLESIZE := 0x41e
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETBUBBLESIZE,"PTR",0,"PTR",pTOOLINFO,"PTR")
}
TTM_GETCURRENTTOOL(T,pTOOLINFO){
    static TTM_GETCURRENTTOOL := 0x400 + (A_IsUnicode ? 59 : 15)
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETCURRENTTOOL,"PTR",0,"PTR",pTOOLINFO,"PTR")
}
TTM_GETDELAYTIME(T,whichtime){
    static TTM_GETDELAYTIME := 0x400 + 21
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETDELAYTIME,"PTR",whichtime,"PTR",0,"PTR")
}
TTM_GETMARGIN(T,pRECT){
    static TTM_GETMARGIN := 0x41b
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETMARGIN,"PTR",0,"PTR",pRECT,"PTR")
}
TTM_GETMAXTIPWIDTH(T,wParam:=0,lParam:=0){
    static TTM_GETMAXTIPWIDTH := 0x419
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETMAXTIPWIDTH,"PTR",0,"PTR",0,"PTR")
}
TTM_GETTEXT(T,buffer,pTOOLINFO){
    static TTM_GETTEXT := A_IsUnicode?0x438:0x40b
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETTEXT,"PTR",buffer,"PTR",pTOOLINFO,"PTR")
}
TTM_GETTIPBKCOLOR(T,wParam:=0,lParam:=0){
    static TTM_GETTIPBKCOLOR := 0x416
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETTIPBKCOLOR,"PTR",0,"PTR",0,"PTR")
}
TTM_GETTIPTEXTCOLOR(T,wParam:=0,lParam:=0){
    static TTM_GETTIPTEXTCOLOR := 0x417
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETTIPTEXTCOLOR,"PTR",0,"PTR",0,"PTR")
}
TTM_GETTITLE(T,pTTGETTITLE){
    static TTM_GETTITLE := 0x423
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETTITLE,"PTR",0,"PTR",pTTGETTITLE,"PTR")
}
TTM_GETTOOLCOUNT(T,wParam:=0,lParam:=0){
    static TTM_GETTOOLCOUNT := 0x40d
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETTOOLCOUNT,"PTR",0,"PTR",0,"PTR")
}
TTM_GETTOOLINFO(T,pTOOLINFO){
    static TTM_GETTOOLINFO := 0x400 + (A_IsUnicode ? 53 : 8)
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_GETTOOLINFO,"PTR",0,"PTR",pTOOLINFO,"PTR")
}
TTM_HITTEST(T,pTTHITTESTINFO){
    static TTM_HITTEST := A_IsUnicode?0x437:0x40a
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_HITTEST,"PTR",0,"PTR",pTTHITTESTINFO,"PTR")
}
TTM_NEWTOOLRECT(T,pTOOLINFO:=0){
    static TTM_NEWTOOLRECT := 0x400 + (A_IsUnicode ? 52 : 6)
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_NEWTOOLRECT,"PTR",0,"PTR",pTOOLINFO?pTOOLINFO:T.P[],"PTR")
}
TTM_POP(T,wParam:=0,lParam:=0){
    static TTM_POP := 0x400 + 28
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_POP,"PTR",0,"PTR",0,"PTR")
}
TTM_POPUP(T,wParam:=0,lParam:=0){
    static TTM_POPUP := 0x422
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_POPUP,"PTR",0,"PTR",0,"PTR")
}
TTM_RELAYEVENT(T,wParam:=0,lParam:=0){
    static TTM_RELAYEVENT := 0x407
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_RELAYEVENT,"PTR",0,"PTR",0,"PTR")
}
TTM_SETDELAYTIME(T,whichTime:=0,mSec:=-1){
    static TTM_SETDELAYTIME := 0x400 + 3
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETDELAYTIME,"PTR",whichTime,"PTR",mSec,"PTR")
}
TTM_SETMARGIN(T,left:=0,top:=0,right:=0,bottom:=0){
    static TTM_SETMARGIN := 0x41a
    rc:=T.rc,rc.top:=top,rc.left:=left,rc.bottom:=bottom,rc.right:=right
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETMARGIN,"PTR",0,"PTR",rc[],"PTR")
}
TTM_SETMAXTIPWIDTH(T,maxwidth:=-1){
    static TTM_SETMAXTIPWIDTH := 0x418
    return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETMAXTIPWIDTH,"PTR",0,"PTR",maxwidth,"PTR")
}
TTM_SETTIPBKCOLOR(T,color:=0){
    static TTM_SETTIPBKCOLOR := 0x413
        ,Black:=0x000000, Green:=0x008000,		Silver:=0xC0C0C0,		Lime:=0x00FF00
        ,Gray:=0x808080, 	Olive:=0x808000,		White:=0xFFFFFF, 	Yellow:=0xFFFF00
        ,Maroon:=0x800000,	Navy:=0x000080,		Red:=0xFF0000, 	Blue:=0x0000FF
        ,Purple:=0x800080, Teal:=0x008080,		Fuchsia:=0xFF00FF,	Aqua:=0x00FFFF
    If InStr(",Black,Green,Silver,Lime,gray,olive,white,yellow,maroon,Navy,Red,Blue,Purple,Teal,Fuchsia,Aqua,","," color ",")
        Color:=%color%
    Color := (StrLen(Color) < 8 ? "0x" : "") . Color
    Color := ((Color&255)<<16)+(((Color>>8)&255)<<8)+(Color>>16)
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETTIPBKCOLOR,"PTR",color,"PTR",0,"PTR")
}
TTM_SETTIPTEXTCOLOR(T,color:=0){
    static TTM_SETTIPTEXTCOLOR := 0x414
        ,Black:=0x000000, Green:=0x008000,		Silver:=0xC0C0C0,		Lime:=0x00FF00
        ,Gray:=0x808080, 	Olive:=0x808000,		White:=0xFFFFFF, 	Yellow:=0xFFFF00
        ,Maroon:=0x800000,	Navy:=0x000080,		Red:=0xFF0000, 	Blue:=0x0000FF
        ,Purple:=0x800080, Teal:=0x008080,		Fuchsia:=0xFF00FF,	Aqua:=0x00FFFF
    If InStr(",Black,Green,Silver,Lime,gray,olive,white,yellow,maroon,Navy,Red,Blue,Purple,Teal,Fuchsia,Aqua,","," color ",")
        Color:=%color%
    Color := (StrLen(Color) < 8 ? "0x" : "") . Color
    Color := ((Color&255)<<16)+(((Color>>8)&255)<<8)+(Color>>16)
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETTIPTEXTCOLOR,"PTR",color,"PTR",0,"PTR")
}
TTM_SETTITLE(T,title:="",icon:="",Icon_:=1,default:=1){
    static TTM_SETTITLE := 0x400 + (A_IsUnicode ? 33 : 32)
    If (icon)
        If (icon+0="")
            If !icon:=TT_GetIcon(icon,Icon_)
                icon:=default
    T.maintitle := (StrLen(title) < 96) ? title : (Chr(A_IsUnicode ? 8230 : 133) SubStr(title, -96))
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETTITLE,"PTR",icon+0,"PTR",T.GetAddress("maintitle"),"PTR"),T.UPDATE()
}
TTM_SETTOOLINFO(T,pTOOLINFO:=0){
    static TTM_SETTOOLINFO := A_IsUnicode?0x436:0x409
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_SETTOOLINFO,"PTR",0,"PTR",pTOOLINFO?pTOOLINFO:T.P[],"PTR")
}
TTM_SETWINDOWTHEME(T,theme:=""){
    If !theme
        Return DllCall("UxTheme\SetWindowTheme","PTR",T.HWND,"str","","str","")
    else Return DllCall("SendMessage","PTR",T.HWND,"UInt",0x200b,"PTR",0,"PTR",&theme,"PTR")
}
TTM_TRACKACTIVATE(T,activate:=0,pTOOLINFO:=0){
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",0x411,"PTR",activate,"PTR",(pTOOLINFO)?(pTOOLINFO):(T.P[]),"PTR")
}
TTM_TRACKPOSITION(T,x:=0,y:=0){
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",0x412,"PTR",0,"PTR",(x & 0xFFFF)|(y & 0xFFFF)<<16,"PTR")
}
TTM_UPDATE(T){
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",0x41D,"PTR",0,"PTR",0,"PTR")
}
TTM_UPDATETIPTEXT(T,pTOOLINFO:=0){
    static TTM_UPDATETIPTEXT := A_IsUnicode?0x439:0x40c
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",TTM_UPDATETIPTEXT,"PTR",0,"PTR",pTOOLINFO?pTOOLINFO:T.P[],"PTR")
}
TTM_WINDOWFROMPOINT(T,pPOINT){
    Return DllCall("SendMessage","PTR",T.HWND,"UInt",0x410,"PTR",0,"PTR",pPOINT,"PTR")
}
FileGetInfo( peFile:="", p*) {
    static DLL:="Version\GetFileVersion"
    If ! FSz := DllCall( DLL "InfoSize" (A_IsUnicode ? "W" : "A"), "Str",peFile, "UInt",0 )
        Return DllCall( "SetLastError", UInt,1 ),""
    VarSetCapacity( FVI, FSz, 0 ),DllCall( DLL "Info" ( A_IsUnicode ? "W" : "A"), "Str",peFile, "UInt",0, "UInt",FSz, "PTR",&FVI )
    If !DllCall( "Version\VerQueryValue" (A_IsUnicode ? "W" : "A"), "PTR",&FVI, "Str","\VarFileInfo\Translation", "PTR*",Transl, "PTR",0 )
        Return DllCall( "SetLastError", UInt,2 ),""
    If !Trans:=format("{1:.8X}",NumGet(Transl+0,"UInt"))
        Return DllCall( "SetLastError", UInt,3),""
    for k,v in p
    { subBlock := "\StringFileInfo\" SubStr(Trans,-3) SubStr(Trans,1,4) "\" v
        If ! DllCall( "Version\VerQueryValue" ( A_IsUnicode ? "W" : "A"), "PTR",&FVI, "Str",SubBlock, "PTR*",InfoPtr, "UInt",0 )
            continue
        If Value := StrGet( InfoPtr )
            Info .= p.MaxIndex()=1?Value:SubStr( v " ",1,24 ) . A_Tab . Value . "`n"
    } Info:=RTrim(Info,"`n")
    Return Info
}
BinToHex(addr,len) {
    static b2h
    if !b2h
        b2h:=McodeH(A_PtrSize=8?"4C8BC94585C0744F458BD00F1F440000440FB6024983C10248FFC241C0E8044180E80A410FB6C0C0E805442AC04180C041458841FE0FB64AFF80E10F80E90A0FB6C1C0E8052AC880C14149FFCA418849FF75BD458811C3C60100C3":"558BEC578B7D1085FF74398B4D08568B750C8A06C0E8042C0A8AD0C0EA052AC2044188018A06240F2C0A8AD0C0EA052AC204418841014683C1024F75D55EC601005F5DC38B4508C600005F5DC3","i==ttui")
    VarSetCapacity(hex,2 * len + 1),b2h[&hex,addr,len]
    Return StrGet(&hex,"CP0")
}
MCodeH(h,def,p*){
    static f,DynaCalls
    If !f
        f:={},DynaCalls:={}
    If DynaCalls.HasKey(h)
        return DynaCalls[h]
    f.Insert(h),f.SetCapacity(f.MaxIndex(),len:=StrLen(h)//2)
    DllCall("VirtualProtect","PTR",addr:=f.GetAddress(f.MaxIndex()),"Uint",len,"UInt",64,"Uint*",0)
    Loop % len
        NumPut("0x" SubStr(h,2*A_Index-1,2),addr+0,A_Index-1,"Char")
    if p.MaxIndex()
        Return DynaCalls[h]:=DynaCall(addr,def,p*)
    else Return DynaCalls[h]:=DynaCall(addr,def)
}