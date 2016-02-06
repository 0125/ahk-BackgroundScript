#Include, *i %A_ScriptDir%\fileInstallList.ahk

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
Menu, MyContextMenu, Add, AddonInfo, addonInfoWrapperGui
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


addonInfoWrapperGui:
	addonInfoWrapper_Gui()
return

vpkGui:
	vpk_Gui()
return

compileGui:
	guiCompile()
return

vpk_Gui() {
	global
	
	gui vpk: +LabelvpkGui_ +Hwnd_guiVpk
	gui vpk: +AlwaysOnTop -MinimizeBox
	gui vpk: Add, Text, x60 y50 w150 Center, Drag n Drop
	gui vpk: Add, Text, x10 y10 w250 h100 0x7, Drag n Drop
	
	gui vpk: Add, Text, , Source
	gui vpk: Add, Edit, w250 r2 Disabled -vscroll vvpk_Source
	
	gui vpk: Add, Text, , Title
	gui vpk: Add, Edit, w250 r1 -multi Disabled vvpk_CompileTitle
	gui vpk: Add, Button, w250 vvpkGui_btnCompile gvpkGui_btnCompile Disabled
	
	gui vpk: Show, , Vpk
	WinWaitClose, % "ahk_id " _guiVpk
	gui vpk: Destroy
	return

	vpkGui_DropFiles:
		vpk_Source := A_GuiEvent
		
		SplitPath, vpk_Source, , vpk_SourceDir, , vpk_OriginalCompileTitle
		
		GuiControl vpk:, vpk_Source, % vpk_Source
		
		If InStr(vpk_Source, ".vpk") ; is dragged item a .vpk file?
		{
			GuiControl vpk:, vpkGui_btnCompile, Extract
			GuiControl vpk: enable, vpkGui_btnCompile
			
			GuiControl vpk:, vpk_CompileTitle, % vpk_OriginalCompileTitle
			GuiControl vpk: disable, vpk_CompileTitle
		}
		else if ( InStr( FileExist(vpk_Source), "D") ) ; is dragged item an existing directory?
		{
			GuiControl vpk:, vpkGui_btnCompile, Compile
			GuiControl vpk: enable, vpkGui_btnCompile
			
			GuiControl vpk:, vpk_CompileTitle, % vpk_OriginalCompileTitle
			GuiControl vpk: enable, vpk_CompileTitle
		}
		else
		{
			GuiControl vpk:, vpkGui_btnCompile
			GuiControl vpk: disable, vpkGui_btnCompile
			
			GuiControl vpk:, vpk_CompileTitle
			GuiControl vpk: disable, vpk_CompileTitle
		}
	return
	
	vpkGui_btnCompile:
		gui vpk: Submit
	
		If InStr(vpk_Source, ".vpk") ; is dragged item a .vpk file?
			vpk_Extract(vpk_Source) ; extract it
		else if ( InStr( FileExist(vpk_Source), "D") ) ; is dragged item an existing directory?
		{
			vpk_Compile(vpk_Source) ; compile it
			; msgbox % vpk_SourceDir "\" vpk_OriginalCompileTitle ".vpk" "->`n`n" vpk_SourceDir "\" vpk_CompileTitle ".vpk"
			FileMove, % vpk_SourceDir "\" vpk_OriginalCompileTitle ".vpk", % vpk_SourceDir "\" vpk_CompileTitle ".vpk"
		}
		
		gui vpk: Destroy
	return
}

addonInfoWrapper_Gui() {
	global
	
	gui addonInfoWrapper: +LabeladdonInfoWrapperGui_ +Hwnd_guiaddonInfoWrapper
	gui addonInfoWrapper: +AlwaysOnTop -MinimizeBox
	gui addonInfoWrapper: Add, Text, x60 y50 w150 Center, Drag n Drop
	gui addonInfoWrapper: Add, Text, x10 y10 w250 h100 0x7, Drag n Drop
	
	gui addonInfoWrapper: Show, , addonInfoWrapper
	WinWaitClose, % "ahk_id " _guiaddonInfoWrapper
	gui addonInfoWrapper: Destroy
	return

	addonInfoWrapperGui_DropFiles:
		addonInfoWrapper_Source := A_GuiEvent
		SplitPath, addonInfoWrapper_Source, addonInfoWrapper_SourceFileName
		If (addonInfoWrapper_SourceFileName = "addoninfo.txt")
			guiAddonInfo(addonInfoWrapper_Source)
		else
			msgbox Specified file is not addoninfo.txt
		gui addonInfoWrapper: Destroy
	return
}

reloadScript:
	reload
return