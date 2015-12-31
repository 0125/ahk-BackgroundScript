#Persistent, force
#SingleInstance, force

#Include E:\Documents\GitHub\Libs\Functions\MyLibs\vpk.ahk

If (A_IsCompiled = 1)
{
	Menu, Tray, NoIcon
}
else
{
	hotkey, ~^s, reloadScript
}

Menu, MyContextMenu, Add, VPK, vpkGui
Menu, MyContextMenu, Add, Close scripts (uncompiled), closeAhk
return

menuHandler:
return

^+c::Menu, MyContextMenu, Show

^+WheelUp::Send {Volume_Up}
^+WheelDown::Send {Volume_Down}

^+f1::vpkGui("show")
^+f2::vpkGui("hide")

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
	Process, Close, Autohotkey.exe
return

vpkGui:
	vpkGui(action)
return

vpkGui(action) {
	If (action = "show")
	{
		gui vpk: +LabelvpkGui_
		gui vpk: +AlwaysOnTop -MinimizeBox
		gui vpk: Add, Text, x0 y0 w150 h100 Center
		gui vpk: Show, w150 h100, VPK - Drag and Drop
	}

	If (action = "hide")
	{
		gui vpk: Destroy
	}

	If (action = "")
		IfWinExist, VPK - Drag and Drop
			vpkGui("hide")
		else
			vpkGui("show")
}

vpkGui_DropFiles:
	If InStr(A_GuiEvent, ".vpk")
		vpk("extract", A_GuiEvent)
	else
		vpk("compile", A_GuiEvent)
return

vpkGui_Close:
	vpkGui("hide")
return

reloadScript:
	reload
return