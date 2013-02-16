;-------------------------------------------------------------------------
;   Buttons-script for Cyberlink Remote Control
;  Script by elmulti
;  based on code by Micha & evl from www.autohotkey.com/forum/
;-------------------------------------------------------------------------
; for this script it is best to rename the file "C:\Windows\ehome\ehtray.exe"
; otherwise WMC will start with some of the buttons when it shouldn't


; here the button code is checked and a corresponding subroutine is called
Key_Action_Check:
;  msgbox %vals%
;  IfEqual, Vals, 03010000, GoSub Next
;  IfEqual, Vals, 03020000, GoSub Previous
;  IfEqual, Vals, 03001000, GoSub Stop
;  IfEqual, Vals, 03000008, GoSub Forward
;  IfEqual, Vals, 03000004, GoSub Rewind
;  IfEqual, Vals, 03000080, GoSub Pause
;  IfEqual, Vals, 03000040, GoSub Play
  IfEqual, Vals, 029D00, GoSub Channel-
  IfEqual, Vals, 029C00, GoSub Channel+
;  IfEqual, Vals, 02E200, GoSub Mute
;  IfEqual, Vals, 02EA00, GoSub Volume-
;  IfEqual, Vals, 02E900, GoSub Volume+
  IfEqual, Vals, 035D, GoSub Yellow     ; Backspace
  IfEqual, Vals, 035C, GoSub Green
  IfEqual, Vals, 035B, GoSub Red
;  IfEqual, Vals, 040100, GoSub Homepage
;  IfEqual, Vals, 040200, GoSub LiveTV
;  IfEqual, Vals, 03800000, GoSub Record
;  IfEqual, Vals, 03040000, GoSub Radio
;  IfEqual, Vals, 040010, GoSub SAP
;  IfEqual, Vals, 040020, GoSub Teletext
;  IfEqual, Vals, 040040, GoSub LastChannel
;  IfEqual, Vals, 040008, GoSub Subtitles
;  IfEqual, Vals, 040002, GoSub Language
;  IfEqual, Vals, 040001, GoSub Angle
;  IfEqual, Vals, 022402, GoSub Back
  IfEqual, Vals, 020902, GoSub Info
  IfEqual, Vals, 0324, GoSub Menu
  IfEqual, Vals, 035e, GoSub Blue       ; Favorites          :^+t
  IfEqual, Vals, 0327, GoSub Zoom       ; Toggle full screen :Tab
  IfEqual, Vals, 0347, GoSub Music
  IfEqual, Vals, 0349, GoSub Picture
  IfEqual, Vals, 034a, GoSub Video
Return
     

#IfWinActive ahk_class XBMC
#:: Send c
#IfWinActive

;OnMessage(0x0319, "WM_APPCOMMAND")
;
;WM_APPCOMMAND(wParam, lParam, msg, hwnd)
;{
;  if lParam = 65536
;  {
;    msgbox Blocked
;    return 0
;  }
;  else
;  {
;    ToolTip wParam %wParam% lParam %lParam% msg %msg% hwnd %hwnd%
;  }
;}
  
