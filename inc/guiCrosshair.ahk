guiCrosshair(img = "", hwnd = "") {
	If (img = "") or (hwnd = "") {
		gui crosshair: Destroy
		return false
	}
	
	If !(WinExist("ahk_id " hwnd)) {
		gui crosshair: Destroy
		return false
	}
	
	msgbox % img

	; properties
	gui crosshair: margin, 0, 0
	gui crosshair: -caption +ToolWindow +E0x20 +LastFound
	gui crosshair: +LabelguiCrosshair_ +Hwnd_guiCrosshair
	gui crosshair: +Owner%hwnd%
	gui crosshair: color, Red
	WinSet, TransColor, Red
	
	; controls
	gui crosshair: add, picture, , % img
	
	; show
	gui crosshair: show, Hide NoActivate
	
	WinGetPos( _guiCrosshair, crossX, crossY, crossW, crossH, 1)
	WinGetPos( hwnd, gameX0, gameY0, gameW0, gameH0, 0)
	WinGetPos( hwnd, gameX1, gameY1, gameW1, gameH1, 1)
	
	If !(gameW0 = gameW1) { ; game has a titlebar
		x := gameX0 + (gameW0 / 2) - (crossW / 2)
		y := gameY0 + (gameH0 / 2) - (crossH / 2)
	}
	else {
		x := gameX1 + (gameW1 / 2) - (crossW / 2)
		y := gameY1 + (gameH1 / 2) - (crossH / 2)
	}
	
	; tooltip,
	; ( LTrim
	; gameX0 = %gameX0%
	; gameY0 = %gameY0%
	; gameW0 = %gameW0%
	; gameH0 = %gameH0%
	
	; gameX1 = %gameX1%
	; gameY1 = %gameY1%
	; gameW1 = %gameW1%
	; gameH1 = %gameH1%
	
	; crossX = %crossX%
	; crossY = %crossY%
	; crossW = %crossW%
	; crossH = %crossH%
	
	; x = %x%
	; ), 0, 0
	
	gui crosshair: show, % " x" x " y " y
    WinActivate, % "ahk_id " hwnd
    return true
}