#ifndef ARRAYLISTOFARRAYLISTOFINTEGER_BI
#define ARRAYLISTOFARRAYLISTOFINTEGER_BI

#include "ArrayListOfInteger.bi"

Type ArrayListOfArrayListOfInteger
	ppVector As ArrayListOfInteger Ptr Ptr
	Length As Long
	Capacity As Long
	Declare Constructor()
	Declare Constructor(ByRef rhs As ArrayListOfArrayListOfInteger)
	Declare Constructor(ByVal Capacity As Long)
	Declare Destructor()
	Declare Sub Remove(ByVal Index As Long)
	' Declare Function Size()As Long
	' Declare Function Get(ByVal Index As Long)As ArrayListOfInteger Ptr
	' Declare Sub Set(ByVal Index As Long, ByVal Value As ArrayListOfInteger Ptr)
	Declare Operator Let(ByRef rhs As ArrayListOfArrayListOfInteger)
	Declare Operator [](ByVal Index As Long)ByRef As ArrayListOfInteger Ptr
	Declare Operator +=(ByVal Value As ArrayListOfInteger Ptr)
End Type

Declare Operator Len(ByRef v As ArrayListOfArrayListOfInteger)As Long

#endif
