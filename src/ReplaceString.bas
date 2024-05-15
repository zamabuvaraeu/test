#include once "crt.bi"

Redim Shared pszDimPosReplaces(1000) As Zstring Ptr

Function misc_replace_string_proc(sString As Zstring , sSearchStr As Zstring, sReplaceStr As Zstring, iPosition As Integer = 1 , iSearchParam As Integer = 0 ) As String Export

	Dim As Integer iIndexDim , iNextPos = iPosition-1

	Dim As Zstring Ptr pszOldStr = Strptr(sString)

	Dim As Integer iLenSearch = Len(sSearchStr)

	Dim As Integer iLenOldStr = Len(sString)

	If pszOldStr = 0 Orelse iLenOldStr = 0 Orelse iLenSearch = 0 Then

		Return sString

	Endif

	Do

		Dim As Zstring Ptr p = strstr(pszOldStr+iNextPos , Strptr(sSearchStr))

		If p Then

			If iIndexDim > Ubound(pszDimPosReplaces) Then

				Redim Preserve pszDimPosReplaces(Ubound(pszDimPosReplaces)+1000) As Zstring Ptr

			Endif

			pszDimPosReplaces(iIndexDim) = p

			iNextPos = (p-pszOldStr)+iLenSearch

			iIndexDim+=1

			If iSearchParam = 0 Then

				Exit Do

			Endif

		Else

			Exit Do

		Endif

	Loop

	If iIndexDim Then

		Dim As Integer iLenReplace , iLenDiff , iLenNew

		iLenReplace = Len(sReplaceStr)

		iLenDiff = iLenReplace-iLenSearch

		If iLenDiff > 0 Then

			iLenNew = iLenOldStr + (iLenDiff*iIndexDim)

		Else

			iLenNew = iLenOldStr

		Endif

		Dim As Zstring Ptr pszNew = Allocate(iLenNew+1)

		If pszNew = 0 Then

			Return sString

		Endif

		pszNew[iLenNew] = 0

		Dim As Zstring Ptr pszNewNext = pszNew

		For i As Long = 0 To iIndexDim-1

			Dim As Long iLenght = pszDimPosReplaces(i) - pszOldStr

			memcpy(pszNewNext , pszOldStr , iLenght)

			pszNewNext+=iLenght

			memcpy(pszNewNext , Strptr(sReplaceStr) , iLenReplace)

			pszNewNext+=iLenReplace

			pszOldStr = (pszDimPosReplaces(i)+iLenSearch)

		Next

		strcpy(pszNewNext , pszOldStr)

		Dim As String sRet = *pszNew

		Deallocate(pszNew)

		Return sRet

	Else

		Return sString

	Endif

End Function

Enum ReplacementOptions
	ReplaceOnce
	ReplaceAll
End Enum

Const MATCH_CAPACITY = 100

Type Match
	psLeft As ZString Ptr
	Length As Integer
End Type

Private Function CalculateMatches( _
		ByVal pszFrom As ZString Ptr, _
		ByVal FromLength As Integer, _
		ByVal pszOldValue As ZString Ptr, _
		ByVal OldValueLength As Integer, _
		ByVal ReplaceCount As ReplacementOptions, _
		ByVal ppMatchVector As Match Ptr Ptr _
	) As Integer

	Dim NewCapacity As UInteger = MATCH_CAPACITY
	Dim MatchLength As Integer = 0

	Dim pMatchVector As Match Ptr = Allocate(NewCapacity * SizeOf(Match))
	If pMatchVector = 0 Then
		*ppMatchVector = 0
		Return 0
	End If

	Dim psLeft As ZString Ptr = pszFrom

	Scope
		Dim pszFinded As ZString Ptr = strstr(psLeft, pszOldValue)
		Do While pszFinded
			If MatchLength >= NewCapacity Then
				NewCapacity *= 2
				Dim pMem As Match Ptr = Reallocate(pMatchVector, NewCapacity * SizeOf(Match))
				If pMem = 0 Then
					Deallocate(pMatchVector)
					*ppMatchVector = 0
					Return 0
				End If
				pMatchVector = pMem
			End If

			Dim LeftLength As Integer = pszFinded - psLeft
			pMatchVector[MatchLength].psLeft = psLeft
			pMatchVector[MatchLength].Length = LeftLength

			MatchLength += 1

			If ReplaceCount = ReplacementOptions.ReplaceOnce Then
				If MatchLength Then
					psLeft = @pszFinded[OldValueLength]
					Exit Do
				End If
			End If

			psLeft = @pszFinded[OldValueLength]
			pszFinded = strstr(psLeft, pszOldValue)
		Loop
	End Scope

	Scope
		' Fill tail

		If MatchLength >= NewCapacity Then
			NewCapacity *= 2
			Dim pMem As Match Ptr = Reallocate(pMatchVector, NewCapacity * SizeOf(Match))
			If pMem = 0 Then
				Deallocate(pMatchVector)
				*ppMatchVector = 0
				Return 0
			End If
			pMatchVector = pMem
		End If

		Dim pFromNullChar As ZString Ptr = @pszFrom[FromLength]
		Dim TailLength As Integer = (pFromNullChar - psLeft) + 1

		pMatchVector[MatchLength].psLeft = psLeft
		pMatchVector[MatchLength].Length = TailLength

		MatchLength += 1
	End Scope

	*ppMatchVector = pMatchVector

	Return MatchLength

