#ifndef ARRAYLISTOFINTEGER_BI
#define ARRAYLISTOFINTEGER_BI

Type ArrayListOfInteger
	pVector As Integer Ptr
	Length As Long
	Capacity As Long
	Declare Constructor()
	Declare Constructor(ByRef rhs As ArrayListOfInteger)
	Declare Constructor(ByVal Capacity As Long)
	Declare Destructor()
	Declare Sub Remove(ByVal Index As Long)
	' Declare Function Size()As Long
	' Declare Function Get(ByVal Index As Long)As Integer
	' Declare Sub Set(ByVal Index As Long, ByVal Value As Integer)
	Declare Operator Let(ByRef rhs As ArrayListOfInteger)
	Declare Operator [](ByVal Index As Long)ByRef As Integer
	Declare Operator +=(ByVal Value As Integer)
End Type

Declare Operator Len(ByRef v As ArrayListOfInteger)As Long

#endif
