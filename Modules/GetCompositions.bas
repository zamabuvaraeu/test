#include "GetCompositions.bi"

Function GetComposition( _
		ByVal pPreviousComposition As ArrayListOfInteger Ptr, _
		ByVal n As Integer _
	)As ArrayListOfInteger Ptr
	
	Dim pCurrentComposition As ArrayListOfInteger Ptr = New ArrayListOfInteger(*pPreviousComposition)
	
	For j As Long = pCurrentComposition->Size() - 1 To 0 Step -1
		
		If pCurrentComposition->Get(j) <> 1 Then
			
			pCurrentComposition->Set(j, pCurrentComposition->Get(j) - 1)
			
			If pCurrentComposition->Size() > j + 1 Then
				
				If pCurrentComposition->Size() - (j + 1) > 1 Then
					
					Dim sumOfOnes As Integer = 0
					
					For i As Long = pCurrentComposition->Size() - 1 To j + 1 Step -1
						sumOfOnes += pCurrentComposition->Get(i)
						If i <> j + 1 Then
							pCurrentComposition->remove(i)
						End If
					Next
					
					pCurrentComposition->Set(j + 1, sumOfOnes + 1)
					
				Else
					pCurrentComposition->Set(j + 1, pCurrentComposition->Get(j + 1) + 1)
					
				End If
				
			Else
				pCurrentComposition->Add(1)
				
			End If
			
			Return pCurrentComposition
			
		End If
		
	Next
	
	Return 0
	
End Function

Function GetCompositions( _
		ByVal n As Integer _
	)As ArrayListOfArrayListOfInteger Ptr
	
	Dim Gree As Long = 1
	For i As Integer = 1 To n - 1
		Gree *= 2
	Next
	
	Dim pListOfCompositions As ArrayListOfArrayListOfInteger Ptr = New ArrayListOfArrayListOfInteger(Gree)
	
	If n > 0 Then
		Dim pComposition As ArrayListOfInteger Ptr = New ArrayListOfInteger()
		pComposition->Add(n)
		
		Do While pComposition <> 0
			pListOfCompositions->Add(pComposition)
			pComposition = GetComposition(pComposition, n)
		Loop
	End If
	
	Return pListOfCompositions
	
End Function
