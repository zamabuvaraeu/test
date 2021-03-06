#include "ArrayListOfInteger.bi"
#include "windows.bi"

Constructor ArrayListOfInteger()
	Capacity = 64
	Length = 0
	pVector = Allocate(CInt(Capacity) * SizeOf(Integer))
End Constructor

Constructor ArrayListOfInteger(ByRef rhs As ArrayListOfInteger)
	this.Capacity = rhs.Capacity
	this.Length = rhs.Length
	this.pVector = Allocate(CInt(rhs.Capacity) * SizeOf(Integer))
	memcpy(this.pVector, rhs.pVector, CInt(rhs.Length) * SizeOf(Integer))
End Constructor

Constructor ArrayListOfInteger(ByVal Capacity As Long)
	this.Capacity = Capacity
	Length = 0
	pVector = Allocate(CInt(Capacity) * SizeOf(Integer))
End Constructor

Destructor ArrayListOfInteger()
	If pVector <> 0 Then
		Deallocate(pVector)
	End If
End Destructor

Sub ArrayListOfInteger.Remove(Index As Long)
	If Length > 0 Then
		Length -= 1
		If Index <> Length Then
			memmove(@pVector[CInt(Index)], @pVector[CInt(Index + 1)], CInt(Length - Index) * SizeOf(Integer))
		End If
	End If
End Sub

' Function ArrayListOfInteger.Size()As Long
	' Return Length
' End Function

' Function ArrayListOfInteger.Get(Index As Long)As Integer
	' Return pVector[CInt(Index)]
' End Function

' Sub ArrayListOfInteger.Set(Index As Long, Value As Integer)
	' pVector[CInt(Index)] = Value
' End Sub

Operator ArrayListOfInteger.[](index As Long)ByRef As Integer
	Return pVector[CInt(Index)]
End Operator

Operator ArrayListOfInteger.+=(ByVal Value As Integer)
	If Length >= Capacity Then
		Dim pOldVector As Integer Ptr = pVector
		Capacity += 64
		pVector = Allocate(CInt(Capacity) * SizeOf(Integer))
		memcpy(pVector, pOldVector, CInt(Length) * SizeOf(Integer))
		Deallocate(pOldVector)
	End If
	pVector[CInt(Length)] = Value
	Length += 1
End Operator

Operator Len(ByRef v As ArrayListOfInteger)As Long
	Return v.Length
End Operator
