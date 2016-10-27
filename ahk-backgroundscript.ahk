#Include, *i %A_ScriptDir%\fileInstallList.ahk
#Persistent, force
#SingleInstance, force

Gosub loadSettings
return
#Include, %A_ScriptDir%\inc
#Include, guiVpk.ahk
#Include, guiAddonInfoWrapper.ahk
#Include, guiMute.ahk

; hotkeys
^+c::Gosub showContextMenu

^+WheelUp::
	SoundSet +1
	
	SoundGet, volumeLevel
	
	tooltip % Round(volumeLevel)
	SetTimer, removeToolTip, -250
return
^+WheelDown::
	SoundSet -1
	
	SoundGet, volumeLevel
	
	tooltip % Round(volumeLevel)
	SetTimer, removeToolTip, -250
return

removeToolTip:
	tooltip
return

:*:work1::"work1.ahk"{enter}
:*:work2::"work2.ahk"{enter}
:*:work3::"work3.ahk"{enter}
:*:work4::"work4.ahk"{enter}
:*:work5::"work5.ahk"{enter}

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

showContextMenu:
	MouseGetPos, , , g_mouseOverHwnd
	
	Menu, MoveWindow, Add, Center, MoveWindowCenter
	Menu, MoveWindow, Add, Top, MoveWindowTop
	Menu, MoveWindow, Add, Bottom, MoveWindowBottom
	Menu, MoveWindow, Add, Left, MoveWindowLeft
	Menu, MoveWindow, Add, TopLeft, MoveWindowTopLeft
	Menu, MoveWindow, Add, BottomLeft, MoveWindowBottomLeft
	Menu, MoveWindow, Add, Right, MoveWindowRight
	Menu, MoveWindow, Add, TopRight, MoveWindowTopRight
	Menu, MoveWindow, Add, BottomRight, MoveWindowBottomRight
	
	Menu, MyContextMenu, Add, Window, :MoveWindow
	
	Menu, MyContextMenu, Add, VPK, vpkGui
	Menu, MyContextMenu, Add, AddonInfo, addonInfoWrapperGui
	Menu, MyContextMenu, Add, Compile, compileGui
	Menu, MyContextMenu, Add, Mute Files, muteGui
	Menu, MyContextMenu, Add, Close AutoHotkey Scripts, closeAhk
	
	Menu, MyContextMenu, Show
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

MoveWindowCenter:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowTop:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowBottom:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowLeft:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowTopLeft:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowBottomLeft:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowRight:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowTopRight:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return
MoveWindowBottomRight:
	StringReplace, g_output, A_ThisLabel, MoveWindow
	WinMovePos(g_mouseOverHwnd, g_output)
return

~^s::
	If !(A_IsCompiled = 1)
		reload
return