; this adds a Winamp OSD if WMC and MPC are not active
;Next: ; Next
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if !WinActive("ahk_class MediaPlayerClassicW")      ; if Media Player Classic is not active
;    {
;      Sleep 100
;      Winamp_OSD()                    ; else display Winamp OSD (if Winamp runs)
;    }
;  }
;Return
;
;; this adds a Winamp OSD if WMC and MPC are not active
;Previous: ; Previous
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if !WinActive("ahk_class MediaPlayerClassicW")      ; if Media Player Classic is not active
;    {
;      Sleep 100
;      Winamp_OSD()                    ; else display Winamp OSD (if Winamp runs)
;    }
;  }
;Return
;
;; button works, do nothing here
;Stop: ; Stop
;Return
;
;; make medium jump forward in MPC or fast-forward in Winamp
;Forward: ; Forward
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if WinActive("ahk_class MediaPlayerClassicW")      ; only if Media Player Classic is active
;      SendMessage, 0x111, 902, 0,,ahk_class MediaPlayerClassicW ; medium jump forward in MPC
;    else if WinExist("ahk_class Winamp v1.x")        ; only if Winamp is running
;      SendMessage, 0x111, 40148, 0,,ahk_class Winamp v1.x  ; fast-forward 5 seconds
;  }
;Return
;
;; make medium jump backward in MPC or fast-rewind in Winamp
;Rewind: ; Rewind
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if WinActive("ahk_class MediaPlayerClassicW")      ; only if Media Player Classic is active
;      SendMessage, 0x111, 901, 0,,ahk_class MediaPlayerClassicW ; medium jump backward in MPC
;    else if WinExist("ahk_class Winamp v1.x")        ; only if Winamp is running
;      SendMessage, 0x111, 40144, 0,,ahk_class Winamp v1.x  ; fast-rewind 5 seconds
;  }
;Return
;
;; do nothing in WMC, play/pause in MPC, else play/pause Winamp if it is running
;Pause: ; Pause
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if WinActive("ahk_class MediaPlayerClassicW")      ; only if Media Player Classic is active
;      SendMessage, 0x111, 889, 0,,ahk_class MediaPlayerClassicW ; play/pause in MPC
;    else if WinExist("ahk_class Winamp v1.x")        ; only if Winamp is running
;      Winamp_PlayPause()                  ; play/pause Winamp
;  }
;Return
;
;; do nothing in WMC, play/pause in MPC, else play/pause Winamp or run Winamp and start playing
;Play: ; Play
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if WinActive("ahk_class MediaPlayerClassicW")      ; only if Media Player Classic is active
;      SendMessage, 0x111, 889, 0,,ahk_class MediaPlayerClassicW ; play/pause in MPC
;    else
;      Winamp_PlayPause()                  ; play/pause Winamp (or run Winamp and start playing)
;  }
;Return
;
;; if WMC is not active, switch two programs back with Alt+Shift+2xTab
;Channel-: ; Channel-
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    Send {Alt down}{Shift down}{Tab 2}
;    Send {Alt up}{Shift up}
;  }
;Return
;
;; if WMC is not active, switch to last program with Alt+Tab
;Channel+: ; Channel+
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    Send {Alt down}{Tab}
;    Send {Alt up}
;  }
;Return


Channel-:
  if !WinActive("ahk_class XBMC")        ; if XBMC is not active
  {
    ;Send {Alt down}{Shift down}{Tab 2}
    Send {Alt down}{Shift down}{Tab}
    Send {Alt up}{Shift up}
  }
  else
  {
    Send {PgDn}
  }
Return

Channel+:
  if !WinActive("ahk_class XBMC")        ; if XBMC is not active
  {
    Send {Alt down}{Tab}
    Send {Alt up}
  }
  else
  {
    Send {PgUp}
  }
Return


;
;; add OSD dependent on mute status
;Mute: ; Mute
;  COM_Init()
;  SoundIsMuted := VA_GetMute()
;  COM_Term()
;  if SoundIsMuted
;    Display_OSD("Mute on")
;  else
;    Display_OSD("Mute off")
;Return
;
;; set the flag for remote controlled volume change
;Volume-: ; Volume-
;  Remote_Volume_Flag := 1                    ; set the flag
;  SetTimer, Reset_Remote_Flag, 3000              ; reset flag after 3 seconds
;Return
;
;; set the flag for remote controlled volume change
;Volume+: ; Volume+
;  Remote_Volume_Flag := 1                    ; set the flag
;  SetTimer, Reset_Remote_Flag, 3000              ; reset flag after 3 seconds
;Return
;
;; if WMC is not active, run Skype. If it was running, it is brought to the top.
;Yellow: ; Yellow (Pictures)
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if !WinExist("ahk_class tSkMainForm.UnicodeClass")    ; if Skype is not running
;    {
;      Display_OSD("Skype")                ; display OSD
;    }
;    Run, "%ProgramFiles%\Skype\Phone\Skype.exe"        ; run Skype (or bring it to the top)
;  }
;Return
;
;; if WMC is not active, run Winamp. If Winamp was running, it is brought to the top.
;Green: ; Green (Music)
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if !WinExist("ahk_class Winamp v1.x")          ; if Winamp is not running
;    {
;      Display_OSD("Winamp")                ; display OSD
;    }
;    Run, "%ProgramFiles%\Winamp\winamp.exe"          ; run Winamp (or bring it to the top)
;  }
;Return
;
;; if WMC is not active, run Windows Mail. If it was running, it is brought to the top.
;Red: ; Red (DVD)
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if !WinExist("ahk_class Outlook Express Browser Class")  ; if Windows Mail is not running
;    {
;      Display_OSD("Windows Mail")              ; display OSD
;    }
;    Run, "%ProgramFiles%\Windows Mail\WinMail.exe"      ; run Windows Mail (or bring it to the top)
;  }
;Return

