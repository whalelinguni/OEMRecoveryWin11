#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=appicon.ico
#AutoIt3Wrapper_Outfile=RecoveryUSBX86.exe
#AutoIt3Wrapper_Outfile_x64=RecoveryUSBAMD64.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Recovery tools for USB media
#AutoIt3Wrapper_Res_Fileversion=6.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Anarethos - https://www.anarethos.com
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Field=ProductName|Recovery tools
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

$Version = IniRead(@ScriptDir&"\Settings.ini","General","Version","0.0.0")
$Debug = IniRead(@ScriptDir&"\Settings.ini","General","Debug","0")
If $Debug = 1 Then
	$Show = @SW_SHOW
Else
	$Show = @SW_HIDE
EndIf


$LanguageList = IniRead(@ScriptDir&"\Settings.ini","General","LanguageList","0409")
$LanguageList = StringSplit($LanguageList,";")
$LanguageSelectorData = ""
for $i = 1 to $LanguageList[0]
	$LanguageList[$i] = IniRead(@ScriptDir&"\Settings.ini",$LanguageList[$i],"LanguageName","Missing") & " [" & StringUpper($LanguageList[$i]) & "]"
	$LanguageSelectorData = $LanguageSelectorData & $LanguageList[$i] & "|"
Next

$LanguageMenu = GuiCreate("Recovery Tools",250,75)
$LanguageSelector = GUICtrlCreateCombo("Select language",10,10,230)
$OkButton = GuiCtrlCreateButton("OK",100,40,50)
GUICtrlSetData($LanguageSelector,$LanguageSelectorData)

GuiSetState()

While 1
        $msg = GUIGetMsg()
        If $msg = $GUI_EVENT_CLOSE Then Exit

		If $msg = $OKButton Then
			$Language = GuiCtrlRead($LanguageSelector)
			If StringInStr($Language,"[") Then
					$Language = StringRight($Language,5)
					$Language = StringLeft($Language,4)
					ExitLoop
			EndIf
		EndIf
WEnd
GuiDelete($LanguageMenu)
$CurrentLanguage = $Language

;Load language strings
$TextRecoveryGroup = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryGroup","MissingString"))

$TextRecoveryOption10 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption10","MissingString"))
$TextRecoveryOption10Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption10Help","MissingString"))
$TextRecoveryOption10Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption10Title","MissingString"))
$TextRecoveryOption10Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption10Question","MissingString"))

$TextRecoveryOption11 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption11","MissingString"))
$TextRecoveryOption11Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption11Help","MissingString"))
$TextRecoveryOption11Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption11Title","MissingString"))
$TextRecoveryOption11Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryOption11Question","MissingString"))

$TextRecoveryLine1 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryLine1","MissingString"))
$TextRecoveryLine2 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryLine2","MissingString"))
$TextRecoveryLine3 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryLine3","MissingString"))
$TextRecoveryLine4 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryLine4","MissingString"))

$TextRecoveryStep1 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryStep1","MissingString"))
$TextRecoveryStep2 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryStep2","MissingString"))
$TextRecoveryStep3 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryStep3","MissingString"))
$TextRecoveryError = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryError","MissingString"))
$TextRecoveryWaiting = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryWaiting","MissingString"))
$TextRecoveryDoneTitle = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryDoneTitle","MissingString"))
$TextRecoveryDone = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextRecoveryDone","MissingString"))


;Menu declaration
$MainMenu = GuiCreate("Recovery Tools - Version "&$Version,590,150)

$RecoveryGroup = GUICtrlCreateGroup($TextRecoveryGroup,10,10,570,120)

$RecoveryOption10Button = GUICtrlCreateButton("",20,30,40,40,$BS_BITMAP)
$RecoveryOption10 = GUICtrlCreateLabel($TextRecoveryOption10,80,45,400)
$RecoveryOption10Help = $TextRecoveryOption10Help

$RecoveryOption11Button = GUICtrlCreateButton("",20,80,40,40,$BS_BITMAP)
$RecoveryOption11 = GUICtrlCreateLabel($TextRecoveryOption11,80,95,400)
$RecoveryOption11Help = $TextRecoveryOption11Help


