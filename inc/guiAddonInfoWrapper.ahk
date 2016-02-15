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