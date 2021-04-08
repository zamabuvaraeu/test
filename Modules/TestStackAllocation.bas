#include once "windows.bi"
#include once "win\ole2.bi"
#include once "crt.bi"
#include once "WriteString.bi"

Const NewLine = WStr(!"\r\n")

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

Type ValueBSTR
	AllocatedBytes As UINT
	NullChar As OLECHAR
	Declare Constructor()
	Declare Constructor(ByRef wsz As Const WString)
	Declare Constructor(ByRef wsz As Const WString, ByVal Length As UINT)
End Type

Constructor ValueBSTR()
	AllocatedBytes = 0
	NullChar = 0
End Constructor

Constructor ValueBSTR(ByRef wsz As Const WString)
	Dim Length As UINT = lstrlenW(wsz)
	AllocatedBytes = Length * SizeOf(OLECHAR)
	CopyMemory( _
		@NullChar, _
		StrPtr(wsz), _
		(Length + 1) * SizeOf(WString) _
	)
End Constructor

Constructor ValueBSTR(ByRef wsz As Const WString, ByVal Length As UINT)
	AllocatedBytes = Length * SizeOf(OLECHAR)
	CopyMemory( _
		@NullChar, _
		StrPtr(wsz), _
		(Length + 1) * SizeOf(WString) _
	)
End Constructor

Function GetCeiling16( _
		ByVal Value As Integer _
	)As Integer
	
	Return (Value \ 16) * 16 + 16
	
End Function

Function GetValueBSTRSize( _
		ByVal Length As Integer _
	)As Integer
	
	Dim size As Integer = SizeOf(UINT) + (Length) * SizeOf(OLECHAR) + SizeOf(OLECHAR)
	
	Return GetCeiling16(size)
	
End Function

Function GetWStringSize( _
		ByVal Length As Integer _
	)As Integer
	
	Dim size As Integer = (Length + 1) * SizeOf(WString)
	
	Return GetCeiling16(size)
	
End Function

Function DisplayBstr( _
		ByVal b As BSTR _
	)As HRESULT
	
	Dim bNewLine As BSTR = SysAllocString(StrPtr(NewLine))
	If bNewLine = NULL Then
		Return E_OUTOFMEMORY
	End If
	
	Dim bConcat As BSTR = Any
	Dim hr1 As HRESULT = VarBstrCat(b, bNewLine, @bConcat)
	If FAILED(hr1) Then
		SysFreeString(bNewLine)
		Return hr1
	End If
	SysFreeString(bNewLine)
	
	Dim hr2 As HRESULT = WriteStringW( _
		bConcat, _
		SysStringLen(bConcat) _
	)
	If FAILED(hr2) Then
		SysFreeString(bConcat)
		Return E_FAIL
	End If
	
	SysFreeString(bConcat)
	
	Return S_OK
	
End Function

Function TestStackAllocationW( _
		ByRef wsz As Const WString _
	)As Integer
	
	Dim Length As Integer = lstrlenW(wsz)
	
	Scope
		Dim ValueBSTRBytesCount As Integer = GetValueBSTRSize(Length)
		Dim pMemory1 As Any Ptr = Alloca(ValueBSTRBytesCount)
		
		Dim pStackBSTR As ValueBSTR Ptr = New(pMemory1) ValueBSTR(wsz)
		
		Dim b As BSTR = Cast(BSTR, @pStackBSTR->NullChar)
		
		Dim hr As HRESULT = DisplayBstr(b)
		If FAILED(hr) Then
			Return 1
		End If
	End Scope
	
	Scope
		Dim WStringBytesCount As Integer = GetWStringSize(Length)
		Dim pMemory2 As Any Ptr = Alloca(WStringBytesCount)
		
		Dim pwsz As WString Ptr = CPtr(WString Ptr, pMemory2)
		CopyMemory( _
			pwsz, _
			StrPtr(wsz), _
			(Length + 1) * SizeOf(WString) _
		)
		
		Dim hr2 As HRESULT = WriteStringW( _
			pwsz, _
			Length _
		)
		If FAILED(hr2) Then
			Return 2
		End If
		
		Dim hr3 As HRESULT = WriteStringW( _
			StrPtr(NewLine), _
			Len(NewLine) _
		)
		If FAILED(hr3) Then
			Return 2
		End If
	End Scope
	
	Return 0
	
End Function
