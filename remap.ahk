#Persistent, force
#SingleInstance, force

SetTitleMatchMode, 2

dbgview := "c:\Users\64\OneDrive\EXEC\Programs\RegularUse\Installation\Autohotkey\Debug\Dbgview.exe"

return

app(x,y,f:=0)
{
	global
	SplitPath, % x, name, dir, ext, name_no_ext, drive

; Msgbox,, Debug,
; (
; FUNCTION_VARS
; X`t= %x%
; Y`t= %Y%
; F`t= %F% `n
; SPLITPATH - X
; name`t= %name%
; dir`t= %dir%
; ext`t= %ext%
; name_no_ext = %name_no_ext%
; drive`t= %drive%
; )

	if y = 1
	{
		Process, exist, %name%
		If ErrorLevel = 0
		{
			; tooltip running
			run % x
		}
		else
		{
			IfWinExist, % name_no_ext
			{
				; tooltip hiding
				WinHide, % name_no_ext
			}
			else
			{
				; tooltip showing
				WinShow, % name_no_ext
			}
		}
	}
	if y = 0
	{
		Process, close, %name%
	}
	if f != 0
	{
		WinWaitActive, % f
		WinSet, Style, -0xC00000, % b ; hide title bar
		WinSet, Style, -0x800000, % b ; hide thin-line border
		WinSet, Style, -0x400000, % b ; hide dialog frame
		WinSet, Style, -0x40000, % b ; hide thickframe/sizebox
	}
}


~^+f8::
	app(debugclient, 0)
	app(dbgview, 0)
	Process, Close, Autohotkey.exe
return

:*:cdate::
FormatTime, CurrentDateTime,, dd-MM-yy
SendInput %CurrentDateTime%
Send {enter}
return

#IfWinActive ahk_exe notepad++.exe

^+d::
	Process, Close, Autohotkey.exe
	Send ^+{d}
return

~^f8::
	Send ^{f8}
	app(dbgview, 1, "DebugView")
return

:*:cpath::"$(FULL_CURRENT_PATH)"	; run current file
:*:cdebug::"I:\APPS\Autohotkey\AutoHotkey.exe" /Debug "$(FULL_CURRENT_PATH)"	; run current file
:*:remempty::\s{+}$	; regex to remove trailing space and empty lines
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

XButton1::
Send ^!+{space}		; previous bookmark
return

XButton2::
Send !+{space}			; next bookmark
return

~MButton::
Send {LButton}!p		; toggle bookmark
return

#IfWinActive


#IfWinActive ahk_exe sublime_text.exe

^f8::
	app(debugclient, 1, "XDC: XDebugClient")
	app(dbgview, 1, "DebugView")

	Winset, Alwaysontop, On, DebugView
	Winset, Alwaysontop, On, XDebugClient

	WinActivate ahk_exe sublime_text.exe

	sleep 50
	Send ^{f8}
return

#IfWinActive

; break::
	; WinGetTitle, b, A
	; WinSet, Style, ^0xC00000, % b
	; WinSet, Style, -0xC00000, % b ; hide title bar
	; WinSet, Style, -0x800000, % b ; hide thin-line border
	; WinSet, Style, -0x400000, % b ; hide dialog frame
	; WinSet, Style, -0x40000, % b ; hide thickframe/sizebox
; return