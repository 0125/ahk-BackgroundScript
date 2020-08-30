IsFile(input) {
    If (FileExist(input) = "A")
        return true
}

IsDir(input) {
    If (FileExist(input) = "D")
        return true
}

getMouseHwnd() {
    ; get hwnd under mouse
    MouseGetPos, OutputVarX, OutputVarY, _Win, OutputVarControl
    WinGetTitle, winTitle, % "ahk_id " _Win
    If !(_Win) {
        msgbox, 64, , % A_ThisFunc ": Could not retrieve handle of window '" winTitle "' under mouse!"
        return false
    }
    return _Win
}