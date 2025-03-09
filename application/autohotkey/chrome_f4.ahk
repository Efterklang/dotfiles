#Requires AutoHotkey v2.0
#SingleInstance Force

; map f4 to ctrl+l in chrome
#HotIf WinActive("ahk_exe chrome.exe")
F4:: Send "^l"
