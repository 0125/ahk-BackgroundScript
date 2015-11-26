#Persistent, force
#SingleInstance, force

If (A_IsCompiled = 1)
	#NoTrayIcon

return

^+d::
	Process, Close, Autohotkey.exe
	Send ^+{d}
return

#IfWinActive ahk_exe notepad++.exe
	:*:cpath::"$(FULL_CURRENT_PATH)"	; run current file

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
