#Include, *i %A_ScriptDir%\fileInstallList.ahk
#Persistent, force
#SingleInstance, force

Gosub loadSettings
Gosub setContextMenu
return
#Include, %A_ScriptDir%\inc
#Include, guiVpk.ahk
#Include, guiAddonInfoWrapper.ahk
#Include, guiMute.ahk

; hotkeys
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

; labels
menuHandler:
return

loadSettings:
If (A_IsCompiled = 1)
{
	Menu, Tray, NoIcon
}
else
{
	hotkey, ~^s, reloadScript
}
return

setContextMenu:
	; context menu
	Menu, MyContextMenu, Add, VPK, vpkGui
	Menu, MyContextMenu, Add, AddonInfo, addonInfoWrapperGui
	Menu, MyContextMenu, Add, Compile, compileGui
	Menu, MyContextMenu, Add, Mute Files, muteGui
	Menu, MyContextMenu, Add, Close AutoHotkey Scripts, closeAhk
return

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
	guiAddonInfoWrapper()
return

vpkGui:
	guiVpk()
return

compileGui:
	guiCompile()
return

muteGui:
	guiMute()
return

reloadScript:
	reload
return