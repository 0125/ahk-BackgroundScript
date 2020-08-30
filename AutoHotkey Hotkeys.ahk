; script properties
    #SingleInstance, force
    #Persistent
    If A_IsCompiled
        Menu, Tray, NoIcon
    Global DEBUG_MODE := true

; autoexec
    #Include %A_ScriptDir%\Includes\menu.ahk

    ; Menu, MainMenu, Show
return

; labels
    dummyLabel:
    return
    removeToolTip:
        tooltip
    return

; includes
    #Include %A_ScriptDir%\Includes\Class Gui Compile Vpk.ahk
    #Include %A_ScriptDir%\Includes\menu functions.ahk
    #Include %A_ScriptDir%\Includes\functions.ahk
    #Include %A_ScriptDir%\Includes\hotkeys.ahk
    #Include %A_ScriptDir%\Includes\Func Msg.ahk

; libraries
    #Include %A_ScriptDir%\Libraries\Class Gui.ahk
    #Include %A_ScriptDir%\Libraries\GuiButtonIcon.ahk
    #Include %A_ScriptDir%\Libraries\StringBetween.ahk
    #Include %A_ScriptDir%\Libraries\JSON.ahk