$StartTime = TimerInit()
While 1
	If TimerDiff($StartTime) >= 28800000 Then Exit
	$Original = MouseGetPos()
	Sleep (5000)
	$Current = MouseGetPos()
	IF $Original[0] = $Current[0] AND $Original[1] = $Current[1] Then
		MouseMove(5,5,0)
		MouseMove($Current[0],$Current[1],0)
	EndIf
WEnd