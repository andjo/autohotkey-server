#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
;Menu TRAY, NoStandard
OnExit, ExitSub                           ; do cleanup things on exit to unload DLLs and hide OSDs

#include %A_ScriptDir%\includes
#include Server-head.ahk

Init_OSD()                          ; initializations for Text-OSD
Init_Remote()                        ; initializations for remote control script

Return

#include MS_RemoteControl.ahk
#include MS_TextOSD.ahk

#include Code.ahk

#include Server-functions.ahk

Test()
{
   ;OpenChrome("http://svtplay.se/kontroll", 1)
   Reload
}

TrayDisconnect:
NormalClose()
Return

ExitSub:
TrayExit:
   DllCall("Ws2_32\WSACleanup")
   ;Gosub HideVolumeOSD              ; hide VolumeOSD before
   Gosub Hide_OSD                    ; hide Text Based OSD
   ;Gosub VolumeBar_Hide             ; hide Volume Bar OSD
   Gosub Remote_Cleanup              ; DLL-cleanup for remote control script
   ExitApp, 0                        ; End script
Return

; The following need to be in main file for self parsing stuff to work?

; ==========Begin Custom Labels========== (Do not delete this line.)
; Put a comment after a label to prevent it from being a command.

Standby:
Run "C:\Windows\nircmd.exe" standby
Return

YouTube:
OpenChrome("http://youtube.com/tv", 1)
Return

SvtPlay:
OpenChrome("http://svtplay.se/kontroll", 1)
Return
