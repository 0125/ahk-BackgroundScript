#SingleInstance, force
#Persistent
#NoTrayIcon
return

#Include %A_ScriptDir%\inc
#Include contextMainMenu.ahk
#Include functions.ahk
#Include hotkeys.ahk
#Include subroutines.ahk

#If !(A_IsCompiled)
~^s::reload
#If