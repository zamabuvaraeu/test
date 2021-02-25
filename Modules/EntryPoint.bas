#include "EntryPoint.bi"
#include "windows.bi"

Const ARRAY_LENGTH As LongInt = 20 * (1024 * 1024 * 1024)
Const SwapFile = __TEXT("Отображённый файл.bin")

Function CreateArray( _
		ByVal llSize As LongInt _
	)As UByte Ptr
	
	Dim hFile As HANDLE = CreateFile( _
		SwapFile, _
		GENERIC_READ Or GENERIC_WRITE, _
		FILE_SHARE_READ, _
		NULL, _
		CREATE_ALWAYS, _
		FILE_ATTRIBUTE_NORMAL, _
		NULL _
	)
	
	Dim liSwapSize As LARGE_INTEGER = Any
	liSwapSize.QuadPart = llSize
	SetFilePointerEx( _
		hFile, _
		liSwapSize, _
		NULL, _
		FILE_BEGIN _
	)
	
	SetEndOfFile(hFile)
	
	Dim hMap As HANDLE = CreateFileMapping( _
		hFile, _
		NULL, _
		PAGE_READWRITE, _
		0, _
		0, _
		NULL _
	)
	
	Dim pArray As UByte Ptr = MapViewOfFile( _
		hMap, _
		FILE_MAP_WRITE, _
		0, _
		0, _
		0 _
	)
	
	Return pArray
	
End Function

Function EntryPoint Alias "EntryPoint"()As Integer
	
	Dim pArray As UByte Ptr = CreateArray(ARRAY_LENGTH)
	If pArray = NULL Then
		Return 1
	End If
	
	Const ExclamationMarkChar = &h21
	Const LeftCurlyBracketChar = &h7B
	Const LineFeedChar = &h0A
	Const CarriageReturnChar = &h0D
	
	For i As LongInt = 0 To ARRAY_LENGTH - 1
		pArray[i] = (i Mod (LeftCurlyBracketChar - ExclamationMarkChar)) + ExclamationMarkChar
	Next
	
	Dim buf(6) As TCHAR = Any
	buf(0) = pArray[0]
	buf(1) = CarriageReturnChar
	buf(2) = LineFeedChar
	buf(3) = pArray[ARRAY_LENGTH - 1]
	buf(4) = CarriageReturnChar
	buf(5) = LineFeedChar
	buf(6) = 0
	
	Dim NumberOfCharsWritten As DWORD = Any
	WriteConsole( _
		GetStdHandle(STD_OUTPUT_HANDLE), _
		@buf(0), _
		6, _
		@NumberOfCharsWritten, _
		NULL _
	)
	
	Return 0
	
End Function
