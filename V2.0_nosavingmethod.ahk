; No Save Method Script converted from AHK V1 to AHK V2 by Thomas Wood
; Original AHK V1 script by: https://www.reddit.com/user/ElectroBytezLV/

; Enable Debugging:
;#Warn  ; Enable warnings to assist with detecting common errors.

Persistent ; Prevent the script from exiting automatically.
#SingleInstance
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetKeyDelay(0)
SetWinDelay(0)
SetControlDelay(0)
SetTitleMatchMode(2)
OnExit AppExit 

; ROCKSTAR SERVERS API IP
rockstarIP := "192.81.241.171" ; if the ip ever changes just update this variable to the new ip

; Admin Priv Check
if not A_IsAdmin
{	
	Run("*RunAs " A_ScriptFullPath) ; if not admin, relaunch script as admin
}

; Exit Hotkey
!+f4::
{
	ToolTip("EXITING", 0, 0)
	Sleep(5000)
    ToolTip(, 0, 0)
	ExitApp
}

; Block Firewall IN/OUT Communcation
^Numpad0::
{
	RunWait("netsh advfirewall firewall add rule name=`"BATCH GTA 5 BLOCK`" dir=out action=block", , "hide")
	RunWait("netsh advfirewall firewall add rule name=`"BATCH GTA 5 BLOCK`" dir=in action=block", , "hide")
	ToolTip("NETWORK BLOCK ON", 0, 0)
	Sleep(3000)
	ToolTip("NETWORK BLOCK ON", 0, 0)
	return
}

; Enable Firewall IN/OUT Communcation
^Numpad1::
{
	RunWait("netsh advfirewall firewall delete rule name=`"BATCH GTA 5 BLOCK`"", , "hide")
	ToolTip("NETWORK BLOCK OFF", 0, 0)
	Sleep(3000)
	ToolTip(, 0, 0)
	return
}

; Disable Saving
^f9::
{
	RunWait("netsh advfirewall firewall add rule name=`"123456`" dir=out action=block remoteip=" . rockstarIP, , "hide")
	ToolTip("NO SAVING MODE ON", 10, 10)
	Sleep(3000)
	ToolTip("NO SAVING MODE ON", 10, 10)
	return
}

; Enable Saving
^f12::
{
	RunWait("netsh advfirewall firewall delete rule name=`"123456`"", , "hide")
	ToolTip("NO SAVING MODE OFF", 10, 10)
	Sleep(3000)
	ToolTip(, 0, 0)
	return
}

; Hotkey Tips
^f8::
{
	ToolTip("Ctrl and F5 - block connection for the game`nCtrl and F6 - restore connection for the game`nCtrl and Num0 - Disable saving mode`nCtrl and Num1 - Enable/Restore saving mode`nCtrl and F8 - Display this help text", 0, 0)
    Sleep(5000)
    ToolTip(, 0, 0)
    return
}

; Exit Func Callback
AppExit(ExitReason, ExitCode)
{
	RunWait("netsh advfirewall firewall delete rule name=`"BATCH GTA 5 BLOCK`"", , "hide")
	RunWait("netsh advfirewall firewall delete rule name=`"123456`"", , "hide")
}