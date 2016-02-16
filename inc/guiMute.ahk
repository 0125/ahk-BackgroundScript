guiMute() {
	global
	
	; properties
	gui mute: margin, 5, 5
	gui mute: +LabelguiMute_ +Hwnd_guiMute
	
	; controls
	gui mute: Add, Text, x60 y50 w150 Center, Drag n Drop folder
	gui mute: Add, Text, x5 y10 w250 h100 0x7, Drag n Drop folder
	
	gui mute: Add, Edit, w250 r1 Disabled -vscroll vguiMute_folder
	
	gui mute: add, button, w250 r1 gguiMute_btnMute, Mute
	
	; show
	gui mute: show
	
	; hotkeys
	hotkey, IfWinExist, % "ahk_id " _guiMute
		hotkey, escape, guiMute_close
	hotkey, ifwinexist
	
	; close 
	WinWaitClose, % "ahk_id " _guiMute
	gui mute: Destroy
	return
	
	guiMute_close:
		gui mute: destroy
	return
	
	guiMute_btnMute:
		gui mute: submit
		
		guiMute_folder := RTrim(guiMute_folder , "\")
		loop, % guiMute_folder "\*.*", 0, 1
		{
			FileDelete, % A_LoopFileFullPath
			FileAppend, , % A_LoopFileFullPath
		}
		
		gui mute: destroy
	return
	
	guiMute_dropFiles:
		If !InStr(FileExist(A_GuiEvent), "D")
			return
		
		GuiControl mute:, guiMute_folder, % A_GuiEvent
	return
}