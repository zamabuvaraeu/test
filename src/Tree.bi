#ifndef TREE_BI
#define TREE_BI

Type KeyValuePair
	Key As Integer
	Value As Integer
	Repeats As Integer
End Type

Type Node
	pLeft As Node Ptr
	pRight As Node Ptr
	Pair As KeyValuePair
End Type

Type TreeVisitCallback As Sub(ByVal Param As Any Ptr, ByVal Key As Integer, ByVal Value As Integer, ByVal Repeats As Integer)
Type TreeCompareCallback As Function(ByVal Param As Any Ptr, ByVal LeftKey As Integer, ByVal RightKey As Integer)As Integer

Declare Function CreateNode()As Node Ptr

Declare Function TreeAdd( _
	ByVal pNode As Node Ptr, _
	ByVal Key As Integer, _
	ByVal Value As Integer, _
	ByVal Comparator As TreeCompareCallback, _
	ByVal Param As Any Ptr _
)As Node Ptr

Declare Sub TreeVisit( _
	ByVal pNode As Node Ptr, _
	ByVal pCallback As TreeVisitCallback, _
	ByVal Param As Any Ptr _
)

#endif
