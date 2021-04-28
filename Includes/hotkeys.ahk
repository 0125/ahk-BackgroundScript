; reload scripts
    #If !A_IsCompiled
    	~^s::reload
    #If

; context menu
	^+c::Menu, MainMenu, Show ; ctrl + shift + c

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