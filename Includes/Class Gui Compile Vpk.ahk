Class ClassGuiCompileVpk extends gui {
    Get() {
        ; properties
        this.DropFilesToggle(true)

        ; controls
        this.add("text", "w300 h50 0x200 center border", "drag n drop")
        
        this.add("text", "w300", "Path")
        this._dirPathEdit := this.add("edit", "w300 r3", "")

        this.add("text", "w300", "Name")
        this._vpkNameEdit := this.add("edit", "w300 r1", "")

        this.add("button", "w300", "compile", this.btnCompile.Bind(this))
        
        ; show
        ; this.Show("x0 y0 noactivate")
        this.Show()

        ; debugDirPath := "D:\Games\Tools, savegames, information & more\L4D\.L4D2 Actively Used Mods\l4d2-mod-files-master\source\various hud changes"
        ; this._HandleDroppedDir(debugDirPath)
        ; this.btnCompile()
    }

    btnCompile() {
        vpkDir := this.GetText(this._dirPathEdit)
        vpkName := this.GetText(this._vpkNameEdit)
        vpkFilePath := vpkDir "\" vpkName ".vpk"

        ; check valid input
        If !IsDir(vpkDir) {
            Msg("Info", A_ThisFunc, "Folder does not exist!")
            return
        }
        If !vpkName {
            Msg("Info", A_ThisFunc, "No name specified!")
            return
        }
        If FileExist(vpkFilePath) {
            Msg("InfoYesNo", A_ThisFunc, "Overwrite existing VPK?`n`n" vpkFilePath)
            IfMsgBox, No
                return
        }
        this._CompileVpk(vpkDir)

        ; rename the vpk
        SplitPath, vpkDir, vpkDirName, vpkParentDir
        ; msgbox % vpkParentDir "\" vpkDirName ".vpk" "`n`n`n`n" vpkParentDir "\" vpkName ".vpk"
        FileMove, % vpkParentDir "\" vpkDirName ".vpk", % vpkParentDir "\" vpkName ".vpk", 1
    }

    DropFiles(droppedFilesObj := "", param2 := "", param3 := "", param4 := "", param5 := "") {
        ; msgbox % param1 "`n`n" param2 "`n`n" param3 "`n`n" param4 "`n`n" param5
        dropPath := droppedFilesObj[1]
        
        this._HandleDroppedDir(dropPath)
    }

    _HandleDroppedDir(dirPath) {
        SplitPath, dirPath, dirName, dirParent

        ; check valid input
        If !IsDir(dirPath) {
            Msg("Info", A_ThisFunc, "Can only compile folders!")
            return
        }
        
        ; set dir path
        this.SetText(this._dirPathEdit, dirPath)

        ; set edit name
        addonInfoFilePath := dirPath "\addoninfo.txt"
        
        If !FileExist(addonInfoFilePath) {
            Msg("Info", A_ThisFunc, "Folder does not contain 'addoninfo.txt'")
            return
        }

        obj := this._GetAddonInfoObj(addonInfoFilePath)
        this.SetText(this._vpkNameEdit, obj.addonTitle)
    }

    _CompileVpk(filePath) {
        PATH_VPKEXE_COMPILE := A_ScriptDir "\Assets\VPK Tool\left4dead\vpk.exe"
        PATH_VPKEXE_EXTRACT := A_ScriptDir "\Assets\VPK Tool\nosteam\vpk.exe"

        If IsDir(filePath)
            exe := PATH_VPKEXE_COMPILE
        else
            exe := PATH_VPKEXE_EXTRACT

        RunWait % exe A_Space """" filePath """", , Hide
    }

    _GetAddonInfoObj(filePath) {
        FileRead, addonInfoStr, % filePath
        
        ; get object
        obj := []
        loop, parse, addonInfoStr, `n
            obj.push(A_LoopField)

        ; get key + values
        output := []
        for index, line in obj {
            ; set indentation
            If InStr(line, "{")
                indent++
            If InStr(line, "}")
                indent--
            
            ; get key
            key := StringBetween(line, """", """")

            ; skip junk lines
            If !key or !indent
                Continue

            ; get value by removing key + remaining junk from line
            value := StrReplace(line, key)
            value := StrReplace(value, """")
            value := StrReplace(value, "`r") ; new line
            value := Trim(value)
            
            ; get key by removign value + junk from line
            key := StrReplace(line, value)
            key := StrReplace(key, """")
            key := StrReplace(key, "`r") ; new line
            key := Trim(key)

            output[value] := key
        }
        return output
    }
}