MainMenu_compileAhkScript() {
    SplitPath, % A_AhkPath , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
	run % OutDir "\Compiler\Ahk2Exe.exe"
}

MainMenu_compileVpk() {
    new ClassGuiCompileVpk("Compile vpk's").Get()
}