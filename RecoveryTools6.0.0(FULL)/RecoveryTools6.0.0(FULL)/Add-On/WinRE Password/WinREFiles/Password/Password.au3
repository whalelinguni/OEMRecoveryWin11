#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=PasswordX86.exe
#AutoIt3Wrapper_Outfile_x64=PasswordAMD64.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Password prompt for Windows Recovery Environment
#AutoIt3Wrapper_Res_Fileversion=6.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Anarethos - https://www.anarethos.com
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Field=ProductName|WinRE Password
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;Check if current local is available. If not, revert to english by default
$CurrentLanguage = RegRead("hklm\system\currentcontrolset\control\nls\language","installlanguage")
$LanguageName = IniRead(@ScriptDir&"\Password.ini",$CurrentLanguage,"LanguageName","")
If $LanguageName = "" Then $CurrentLanguage = "0409"

;Reading text strings
$PasswordTitle = SplitString(IniRead(@ScriptDir&"\Password.ini",$CurrentLanguage,"PasswordTitle","MissingString"))
$PasswordText = SplitString(IniRead(@ScriptDir&"\Password.ini",$CurrentLanguage,"PasswordText","MissingString"))
$PasswordTitleError = SplitString(IniRead(@ScriptDir&"\Password.ini",$CurrentLanguage,"PasswordTitleError","MissingString"))
$PasswordTextError = SplitString(IniRead(@ScriptDir&"\Password.ini",$CurrentLanguage,"PasswordTextError","MissingString"))

;Reading password settings
$Password = SplitString(IniRead(@ScriptDir&"\Password.ini","Common","Password","12345678"))
$Run =  SplitString(IniRead(@ScriptDir&"\Password.ini","Common","Run","X:\sources\recovery\recenv.exe"))

While 1
    $InputPassword=InputBox($PasswordTitle,$PasswordText,"","*")
    If ($InputPassword==$Password) Then
        ExitLoop
    ElseIf @error = 1 then
        Exit
    EndIf
    MsgBox(262160,$PasswordTitleError,$PasswordTextError)
WEnd

RunWait($Run)

;Function to split strings of text
func SplitString($Input)
	Return StringReplace($Input,";",@CRLF)
endFunc