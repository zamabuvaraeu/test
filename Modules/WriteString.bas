#include once "WriteString.bi"

'                 0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
' 1375696       128   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0       ?...............
' 1375712       255 255 255 255 255 255 255 255 133 112  64   0   0   0   0   0       yyyyyyyy?p@.....
' 1375728         1   0   0   0   0   0   0   0  89 114  64   0   0   0   0   0       ........Yr@.....
' 1375744       208 253  20   0   0   0   0   0 208 253  20   0   0   0   0   0       ?y......?y......
' 1375760       128   0   0   0   0   0   0   0 128   0   0   0   0   0   0   0       ?.......?.......
' 1375776       112  19 141   0   0   0   0   0 232  19  64   0   0   0   0   0       p.?.....e.@.....
' 1375792         1   0   0   0   0   0   0   0 112  19 141   0   0   0   0   0       ........p.?.....
' 1375808         0 101  65   0   0   0   0   0   0   0   0   0   0   0   0   0       .eA.............

Sub PrintMemoryMap( _
		ByVal pMemory As Any Ptr, _
		ByVal Size As Integer, _
		ByVal TreatDataAsUnicode As Boolean _
	)
	
	Const NewLine = WStr(!"\r\n")
	Const TripleTabulation = WStr(!"\t\t\t")
	Const DoubleTabulation = WStr(!"\t\t")
	Const OneTabulation = WStr(!"\t")
	Const OneSpace = WStr(" ")
	Const Zero = WStr("0")
	Const Address = WStr("Address")
	Const AsciiData = WStr("ASCII Data")
	
	Dim pBytes As UByte Ptr = CPtr(UByte Ptr, pMemory)
	
	' Заголовок
	Scope
		Dim buffer As WString * 512 = Any
		' lstrcpyW(StrPtr(buffer), StrPtr(Address))
		' lstrcatW(StrPtr(buffer), StrPtr(DoubleTabulation))
		lstrcpyW(StrPtr(buffer), StrPtr(TripleTabulation))
		
		For i As Integer = 0 To 15
			Dim digit00 As WString * 16 = Any
			_itow(i, StrPtr(digit00), 16)
			lstrcatW(StrPtr(buffer), StrPtr(Zero))
			lstrcatW(StrPtr(buffer), StrPtr(digit00))
			lstrcatW(StrPtr(buffer), StrPtr(OneSpace))
		Next
		
		lstrcatW(StrPtr(buffer), StrPtr(OneTabulation))
		' lstrcatW(StrPtr(buffer), StrPtr(AsciiData))
		
		lstrcatW(StrPtr(buffer), StrPtr(NewLine))
		WriteStringW(StrPtr(buffer), lstrlenW(buffer))
	End Scope
	
	For j As Integer = 0 To Size - 1 Step 16
		
		' Указатель памяти
		Scope
			Dim wszMemoryPointer As WString * 512 = Any
			Dim uip As ULongInt = Cast(ULongInt, pMemory)
			_ui64tow(uip + j, StrPtr(wszMemoryPointer), 16)
			
			Dim buffer As WString * 512 = Any
			
			Dim Length As Integer = lstrlenW(wszMemoryPointer)
			If Length < 16 Then
				lstrcpyW(StrPtr(buffer), StrPtr(Zero))
				For i As Integer = 1 To 16 - Length - 1
					lstrcatW(StrPtr(buffer), StrPtr(Zero))
				Next
			Else
				buffer[0] = 0
			End If
			
			lstrcatW(StrPtr(buffer), StrPtr(wszMemoryPointer))
			lstrcatW(StrPtr(buffer), StrPtr(OneTabulation))
			
			WriteStringW(StrPtr(buffer), lstrlenW(buffer))
		End Scope
		
		' Байты памяти
		For i As Integer = j To j + 15
			Dim b00 As UByte = pBytes[i]
			
			Dim byte00 As WString * 16 = Any
			_itow(b00, StrPtr(byte00), 16)
			
			Dim buffer As WString * 512 = Any
			If b00 > &h0F Then
				lstrcpyW(StrPtr(buffer), StrPtr(byte00))
			Else
				lstrcpyW(StrPtr(buffer), StrPtr(Zero))
				lstrcatW(StrPtr(buffer), StrPtr(byte00))
			End If
			lstrcatW(StrPtr(buffer), StrPtr(OneSpace))
			
			WriteStringW(StrPtr(buffer), lstrlenW(buffer))
		Next
		
		WriteStringW(StrPtr(OneTabulation), Len(OneTabulation))
		
		' ASCII данные
		For i As Integer = j To j + 15
			Dim wszChar As WString * 2 = Any
			wszChar[1] = 0
			
			Dim b00 As UByte = pBytes[i]
			If b00 < 32 Then
				wszChar[0] = &h002E
			Else
				wszChar[0] = b00
			End If
			WriteStringW(StrPtr(wszChar), 1)
		Next
		
		WriteStringW(StrPtr(NewLine), Len(NewLine))
	Next
End Sub

Function WriteStringW Alias "WriteStringW"( _
		ByVal lpBuffer As WString Ptr, _
		ByVal Length As Integer _
	)As HRESULT
	
	Dim hOutput As Handle = GetStdHandle(STD_OUTPUT_HANDLE)
	
	Dim dwCharsWritten1 As DWORD = Any
	Dim res1 As Integer = WriteConsoleW( _
		hOutput, _
		lpBuffer, _
		Cast(DWORD, Length), _
		@dwCharsWritten1, _
		NULL _
	)
	If res1 = 0 Then
		
		Dim CodePage As UINT = GetConsoleOutputCP()
		
		Dim cbMultiByte As Integer = WideCharToMultiByte( _
			CodePage, _
			0, _
			lpBuffer, _
			Cast(DWORD, Length), _
			NULL, _
			0, _
			NULL, _
			NULL _
		)
		
		Dim lpMultiByteStr As ZString Ptr = HeapAlloc( _
			GetProcessHeap(), _
			HEAP_NO_SERIALIZE, _
			cbMultiByte _
		)
		If lpMultiByteStr = NULL Then
			Return E_OUTOFMEMORY
		End If
		
		WideCharToMultiByte( _
			CodePage, _
			0, _
			lpBuffer, _
			Cast(DWORD, Length), _
			lpMultiByteStr, _
			cbMultiByte, _
			NULL, _
			NULL _
		)
		
		Dim dwCharsWritten2 As DWORD = Any
		Dim res2 As Integer = WriteFile( _
			hOutput, _
			lpMultiByteStr, _
			Cast(DWORD, cbMultiByte), _
			@dwCharsWritten2, _
			0 _
		)
		Dim dwError As DWORD = GetLastError()
		
		HeapFree( _
			GetProcessHeap(), _
			HEAP_NO_SERIALIZE, _
			lpMultiByteStr _
		)
		
		If res2 = 0 Then
			Return HRESULT_FROM_WIN32(dwError)
		End If
		
	End If
	
	Return S_OK
	
End Function
