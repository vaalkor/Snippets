#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay 25

SetTitleMatchMode, 2 ; This let's any window that partially matches the given name get activated
#IfWinActive, VLC
; Middle mouse button -> Delete video and go to next video in playlist
; This assumes you have the vlc-delete VLC extension installed: https://github.com/surrim/vlc-delete
MButton::
Send {LAlt}
Send {i}
Send {Up}
Send {Enter}
return
; Left side mouse button -> Go to previous video
XButton1::
Send {LAlt}
Send {l}
Send {Up}
Send {Up}
Send {Up}
Send {Enter}
return
; Left side mouse button -> Go to next video
XButton2::
Send {LAlt}
Send {l}
Send {Up}
Send {Up}
Send {Enter}
return