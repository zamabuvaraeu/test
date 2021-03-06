#include "GetCompositions.bi"

	/'
	Dim ByRef CompositionList As ArrayListOfArrayListOfInteger = *GetCompositions(4)
	
	For j As Long = 0 To Len(CompositionList) - 1
		
		Dim wszList As WString * (1 + 1) = Any
		wszList[0] = j + &h30
		wszList[1] = 0
		
		Dim ByRef Composition As ArrayListOfInteger = *CompositionList[j]
		
		For i As Long = 0 To Len(Composition) - 1
			Dim Value As Integer = Composition[i]
			Dim wszValue As WString * (1 + 1) = Any
			wszValue[0] = Value + &h30
			wszValue[1] = 0
			MessageBox(0, wszValue, wszList, MB_OK)
		Next
		
	Next
	
	MessageBox(0, "Удачно", "Список композиций", MB_OK)
	'/

Function GetComposition( _
		ByVal pPreviousComposition As ArrayListOfInteger Ptr, _
		ByVal n As Integer _
	)As ArrayListOfInteger Ptr
	
	Dim pCurrentComposition As ArrayListOfInteger Ptr = New ArrayListOfInteger(*pPreviousComposition)
	Dim ByRef CurrentComposition As ArrayListOfInteger = *pCurrentComposition
	
	For j As Long = Len(CurrentComposition) - 1 To 0 Step -1
		
		If CurrentComposition[j] <> 1 Then
			
			CurrentComposition[j] = CurrentComposition[j] - 1
			
			If Len(CurrentComposition) > j + 1 Then
				
				If Len(CurrentComposition) - (j + 1) > 1 Then
					
					Dim sumOfOnes As Integer = 0
					
					For i As Long = Len(CurrentComposition) - 1 To j + 1 Step -1
						sumOfOnes += CurrentComposition[i]
						If i <> j + 1 Then
							CurrentComposition.Remove(i)
						End If
					Next
					
					CurrentComposition[j + 1] = sumOfOnes + 1
					
				Else
					CurrentComposition[j + 1] = CurrentComposition[j + 1] + 1
					
				End If
				
			Else
				CurrentComposition += 1
				
			End If
			
			Return pCurrentComposition
			
		End If
		
	Next
	
	Return 0
	
End Function

Function GetCompositions( _
		ByVal n As Integer _
	)As ArrayListOfArrayListOfInteger Ptr
	
	Dim Capacity As Long = 1
	For i As Integer = 1 To n - 1
		Capacity *= 2
	Next
	
	Dim pCompositionList As ArrayListOfArrayListOfInteger Ptr = New ArrayListOfArrayListOfInteger(Capacity)
	
	If n > 0 Then
		Dim pComposition As ArrayListOfInteger Ptr = New ArrayListOfInteger()
		*pComposition += n
		
		Do While pComposition <> 0
			*pCompositionList += pComposition
			pComposition = GetComposition(pComposition, n)
		Loop
	End If
	
	Return pCompositionList
	
End Function
