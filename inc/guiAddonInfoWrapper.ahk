guiAddonInfoWrapper() {
	global
	
	; properties
	gui addonInfo: +LabelguiAddonInfo_ +Hwnd_guiaddonInfo
	gui addonInfo: +AlwaysOnTop -MinimizeBox
	
	; controls
	gui addonInfo: Add, Text, x60 y50 w150 Center, Drag n Drop
	gui addonInfo: Add, Text, x10 y10 w250 h100 0x7, Drag n Drop
	
	; show
	gui addonInfo: Show, , addonInfo
	
	; hotkeys
	hotkey, IfWinExist, % "ahk_id " _guiaddonInfo
		hotkey, escape, guiAddonInfo_Close
	hotkey, ifwinexist
	
	; close
	WinWaitClose, % "ahk_id " _guiaddonInfo
	gui addonInfo: Destroy
	return
	
	guiAddonInfo_Close:
		gui addonInfo: destroy
	return
	
	guiAddonInfo_DropFiles:
		addonInfo_Source := A_GuiEvent
		SplitPath, addonInfo_Source, addonInfo_SourceFileName
		If (addonInfo_SourceFileName = "addoninfo.txt")
			guiAddonInfo(addonInfo_Source)
		else
			msgbox Specified file is not addoninfo.txt
		gui addonInfo: Destroy
	return
}