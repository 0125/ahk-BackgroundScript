showMainContextMenu:	
	; clear existing menu entries
	Menu, MainMenu, Add
	Menu, MainMenu, DeleteAll

	Menu, MainMenu, Add, Compile ahk, MainMenu_compileAhkScript
	
	Menu, MainMenu, Show
return

MainMenu_compileAhkScript:
    SplitPath, % A_AhkPath , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
	run % OutDir "\Compiler\Ahk2Exe.exe"
return

dummyLabel:
return

