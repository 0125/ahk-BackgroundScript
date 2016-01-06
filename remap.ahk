#Persistent, force
#SingleInstance, force

If (A_IsCompiled = 1)
{
	Menu, Tray, NoIcon
}
else
{
	hotkey, ~^s, reloadScript
}

; context menu
Menu, MyContextMenu, Add, VPK, vpkGui
Menu, MyContextMenu, Add, Compile, compileGui
Menu, MyContextMenu, Add, Close AutoHotkey Scripts, closeAhk

return

menuHandler:
return

^+c::Menu, MyContextMenu, Show

^+WheelUp::Send {Volume_Up}
^+WheelDown::Send {Volume_Down}

:*:work1::"work1.ahk"{enter}	; save work file
:*:work2::"work2.ahk"{enter}	; save work file
:*:work3::"work3.ahk"{enter}	; save work file
:*:work4::"work4.ahk"{enter}	; save work file
:*:work5::"work5.ahk"{enter}	; save work file

:*:example1::"example1.ahk"{enter}	; save example file
:*:example2::"example2.ahk"{enter}	; save example file
:*:example3::"example3.ahk"{enter}	; save example file
:*:example4::"example4.ahk"{enter}	; save example file
:*:example5::"example5.ahk"{enter}	; save example file

#IfWinActive ahk_exe notepad++.exe
	:*:cpath::"$(FULL_CURRENT_PATH)"	; run current file

	XButton1::
		Send +{f2}		; previous bookmark
	return

	XButton2::
		Send {f2}			; next bookmark
	return

	~MButton::
		click
		Send ^{f2}		; toggle bookmark
	return
#IfWinActive

closeAhk:
	; close all other autohotkey scripts
	DetectHiddenWindows On ; List all running instances of this script:
	WinGet instances, List, ahk_class AutoHotkey
	if (instances > 1) { ; There are 2 or more instances of this script.
		this_pid := DllCall("GetCurrentProcessId"),  closed := 0
		Loop % instances { ; For each instance,
			WinGet pid, PID, % "ahk_id " instances%A_Index%
			if (pid != this_pid) { ; If it's not THIS instance,
				WinClose % "ahk_id " instances%A_Index% ; close it.
				closed += 1
			}
		}
	}
return

vpkGui:
	vpkGui()
return

compileGui:
	guiCompile()
return

vpkGui() {
	gui vpk: +LabelvpkGui_ +Hwnd_guiVpk
	gui vpk: +AlwaysOnTop -MinimizeBox
	gui vpk: Add, Text, w150 h75 Center, Drag n Drop
	gui vpk: Show, , Vpk
	WinWaitClose, % "ahk_id " _guiVpk
	gui vpk: Destroy
	return
			
	vpkGui_DropFiles:
		If InStr(A_GuiEvent, ".vpk") ; is dragged item a .vpk file?
			vpk_Extract(A_GuiEvent) ; extract it
		else if ( InStr( FileExist(A_GuiEvent), "D") ) ; is dragged item an existing directory?
			vpk_Compile(A_GuiEvent) ; compile it
	return
}

reloadScript:
	reload
return