;Show menu
$current = -1
$BGcolor = IniRead(@ScriptDir&"\Settings.ini","General","BgColor","0xa349a4")
$FontSize = IniRead(@ScriptDir&"\Settings.ini","General","FontSize","8.5")
$FontSizeGroup = IniRead(@ScriptDir&"\Settings.ini","General","FontSizeGroup","8.5")
$FontColor = IniRead(@ScriptDir&"\Settings.ini","General","FontColor","0x000000")
$ImageRecovery1 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","ImageRecovery1","1.bmp")
$ImageRecovery2 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","ImageRecovery2","2.bmp")
GUISetBkColor($BgColor)
GUICtrlSetFont($RecoveryGroup,$FontSizeGroup)
GUICtrlSetFont($RecoveryOption10,$FontSize)
GUICtrlSetImage($RecoveryOption10Button,$ImageRecovery1)
GUICtrlSetColor($RecoveryOption10,$FontColor)
GUICtrlSetFont($RecoveryOption11,$FontSize)
GUICtrlSetImage($RecoveryOption11Button,$ImageRecovery2)
GUICtrlSetColor($RecoveryOption11,$FontColor)
GUISetIcon(@ScriptDir&"\appicon.ico")
GUISetState()

While 1
	$mouse = GUIGetCursorInfo()
	If @error<>1 Then
		If $mouse[4] = $RecoveryOption10Button AND $current<>$RecoveryOption10Button Then
			ToolTip("")
			ToolTip($RecoveryOption10Help)
			$current = $RecoveryOption10Button
		EndIf

		If $mouse[4] = $RecoveryOption11Button AND $current<>$RecoveryOption11Button Then
			ToolTip("")
			ToolTip($RecoveryOption11Help)
			$current = $RecoveryOption11Button
		EndIf

		If $mouse[4] = 0 Then
			ToolTip("")
			$current = -1
		EndIf
	Else
		ToolTip("")
	EndIf

	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then Exit


	If $msg = $RecoveryOption10Button Then

		GUISetState(@SW_HIDE,$MainMenu)
		ToolTip("")
		$RecoveryMenu = GUICreate("Recovery Tools",590,230)
		$RecoveryGroup = GUICtrlCreateGroup($TextRecoveryGroup,10,10,570,210)
		$RecoveryLine1 = GUICtrlCreateLabel($TextRecoveryLine1,20,30,550,-1,$SS_CENTER)
		$RecoveryLine2 = GUICtrlCreateLabel($TextRecoveryLine2,20,60,550,-1,$SS_CENTER)
		$RecoveryLine3 = GUICtrlCreateLabel($TextRecoveryLine3,20,90,550,-1,$SS_CENTER)
		$RecoveryLine4 = GUICtrlCreateLabel($TextRecoveryLine4,20,120,550,-1,$SS_CENTER)
		$Button = GUICtrlCreatebutton("OK",265,180,60)
		GUICtrlSetColor($RecoveryLine1,$FontColor)
		GUICtrlSetColor($RecoveryLine2,$FontColor)
		GUICtrlSetColor($RecoveryLine3,$FontColor)
		GUICtrlSetColor($RecoveryLine4,$FontColor)
		GUICtrlSetFont($RecoveryLine1,$FontSize)
		GUICtrlSetFont($RecoveryLine2,$FontSize)
		GUICtrlSetFont($RecoveryLine3,$FontSize)
		GUICtrlSetFont($RecoveryLine4,$FontSize)
		GUICtrlSetFont($RecoveryGroup,$FontSizeGroup)
		GUISetBkColor($BgColor,$RecoveryMenu)
		$DriveCombo = GUICtrlCreateCombo("", 95, 150,400)

		;WMI Object for Query
		$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")

		;WMI Query for Drive number, Make/Model and Size
		$WMIQuery = $objWMIService.ExecQuery("SELECT * FROM Win32_DiskDrive")
		$WMIQuerySize = 0
		For $obj in $WMIQuery
			$WMIQuerySize = $WMIQuerySize + 1
		Next

		;Array containing all informations
		;$DriveArray[DriveID][0] = Name
		;$DriveArray[DriveID][1] = Size
		;$DriveArray[DriveID][2] = Caption text for drive selector
		Local $DriveArray[$WMIQuerySize][3]
		For $i=0 to UBound($DriveArray)-1
			$DriveArray[$i][0] = "NotSet"
			$DriveArray[$i][1] = -1
			$DriveArray[$i][2] = "NotSet"
		Next

		;Get Drive number, model, size
		For $obj In $WMIQuery
			$DriveNumber = StringTrimLeft($Obj.DeviceID,17)
			$Model = $Obj.Model
			$Size = Round($Obj.Size/1024/1024/1024,2)
			$DriveArray[$DriveNumber][0] = $Model
			$DriveArray[$DriveNumber][1] = $Size
		Next

		;Creating caption for drive selector
		For $i=0 to UBound($DriveArray)-1
			$Str = "Drive #" & $i
			$Str = $Str & " - "
			$Str = $Str & $DriveArray[$i][0]
			$Str = $Str & " - "
			$Str = $Str & $DriveArray[$i][1] & " GB"
			$DriveArray[$i][2] = $Str
		Next


		$DriveListCombo=""
		For $i=0 to UBound($DriveArray)-1
			$Str= "Drive Number: " & $i & @CRLF
			$Str = $Str & "Drive Name: " & $DriveArray[$i][0] & @CRLF
			$Str = $Str & "Total Size: " & $DriveArray[$i][1] & @CRLF
			$Str = $Str & "Caption: " & $DriveArray[$i][2]
			$DriveListCombo=$DriveListCombo & $DriveArray[$i][2] & "|"
		Next

		GuiCtrlSetData($DriveCombo,$DriveListCombo,"")
		GUISetState(@SW_SHOW,$RecoveryMenu)

		While 1
			$msgUsb = GUIGetMsg()
			If $msgUsb = $GUI_EVENT_CLOSE Then
				GuiDelete($RecoveryMenu)
				GuiSetState(@SW_Show,$MainMenu)
				ExitLoop
			EndIf

			If $msgUsb = $Button Then
				GUISetState(@SW_HIDE,$RecoveryMenu)
				$Destination = -1
				$Choice = GuiCtrlRead($DriveCombo)
				If $Choice = "" Then
					GuiDelete($RecoveryMenu)
					GuiSetState(@SW_Show,$MainMenu)
					ExitLoop
				EndIF
				For $i=0 to UBound($DriveArray)-1
					If $DriveArray[$i][2] == $Choice Then
						$Destination = $i
					EndIf
				Next

				$Result=0
				$Ans = MsgBox(4+32+256+4096,$TextRecoveryOption10Title,$TextRecoveryOption10Question&@CRLF&$Choice)
				If $Ans = 6 Then
					Tooltip("")
					GUISetState(@SW_HIDE)

					ProgressOn("Recovery Tools",$TextRecoveryWaiting,$TextRecoveryStep1,-1,-1,2+16)
					$result = RunWait("X:\Recovery\Recovery01Prepare.cmd" & " " & $Destination,@ScriptDir,$Show)
					If $Result<>0 Then
							MsgBox(4096+16,"",$TextRecoveryError)
							ProgressOff()
							GuiSetState(@SW_Show)
							ExitLoop
					EndIF


					ProgressSet(33,$TextRecoveryStep2)
					$result = RunWait("X:\Recovery\Recovery02Copy.cmd",@ScriptDir,$Show)
					If $Result<>0 Then
							MsgBox(4096+16,"",$TextRecoveryError)
							ProgressOff()
							GuiSetState(@SW_Show)
							ExitLoop
					EndIF

					ProgressSet(66,$TextRecoveryStep3)
					$result = RunWait("X:\Recovery\Recovery03Install.cmd",@ScriptDir,$Show)
					If $Result<>0 Then
							MsgBox(4096+16,"",$TextRecoveryError)
							ProgressOff()
							GuiSetState(@SW_Show)
							ExitLoop
					EndIF

					ProgressSet(100,"")
					ProgressOff()

					MsgBox(0+64,$TextRecoveryDoneTitle,$TextRecoveryDone)
					Exit
				EndIf
				GUISetState(@SW_SHOW,$MainMenu)
				ExitLoop
			EndIf
		WEnd
	EndIf

	If $msg = $RecoveryOption11Button Then
		$Ans = MsgBox(4+32+256+4096,$TextRecoveryOption11Title,$TextRecoveryOption11Question)
		If $Ans = 6 Then
			Tooltip("")
			GUISetState(@SW_HIDE)
			RunWait("X:\sources\recovery\recenv.exe","X:\sources\Recovery",$Show)
			GUISetState(@SW_SHOW)
		EndIf
	EndIf

Wend

func SplitString($Input)
	Return StringReplace($Input,";",@CRLF)
endFunc