;-------------------------------------------------------------------------
;   Script for Cyberlink Remote Control
;  Script by elmulti
;  based on code by Micha & evl from www.autohotkey.com/forum/
;  tested in Windows Vista 32bit
;-------------------------------------------------------------------------
; InitRemote() needs to be called once (e.g. in mainscript)
;OnExit, Remote_Cleanup                    ; perform cleanup on exit

; initialize two HIDs vor the Cyberlink Remote Control
Init_Remote()
{
  Global
  HomePath=AutohotkeyRemoteControl.dll          ; Path to AutohotkeyRemoteControl.dll
  hModule := DllCall("LoadLibrary", "str", HomePath)    ; Load the DLL
  OnMessage(0x00FF, "InputMsg")              ; Call InputMsg() when an WM_INPUT-message arrives
  DetectHiddenWindows, on

  ; Register first device
  EditUsage = 136
  EditUsagePage = 65468
  
  Gui, 77:+LastFound                    ; create GUI (#77) to get a handle for DLLCall
  Gui, 77:Show, x0 y0 h0 w0, Autohotkey HID-Support
  HWND := WinExist("Autohotkey HID-Support")
  nRC := DllCall("AutohotkeyRemoteControl\RegisterDevice", INT, EditUsage, INT, EditUsagePage, INT, HWND, "Cdecl UInt")
  if (errorlevel <> 0) || (nRC == -1)
  {
    MsgBox RegisterDevice failed. Errorcode: %errorlevel%`nDLL vorhanden?
    goto Remote_Cleanup
  }
  
  ; Register second device
  EditUsage = 1
  EditUsagePage = 12
  nRC := DllCall("AutohotkeyRemoteControl\RegisterDevice", INT, EditUsage, INT, EditUsagePage, INT, HWND, "Cdecl UInt")
  Winhide, Autohotkey HID-Support              ; hide window
}

#include MS_RemoteButtons.ahk                ; include file for programmed buttons and their actions

; This function is called, when an WM_INPUT-message arrives.
InputMsg(wParam, lParam, msg, hwnd)
{
  Global Vals
  DataSize = 5000
  VarSetCapacity(RawData, %DataSize%)
  ; Write something into the var, so the script won't be aborted :
  RawData = 1
  nRC := DllCall("AutohotkeyRemoteControl\GetWM_INPUTHIDData", UINT, wParam, UINT, lParam, "UINT *" , DataSize, "UINT", &RawData, "Cdecl UInt")    
  if (errorlevel <> 0) || (nRC == -1) 
  {
    MsgBox GetWM_INPUTHIDData failed. Errorcode: %errorlevel%
    goto Remote_Cleanup
  }     
  loop, %DataSize%
  {
    Zahl := NumGet(RawData, a_index-1,"UChar")
    Zahl := Dez2Hex(Zahl)
    Vals = %Vals%%Zahl%
  }

  ; MsgBox %vals%                      ; displays the code for the current key

  Gosub, Key_Action_Check                  ; trigger the action for the current key
  Vals =                           ; reset variable
}

; convert a decimal value into hex
Dez2Hex(Number)
{
    format = %A_FormatInteger%                ; save original integer format
    SetFormat Integer, Hex                  ; for converting bytes to hex
    Number += 0
    SetFormat Integer, %format%                ; restore original format
    StringTrimLeft, Number, Number, 2
    Stringlen := StrLen(Number)
    if Stringlen < 2
    Number = 0%Number%
    return Number
}   

; perform cleanups
Remote_Cleanup:
  DllCall("FreeLibrary", "UInt", hModule)          ; Unload DLL before exiting
  ;ExitApp, 0                        ; exit script
Return

;-------------------------------------------------------------------------
;   End of script for Cyberlink Remote Control
;-------------------------------------------------------------------------