; Green (close XBMC
Green:
  if WinActive("ahk_class XBMC")
    Send ^+s
Return



; Red (DVD)
Red:
  if WinExist("ahk_class XBMC")        ; if XBMC is not active
  {
    WinActivate
    WinMaximize
  }
  else
  {
    Display_OSD("XBMC")              ; display OSD
    Run, "%ProgramFiles%\XBMC\XBMC.exe"      ; run XBMC
  }
Return

;
;; if WMC is not active, run ICQ. If it was running, it is brought to the top.
;Blue: ; Blue (Videos)
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    if !WinExist("ahk_class __oxFrame.class__")        ; if ICQ is not running
;    {
;      Display_OSD("ICQ")                  ; display OSD
;    }
;    Run, "%ProgramFiles%\ICQ6.5\ICQ.exe"          ; run ICQ (or bring it to the top)
;  }
;Return

Blue:
  if WinActive("ahk_class XBMC")
  {
    Send ^+t
  }
Return


;; display OSD and run Windows Media Center.
;; If it was running, it wil automatically maximize and go to the menu
;Homepage: ; Homepage
;  if !WinExist("ahk_class eHome Render Window")        ; if Windows Media Center is not running
;  {
;    Display_OSD("Windows Media Center")            ; display OSD
;  }
;  Run, "C:\Windows\ehome\ehshell.exe"              ; run Windows Media Center or maximize it/go to menu
;Return
;
;; if Windows Media Center is not active, run it in Live-TV mode
;; otherwise it will switch to Live-TV itself
;LiveTV: ; Live TV
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    Display_OSD("Live TV")                  ; display OSD and run WMC
;    Run, "C:\Windows\ehome\ehshell.exe" /homepage:VideoFullscreen.xml /PushStartPage:True  ; run MCE in Live-TV
;  }
;Return
;
;; display OSD and switch monitor off, if WMC is not active. Any button or key should wake the monitor.
;Record: ; Record
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;  {
;    ; display message to announce monitor switching off
;    Display_OSD("Monitor off...", transparent := false, small := true)
;    ; wait 500ms. If you use this with a hotkey, not sleeping will make it so your input wakes up the monitor immediately
;    Sleep 500
;    ; switch monitor off
;    SendMessage, 0x112, 0xF170, 2,, Program Manager      ; 0x112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.
;    ; note this actually turns off monitors, not just standby, tho in practice i didnt see any difference  
;  }
;Return
;
;; send Alt+F4 to close the active program
;Radio: ; Radio
;    Send !{F4}                        ; Alt+F4
;    Sleep 300                          ; wait 300ms, so the hotkey is not send multiple times
;Return
;
;; increse Volume by 30% and display progress bar
;SAP: ; SAP
;  COM_Init()                          ; initialize COM library
;  vol_tmp := VA_GetMasterVolume()                ; get current master volume level
;  vol_Master := (vol_tmp + 30)                ; increase level by 30%
;  VA_SetMasterVolume(vol_Master)                ; set new master volume level
;  COM_Term()                          ; terminate COM library
;  
;  Display_VolumeBar()                      ; display progress bar with current volume level
;Return
;
;; switch shuffle mode in Winamp On/Off, if winamp is running (with OSD)
;Teletext: ; Teletext/CC
;  if WinExist("ahk_class Winamp v1.x")            ; only if Winamp is running
;  {
;    SendMessage, 0x111, 40023, 0,,ahk_class Winamp v1.x    ; toggle shuffle in Winamp
;    
;    SendMessage, 0x400, 0, 250,,ahk_class Winamp v1.x    ; query shuffle status: 0=off, 1=on
;    if ErrorLevel <> FAIL                  ; check if query failed or not
;    {
;      if ErrorLevel = 0                  ; if shuffle is off, set string to "Off"
;        New_Shuffle_Status := "Off"
;      else if ErrorLevel = 1                ; if shuffle is on, set string to "On"
;        New_Shuffle_Status := "On"
;    }    
;    Display_OSD("Winamp: Shuffle " . New_Shuffle_Status, transparent := false, small := true)  ; display OSD text
;  }
;Return
;
;; do nothing here - this key is doing nothing so far
;LastChannel: ; Last Channel
;Return
;
;; if MPC is active, switch subtitles by sending S key,
;; else decrease Volume by 30% and display progress bar
;Subtitles: ; Subtitles
;    if WinActive("ahk_class MediaPlayerClassicW")        ; only if Media Player Classic is active
;  {
;    Display_OSD("Switch Subtitles", transparent := true)  ; display OSD text
;    SendMessage, 0x111, 953, 0,,ahk_class MediaPlayerClassicW ; next subtitle in MPC
;  }
;  else
;  {  
;    COM_Init()                          ; initialize COM library
;    vol_tmp := VA_GetMasterVolume()                ; get current master volume level
;    vol_Master := (vol_tmp - 30)                ; decrease level by 30%
;    VA_SetMasterVolume(vol_Master)                ; set new master volume level
;    COM_Term()                          ; terminate COM library
;    
;    Display_VolumeBar()                      ; display progress bar with current volume level
;  }
;Return
;
;; launch EPG in WMC or change language in MPC
;Language: ; Language
;  if WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is active
;  {
;    Send ^g                          ; Send Ctrl+g for Electronic Program Guide (EPG) in WMC
;  }
;  else if WinActive("ahk_class MediaPlayerClassicW")      ; if Media Player Classic is active
;  {
;    Display_OSD("Change Audio Language", transparent := true) ; display transparent OSD
;    SendMessage, 0x111, 951, 0,,ahk_class MediaPlayerClassicW ; next audio track in MPC
;  }
;Return
;
;; Send Alt+Enter to maximize/minimize Media Player Classic
;Angle: ; Angle
;  Send !{Enter}
;Return
;
;; if WMC is not active, send escape key (eg. for Irfan-View)
;Back: ; Back
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is not active
;    Send {Esc}                        ; send Escape key
;Return
;

