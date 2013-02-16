;AHK Remote Server v1.2 and other stuff

NetworkAddress = 0.0.0.0 ;Listen address, 0.0.0.0 = any
NetworkPort    = 8257    ;Listen port

MaxDataLength  = 4096    ;Longest message that can be recieved.

Menu TRAY, Tip, AHK Remote Server`n%A_IPAddress1%
Menu TRAY, Icon, SHELL32.DLL, 125
;Menu TRAY, NoStandard
If A_IsCompiled ;The self-reading trick won't work for compiled scripts.
   CommandList = Standby YouTube SvtPlay ;sample hard-coded list
Else
{
   LabelStart := False
   Loop Read, %A_ScriptFullPath%
   {
      If (NOT LabelStart)
      {
         If InStr(A_LoopReadLine, "===" . "Begin Custom Labels" . "===")
            LabelStart := True
         Else
            Continue
      }
      If RegExMatch(A_LoopReadLine, "^[^\s;]\S*(?=:\s*$)", LabelName)
         CommandList .= " " . LabelName
   }
   CommandList := SubStr(CommandList, 2)
   Menu TRAY, Add
}
Menu TRAY, Add, No Connection, TrayDisconnect
Menu TRAY, Disable, No Connection
RunningCommands := " "


MainSocket := PrepareSocket(NetworkAddress, NetworkPort)
If (MainSocket = -1)
   ExitApp ;failed

DetectHiddenWindows On
Process Exist
MainWindow := WinExist("ahk_class AutoHotkey ahk_pid " . ErrorLevel)
DetectHiddenWindows Off

;^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^
;FD_READ + FD_CLOSE + FD_ACCEPT = 41
If DllCall("Ws2_32\WSAAsyncSelect", "UInt", MainSocket, "UInt", MainWindow, "UInt", 5555, "Int", 41)
;v v v v v v v v v v v v v v v v v v v
{
    MsgBox % "WSAAsyncSelect() indicated Winsock error " . DllCall("Ws2_32\WSAGetLastError")
    ExitApp
}

OnMessage(5555, "ReceiveData", 99) ;Allow 99 (i.e. lots of) threads.
