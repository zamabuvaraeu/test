#include "EntryPoint.bi"
#include "windows.bi"

Function EntryPoint Alias "EntryPoint"()As Integer
	
	Dim Value As Long = 0
	InterlockedIncrement(@Value)
	
	ExitProcess(Value)
	
	Return Value
	
End Function