End Function

Public Function ReplaceString ( _
		ByVal From As ZString Ptr, _
		ByVal FromLength As Integer, _
		ByVal OldValue As ZString Ptr, _
		ByVal OldValueLength As Integer, _
		ByVal NewValue As ZString Ptr, _
		ByVal NewValueLength As Integer, _
		ByVal ReplaceCount As ReplacementOptions _
	) As ZString Ptr

	If FromLength Then

		If OldValueLength Then
			Dim pszResultString As ZString Ptr = Any

			Dim MatchVector As Match Ptr = Any
			Dim MatchLength As Integer = Any

			Scope
				MatchLength = CalculateMatches( _
					From, _
					FromLength, _
					OldValue, _
					OldValueLength, _
					ReplaceCount, _
					@MatchVector _
				)
				If MatchLength = 0 Then
					Return NULL
				End If

				Dim ResultStringLength As Integer = (NewValueLength - OldValueLength) * MatchLength + FromLength
				If ResultStringLength = 0 Then
					Return NULL
				End If

				pszResultString = Allocate((ResultStringLength + 1) * SizeOf(ZString))
				If pszResultString = 0 Then
					Return NULL
				End If
			End Scope

			Scope
				Dim pszNewValue As ZString Ptr = NewValue
				Dim pszTemp As ZString Ptr = pszResultString

				For i As Integer = 0 To MatchLength - 2
					Dim psLeft As ZString Ptr = MatchVector[i].psLeft
					Dim LeftLength As Integer = MatchVector[i].Length

					memcpy(pszTemp, psLeft, LeftLength * SizeOf(ZString))
					pszTemp = @pszTemp[LeftLength]

					If NewValueLength Then
						memcpy(pszTemp, pszNewValue, NewValueLength * SizeOf(ZString))
						pszTemp = @pszTemp[NewValueLength]
					End If
				Next

				Scope
					Dim i As Integer = MatchLength - 1

					Dim psLeft As ZString Ptr = MatchVector[i].psLeft
					Dim LeftLength As Integer = MatchVector[i].Length

					memcpy(pszTemp, psLeft, LeftLength * SizeOf(ZString))
				End Scope
			End Scope

			Deallocate(MatchVector)

			Return pszResultString
		End If

	End If

	Return NULL

End Function

Const ElapsedCount = 10

Type ElapsedsVector
	vec(0 To (ElapsedCount - 1)) As Double
End Type

Scope
	Print "misc_replace_string_proc"

	Dim Elapseds As ElapsedsVector = Any

	For j As Long = 0 To ElapsedCount - 1

		Dim t As Double = Timer()

		For i As Long = 0 To 1000000 - 1

			Var s = misc_replace_string_proc( _
				"geeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeks", _
				"eek", _
				"1234567890", , _
				1 _
			)

		Next

		Elapseds.vec(j) = Timer() - t
		Print Elapseds.vec(j)
	Next

	Dim Sum As Double
	For j As Long = 0 To ElapsedCount - 1
		Sum += Elapseds.vec(j)
	Next
	Dim Average As Double = Sum / ElapsedCount

	Print "Average", Average
End Scope

Scope
	Const From = "geeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeksgeeksforgeeks"
	Const OldValue = "eek"
	Const NewValue = "1234567890"

	Print "ReplaceString"

	Dim Elapseds As ElapsedsVector = Any

	For j As Integer = 0 To ElapsedCount - 1

		Dim t As Double = Timer()

		For i As Integer = 0 To 1000000 - 1
			Dim resResult As ZString Ptr = ReplaceString( _
				StrPtr(From), Len(From), _
				StrPtr(OldValue), Len(OldValue), _
				StrPtr(NewValue), Len(NewValue), _
				ReplacementOptions.ReplaceAll _
			)

			If resResult Then
				Deallocate(resResult)
			End If
		Next

		Elapseds.vec(j) = Timer() - t
		Print Elapseds.vec(j)
	Next

	Dim Sum As Double
	For j As Integer = 0 To ElapsedCount - 1
		Sum += Elapseds.vec(j)
	Next
	Dim Average As Double = Sum / ElapsedCount

	Print "Average", Average
End Scope