Yellow:
;  if WinActive("ahk_class XBMC")
    Send {Backspace}
Return

;; if WMC is not active, display Winamp OSD
;Info: ; Info/EPG
;  if !WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is active
;    Winamp_OSD()                      ; display Winamp OSD (if Winamp runs)
;Return

Info:
  if WinActive("ahk_class XBMC")        ; if XBMC
    Send, i
Return


;
;; change zoom mode in Windows Media Center (switch between 4:3 and 16:9)
;DVD: ; DVD Menu
;  if WinActive("ahk_class eHome Render Window")        ; if Windows Media Center is active
;  {
;    ; send Enter to close the prompt that appears because WMC wants to go to DVD mode
;    ; this doesn't work 100% of the time
;    Send {Enter}
;    Sleep 10                        ; the sleep time might help for the workaround in the last line
;    Send ^+z                        ; send Ctrl+Shift+z to change zoom mode
;  }
;  else                            ; else
;  {
;    Send {RWin}                        ; Send Windows key to open the start menu
;  }
;Return

; DVD Menu
Menu:
  if WinActive("ahk_class XBMC")
    Send ^+m
  Return

Zoom:
  if WinActive("ahk_class XBMC")
    Send {Tab}
  else if WinActive("ahk_class Chrome_WidgetWin_1")
    ControlSend, Chrome_RenderWidgetHostHWND1, {F11}
   Return
 
Music:
  if WinActive("ahk_class XBMC")
    Send ^m
  Return

Picture:
  if WinActive("ahk_class XBMC")
    Send ^i
  Return

Video:
  if WinActive("ahk_class XBMC")
    Send ^+e
  Return


;-------------------------------------------------------------------------
;   End of buttons-script for Cyberlink Remote Control
;-------------------------------------------------------------------------

