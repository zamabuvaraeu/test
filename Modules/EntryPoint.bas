#include once "windows.bi"
#include once "TestStackAllocation.bi"

Const HelloWorld = WStr("Hello World!")
Const Caption = WStr(!"Test Alloca function successful\r\n")

#ifdef WITHOUT_RUNTIME
Function EntryPoint()As Integer
#else
Function main Alias "main"()As Long
#endif
	
	Dim RetValue As Integer = Any
	
	Dim RetCode As Integer = TestStackAllocationW(HelloWorld)
	
	If RetCode = 0 Then
		RetValue = 2
	Else
		RetValue = 3
	End If
	
	Dim NumberOfCharsWritten As DWORD = Any
	Dim res2 As WINBOOL = WriteConsoleW( _
		GetStdHandle(STD_OUTPUT_HANDLE), _
		StrPtr(Caption), _
		Cast(DWORD, Len(Caption)), _
		VarPtr(NumberOfCharsWritten), _
		NULL _
	)
	If res2 = 0 Then
		Return 4
	End If
	
	Return RetValue
	
#ifdef WITHOUT_RUNTIME
End Function
#else
End Function
#endif
