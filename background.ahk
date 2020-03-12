#SingleInstance, force
#NoTrayIcon
global g_crosshairEnabled

return

#Include %A_ScriptDir%\inc
#Include contextMainMenu.ahk
#Include functions.ahk
#Include guiCrosshair.ahk
#Include hotkeys.ahk
#Include subroutines.ahk

#If !(A_IsCompiled)
~^s::reload
#If