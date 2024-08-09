#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Menux86.exe
#AutoIt3Wrapper_Outfile_x64=MenuAmd64.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=File browser, Full recovery, etc.
#AutoIt3Wrapper_Res_Fileversion=6.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Anarethos - https://www.anarethos.com
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Field=ProductName|Advanced options
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

;==========================================================================
;==========================================================================
;==========================================================================
;The settings file must be names QStart.INI
;[Settings]
;NbButton = 2
;Title=Menu Title
;
;[1]
;Text=Caption1
;Command=X:\Toto\Toto.exe
;WorkDit=X:\Toto
;Params=/qb
;
;[2]
;Text=Caption2
;Command=X:\Toto1\Toto1.exe
;WorkDit=X:\Toto1
;Params=/qb /qn
;
;==========================================================================
;==========================================================================
;==========================================================================


;==========================================================================
;Checking if qstart.ini exist
;==========================================================================
If NOT FileExists(@ScriptDir&"\qstart.ini") Then
       MsgBox(4096,"Missing File", "qstart.INI can not be found!")
	   Exit
EndIf

;==========================================================================
;Creating an array with all buttons from INI file.
;==========================================================================
$NbButton = IniRead(@ScriptDir&"\qstart.ini","settings","nbbutton",-1)
If $NbButton = -1 Then Exit

$Title = IniRead(@ScriptDir&"\qstart.ini","settings","title","Main Menu")

$Main = GUICreate($Title,220,($NbButton*60)+10)
Dim $Menu[$NbButton][5]
For $i = 0 to $NbButton-1
	$Menu[$i][0] = IniRead(@ScriptDir&"\qstart.ini",$i+1,"text","")
	$Menu[$i][1] = IniRead(@ScriptDir&"\qstart.ini",$i+1,"command","")
	$Menu[$i][2] = IniRead(@ScriptDir&"\qstart.ini",$i+1,"params","")
	$Menu[$i][3] = IniRead(@ScriptDir&"\qstart.ini",$i+1,"WorkDir","")
	$Menu[$i][4] = GUICtrlCreateButton($Menu[$i][0],10,($i*60)+10,200,50)
Next

;==========================================================================
;Display the GUI and listening to command.
;==========================================================================
GUISetIcon(@ScriptDir&"\appicon.ico")
GUISetState(@SW_SHOW)
While 1
	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then
		Exit
	EndIF

	For $i = 0 to $NbButton-1
		If $msg = $Menu[$i][4] Then
			ShellExecute($Menu[$i][1],$Menu[$i][2],$Menu[$i][3])
			Exit
		EndIf
	Next
WEnd
