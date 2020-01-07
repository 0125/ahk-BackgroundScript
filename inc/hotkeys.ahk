; context menu
^+c::Gosub showMainContextMenu ; ctrl + shift + c

; rebinds
backspace::capslock
capslock::backspace
SC056::p ; backwards slash

; volume control
^+WheelUp:: ; ctrl + shift + scroll up
	SoundSet +1
	
	SoundGet, volumeLevel
	
	tooltip % Round(volumeLevel)
	SetTimer, removeToolTip, -250
return
^+WheelDown:: ; ctrl + shift + scroll down
	SoundSet -1
	
	SoundGet, volumeLevel
	
	tooltip % Round(volumeLevel)
	SetTimer, removeToolTip, -250
return