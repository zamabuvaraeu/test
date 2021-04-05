#include once "windows.bi"
#include once "win\ole2.bi"
#include once "crt.bi"

Const NewLine = WStr(!"\r\n")

Type ValueBSTR
	Length As UINT
	Data As OLECHAR
End Type

Sub ValueBSTRInitialize( _
		ByVal this As ValueBSTR Ptr, _
		ByVal Length As UINT, _
		ByVal p As OLECHAR Ptr _
	)
	
	this->Length = Length * SizeOf(OLECHAR)
	CopyMemory( _
		@this->Data, _
		p, _
		(Length + 1) * SizeOf(OLECHAR) _
	)
	
End Sub

Function GetValueBSTRSize( _
		ByVal Length As Integer _
	)As Integer
	
	Return SizeOf(UINT) + (Length + 1) * SizeOf(OLECHAR) + SizeOf(OLECHAR)
	
End Function

#ifdef __FB_64BIT__
Declare Function _alloca cdecl Alias "__alloca"( _
   ByVal size As SIZE_T _
)As Any Ptr
#else
Declare Function _alloca cdecl Alias "_alloca"( _
   ByVal size As SIZE_T _
)As Any Ptr
#endif

#define Alloca(size) _alloca(size)
' #define Alloca(size) Allocate(size)

Function DisplayBstr( _
		ByVal b As BSTR _
	)As HRESULT
	
	Dim bNewLine As BSTR = SysAllocString(StrPtr(NewLine))
	If bNewLine = NULL Then
		Return E_OUTOFMEMORY
	End If
	
	Dim bConcat As BSTR = Any
	Dim hr As HRESULT = VarBstrCat(b, bNewLine, @bConcat)
	If FAILED(hr) Then
		SysFreeString(bNewLine)
		Return hr
	End If
	SysFreeString(bNewLine)
	
	Dim NumberOfCharsWritten As DWORD = Any
	Dim res As WINBOOL = WriteConsoleW( _
		GetStdHandle(STD_OUTPUT_HANDLE), _
		bConcat, _
		Cast(DWORD, SysStringLen(bConcat)), _
		VarPtr(NumberOfCharsWritten), _
		NULL _
	)
	If res = 0 Then
		SysFreeString(bConcat)
		Return E_FAIL
	End If
	' MessageBoxW(NULL, b, b, MB_OK)
	
	SysFreeString(bConcat)
	
	Return S_OK
	
End Function

Function TestStackAllocationW( _
		ByRef wsz As Const WString _
	)As Integer
	
	Dim Length As Integer = lstrlenW(wsz)
	Dim BytesCount As Integer = GetValueBSTRSize(Length)
	
	Dim pStackBSTR As ValueBSTR Ptr = Alloca(BytesCount)
	ValueBSTRInitialize( _
		pStackBSTR, _
		Cast(UINT, Length), _
		StrPtr(wsz) _
	)
	Dim b As BSTR = Cast(BSTR, @pStackBSTR->Data)
	
	Dim hr As HRESULT = DisplayBstr(b)
	If FAILED(hr) Then
		Return 1
	End If
	
	Return 0
	
End Function
