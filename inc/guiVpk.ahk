guiVpk() {
	global
	
	; properties
	gui vpk: +LabelguiVpk_ +Hwnd_guiVpk
	gui vpk: +AlwaysOnTop -MinimizeBox
	
	; controls
	gui vpk: Add, Text, x60 y50 w150 Center, Drag n Drop
	gui vpk: Add, Text, x10 y10 w250 h100 0x7, Drag n Drop
	
	gui vpk: Add, Text, , Source
	gui vpk: Add, Edit, w250 r2 Disabled -vscroll vvpk_Source
	
	gui vpk: Add, Text, , Title
	gui vpk: Add, Edit, w250 r1 -multi Disabled vvpk_CompileTitle
	gui vpk: Add, Button, w250 vguiVpk_btnCompile gguiVpk_btnCompile Disabled
	
	; show
	gui vpk: Show, , Vpk
	
	; hotkeys
	hotkey, ifwinactive, % "ahk_id " _guiVpk
		hotkey, enter, guiVpk_btnCompile
	hotkey, ifwinactive
	hotkey, ifwinexist, % "ahk_id " _guiVpk
		hotkey, escape, guiVpk_close
	hotkey, ifwinexist
	
	; close
	WinWaitClose, % "ahk_id " _guiVpk
	gui vpk: Destroy
	return

	guiVpk_close:
		gui vpk: destroy
	return
	
	guiVpk_DropFiles:
		vpk_Source := A_GuiEvent
		
		msgbox % vpk_Source
		
		SplitPath, vpk_Source, , vpk_SourceDir, , vpk_OriginalCompileTitle
		
		GuiControl vpk:, vpk_Source, % vpk_Source
		
		If InStr(vpk_Source, ".vpk") ; is source a .vpk file?
		{
			GuiControl vpk:, guiVpk_btnCompile, Extract
			GuiControl vpk: enable, guiVpk_btnCompile
			
			GuiControl vpk:, vpk_CompileTitle, % vpk_OriginalCompileTitle
			GuiControl vpk: disable, vpk_CompileTitle
		}
		else if ( InStr( FileExist(vpk_Source), "D") ) ; is source an existing directory?
		{
			GuiControl vpk:, guiVpk_btnCompile, Compile
			GuiControl vpk: enable, guiVpk_btnCompile
			
			GuiControl vpk:, vpk_CompileTitle, % vpk_OriginalCompileTitle
			GuiControl vpk: enable, vpk_CompileTitle
		}
		else
		{
			GuiControl vpk:, guiVpk_btnCompile
			GuiControl vpk: disable, guiVpk_btnCompile
			
			GuiControl vpk:, vpk_CompileTitle
			GuiControl vpk: disable, vpk_CompileTitle
		}
	return
	
	guiVpk_btnCompile:
		gui vpk: Submit
	
		If InStr(vpk_Source, ".vpk") ; is dragged item a .vpk file?
			vpk_Extract(vpk_Source) ; extract it
		else if ( InStr( FileExist(vpk_Source), "D") ) ; is dragged item an existing directory?
		{
			vpk_Compile(vpk_Source) ; compile it
			; msgbox % vpk_SourceDir "\" vpk_OriginalCompileTitle ".vpk" "->`n`n" vpk_SourceDir "\" vpk_CompileTitle ".vpk"
			FileMove, % vpk_SourceDir "\" vpk_OriginalCompileTitle ".vpk", % vpk_SourceDir "\" vpk_CompileTitle ".vpk"
		}
	return
}
