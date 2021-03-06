#include "ArrayListOfArrayListOfInteger.bi"
#include "windows.bi"

Constructor ArrayListOfArrayListOfInteger()
	Capacity = 64
	Length = 0
	ppVector = Allocate(CInt(Capacity) * SizeOf(ArrayListOfInteger Ptr))
End Constructor

Constructor ArrayListOfArrayListOfInteger(ByRef rhs As ArrayListOfArrayListOfInteger)
	this.Capacity = rhs.Capacity
	this.Length = rhs.Length
	this.ppVector = Allocate(CInt(rhs.Capacity) * SizeOf(Integer))
	memcpy(this.ppVector, rhs.ppVector, CInt(rhs.Length) * SizeOf(ArrayListOfInteger Ptr))
End Constructor

Constructor ArrayListOfArrayListOfInteger(ByVal Capacity As Long)
	this.Capacity = Capacity
	Length = 0
	ppVector = Allocate(CInt(Capacity) * SizeOf(ArrayListOfInteger Ptr))
End Constructor

Destructor ArrayListOfArrayListOfInteger()
	If ppVector <> 0 Then
		' For i As Integer = 0 To Length - 1
			' Delete ppVector[i]
		' Next
		Deallocate(ppVector)
	End If
End Destructor

Sub ArrayListOfArrayListOfInteger.Remove(Index As Long)
	If Length > 0 Then
		' Delete ppVector[CInt(Index)]
		Length -= 1
		If Index <> Length Then
			memmove(@ppVector[CInt(Index)], @ppVector[CInt(Index + 1)], CInt(Length - Index) * SizeOf(ArrayListOfInteger Ptr))
		End If
	End If
End Sub

' Function ArrayListOfArrayListOfInteger.Size()As Long
	' Return Length
' End Function

' Function ArrayListOfArrayListOfInteger.Get(ByVal Index As Long)As ArrayListOfInteger Ptr
	' Return ppVector[CInt(Index)]
' End Function

Operator ArrayListOfArrayListOfInteger.[](ByVal Index As Long)ByRef As ArrayListOfInteger Ptr
	Return ppVector[CInt(Index)]
End Operator

Operator ArrayListOfArrayListOfInteger.+=(ByVal Value As ArrayListOfInteger Ptr)
	If Length >= Capacity Then
		Dim ppOldVector As ArrayListOfInteger Ptr Ptr = ppVector
		Capacity += 64
		ppVector = Allocate(CInt(Capacity) * SizeOf(ArrayListOfInteger Ptr))
		memcpy(ppVector, ppOldVector, CInt(Length) * SizeOf(ArrayListOfInteger Ptr))
		' For i As Integer = 0 To Length - 1
			' Delete ppOldVector[i]
		' Next
		Deallocate(ppOldVector)
	End If
	ppVector[CInt(Length)] = Value
	Length += 1
End Operator

Operator Len(ByRef v As ArrayListOfArrayListOfInteger)As Long
	Return v.Length
End Operator
