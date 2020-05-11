showMainContextMenu:	
	; clear existing menu entries
	Menu, MainMenu, Add
	Menu, MainMenu, DeleteAll

	; crosshair
	If (g_crosshairEnabled)
		Menu, MainMenu, Add, Disable crosshair, MainMenu_disableCrosshair
	else
		Menu, MainMenu, Add, Enable crosshair, MainMenu_enableCrosshair


	Menu, MainMenu, Add, Compile ahk, MainMenu_compileAhkScript
	
	Menu, MainMenu, Show
return

MainMenu_enableCrosshair:
    hwnd := getMouseHwnd()
    If !(hwnd) {
        guiCrosshair()
        g_crosshairEnabled := False
        return
    }
	result := guiCrosshair(A_ScriptDir "\res\crosshair.png", hwnd)
    If (result)
        g_crosshairEnabled := True
return

MainMenu_disableCrosshair:
    guiCrosshair()
	g_crosshairEnabled := False
return

MainMenu_compileAhkScript:
    run % "F:\Programs\AutoHotkey\Lib\guiCompile.ahk"
return

dummyLabel:
return

