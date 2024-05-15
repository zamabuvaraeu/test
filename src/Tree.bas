#include once "Tree.bi"

Public Function CreateNode()As Node Ptr
	
	Dim pNode As Node Ptr = Callocate(SizeOf(Node))
	
	Return pNode
	
End Function

Public Function TreeAdd( _
		ByVal pNode As Node Ptr, _
		ByVal Key As Integer, _
		ByVal Value As Integer, _
		ByVal Comparator As TreeCompareCallback, _
		ByVal Param As Any Ptr _
	)As Node Ptr
	
	If pNode = 0 Then
		Return 0
	End If
	
	If pNode->Pair.Repeats = 0 Then
		pNode->Pair.Repeats += 1
		pNode->Pair.Key = Key
		pNode->Pair.Value = Value
		Return pNode
	End If
	
	Dim resCompare As Integer = Comparator(Param, Key, pNode->Pair.Key)
	
	Select Case resCompare
		
		Case Is > 0
			If pNode->pRight = 0 Then
				pNode->pRight = CreateNode()
			End If
			
			If pNode->pRight Then
				Return TreeAdd(pNode->pRight, Key, Value, Comparator, Param)
			End If
			
			Return 0
			
		Case 0
			pNode->Pair.Repeats += 1
			
			Return pNode
			
		Case Is < 0
			If pNode->pLeft = 0 Then
				pNode->pLeft = CreateNode()
			End If
			
			If pNode->pLeft Then
				Return TreeAdd(pNode->pLeft, Key, Value, Comparator, Param)
			End If
			
			Return 0
			
	End Select
	
End Function

Public Sub TreeVisit( _
		ByVal pNode As Node Ptr, _
		ByVal pCallback As TreeVisitCallback, _
		ByVal Param As Any Ptr _
	)
	
	If pNode Then
		TreeVisit(pNode->pLeft, pCallback, Param)
		pCallback(Param, pNode->Pair.Key, pNode->Pair.Value, pNode->Pair.Repeats)
		TreeVisit(pNode->pRight, pCallback, Param)
	End If
	
End Sub

