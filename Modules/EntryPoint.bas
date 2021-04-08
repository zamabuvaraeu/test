#include once "windows.bi"
#include once "TestStackAllocation.bi"
#include once "WriteString.bi"

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
	
	Dim hr As HRESULT = WriteStringW( _
		StrPtr(Caption), _
		Len(Caption) _
	)
	If FAILED(hr) Then
		Return 4
	End If
	
	Return RetValue
	
#ifdef WITHOUT_RUNTIME
End Function
#else
End Function
#endif
