#include once "windows.bi"
#include once "TestStackAllocation.bi"

Const HelloWorld = WStr("Hello World!")

Function EntryPoint()As Integer
	
	Dim RetValue As Integer = Any
	
	Dim RetCode As Integer = TestStackAllocationW(HelloWorld)
	
	If RetCode = 0 Then
		RetValue = 2
	Else
		RetValue = 3
	End If
	
	Return RetValue
	
End Function
