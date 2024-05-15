Type VectorItem
	Value As Integer
End Type

Type MapFunction As Function(ByVal context As Any Ptr, ByVal pItem As VectorItem Ptr) As Integer

Function IterateVector( _
		ByVal pBegin As VectorItem Ptr, _
		ByVal pEnd As VectorItem Ptr, _
		ByVal pUserFunc As MapFunction, _
		ByVal Context As Any Ptr _
	)As Integer
	
	Dim pPointer As VectorItem Ptr = pBegin
	Do While pPointer <> pEnd
		' code
		pUserFunc(Context, pPointer)
		
		pPointer += 1
	Loop
	
	Return 0
	
End Function

Function MpFunc(ByVal context As Any Ptr, ByVal pItem As VectorItem Ptr) As Integer
	
	Print pItem->Value
	
	Return 0
	
End Function

Dim Length As Integer = 25
Dim Vector As VectorItem Ptr = Allocate(Length * SizeOf(VectorItem))

IterateVector(@Vector[0], @Vector[Length], @MpFunc, 0)
