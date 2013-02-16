;-------------------------------------------------------------------------
;	Text Based OSD with WinampOSD
;	Script by elmulti
;	call Winamp_OSD() or Display_OSD("This is text") or
;	Display_OSD("This is text", transparent := true, small := true)
;-------------------------------------------------------------------------
; InitOSD() needs to be called once (e.g. in mainscript)

; initialize variables, make changes here
Init_OSD()
{
	Global
	; OSD_Settings
	OSD_Font_Size_1     := 48								; recommended: 48
	OSD_Font_Size_2     := 24								; recommended: 24
	OSD_Displaytime     := 2000								; display time in ms, recommended: 2000
	OSD_Position_Y      := A_ScreenHeight - 185				; recommended: A_ScreenHeight - 185		
	OSD_MaxWidth		:= A_ScreenWidth - 200				; recommended: A_ScreenWidth - 200		
	OSD_Textcolor       := 0x00FF00							; recommended: 0x00FF00 (Lime)
	OSD_Backgroundcolor := 0x000000							; recommended: 0x000000	(Black)
}

; display the OSD. parameters arethe text and two boolean values for transparent background and small text
Display_OSD(OSD_Text, OSD_Transparent = false, OSD_Small = false)
{
	Global
	Gui, 33: Destroy										; close old OSD-Window if it exists
	Gui, 33: +LastFound +AlwaysOnTop -Caption +ToolWindow	; +ToolWindow avoids a taskbar button and an alt-tab menu item.	
	Gui, 33: Default										; make this GUI the default for following commands

	If %OSD_Small%											; if OSD-text should be small, set size and vertical position
	{
		OSD_Font_Size := OSD_Font_Size_2
		OSD_Position_Y_1 := OSD_Position_Y + 80
	}
	else													; if OSD-text should be big, set size and vertical position
	{
		OSD_Font_Size := OSD_Font_Size_1
		OSD_Position_Y_1 := OSD_Position_Y
	}

	Gui, Color, %OSD_Backgroundcolor%						; set background color
	Gui, Font, s%OSD_Font_Size% w1000						; Set a font size and boldness
	Gui, Add, Text, vMyOSDText c%OSD_Textcolor%, %OSD_Text%	; add text to GUI

	GuiControlGet, MyOSDText, Pos, MyOSDText				; check width of text
	if (MyOSDTextW > OSD_MaxWidth)							; if text is wider than the screen
	{
		GuiControl, Move, MyOSDText, w%OSD_MaxWidth% h200	; set maximum width
	}
	
	If %OSD_Transparent%									; if background should be transparent
	{
		OSD_Transparentcolor := 0x00FE00					; set background color to 0x00FE00, so borders look good with lime text
		Gui, Color, %OSD_Transparentcolor%
		WinSet, TransColor, %OSD_Transparentcolor%			; make background color transparent
	}

	; show OSD now (NoActivate avoids deactivating the currently active window)
	Gui, Show, Y%OSD_Position_Y_1% NoActivate AutoSize xCenter, OSD-Window
	SetTimer, Hide_OSD, %OSD_Displaytime%					; set timer to hide OSD
}

; if winamp is running, display artist and title of current song (from tray icon tooltip)
Winamp_OSD()
{ 
 	if WinExist("ahk_class Winamp v1.x")					; only if Winamp is running
	{
	    WinGetTitle, The_Title, ahk_class Winamp v1.x		; get title from tray icon
	    StringReplace, The_Title, The_Title, %A_Space%-%A_Space%Winamp,
	    Display_OSD(The_Title)								; display OSD
	}
}

; subroutine to destroy the GUI before exiting
Hide_OSD:
	SetTimer, Hide_OSD, off
	Gui, 33: Destroy
Return

;-------------------------------------------------------------------------
;	End of Text Based OSD by elmulti
;-------------------------------------------------------------------------