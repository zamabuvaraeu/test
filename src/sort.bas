Const VectorLength = 50000000
Const RepeatsLength = 10

Type LargeDouble
	LowPart As Double
	HighPart As Double
End Type

Dim Shared Vector(0 To (VectorLength - 1)) As LargeDouble
Dim Shared Elapsed(0 To (RepeatsLength - 1)) As Integer

Private Operator = (ByRef lhs As LargeDouble, ByRef rhs As LargeDouble) As Integer

	If lhs.HighPart < rhs.HighPart Then
		Return -1
	End If

	If lhs.HighPart = rhs.HighPart Then
		If lhs.LowPart < rhs.LowPart Then
			Return -1
		End If

		If lhs.LowPart = rhs.LowPart Then
			Return 0
		End If
	End If

	Return 1

End Operator

#Macro Smaller(lhs, rhs)
	((lhs.HighPart < rhs.HighPart) OrElse ((lhs.HighPart = rhs.HighPart) AndAlso (lhs.LowPart < rhs.LowPart)))
#EndMacro

Private Function QuickSort( _
		ByVal pVector As LargeDouble Ptr, _
		ByVal l As Integer, _
		ByVal r As Integer, _
		ByVal QsCount As Integer _
	) As Integer

	Dim As Integer size = r - l + 1
	If size < 2 Then
		Return 0
	End If

	Dim As Integer i = l, j = r
	Dim PivotIndex As Integer = l + size \ 2
	Dim Pivot As LargeDouble = pVector[PivotIndex]

	Do
		Scope
			' Do While pVector[i] < Pivot
				' i += 1
			' Loop
			Do While Smaller(pVector[i], Pivot)
				i += 1
			Loop
		End Scope

		Scope
			' Do While Pivot < pVector[j]
				' j -= 1
			' Loop
			Do While Smaller(Pivot, pVector[j])
				j -= 1
			Loop
		End Scope

		If i <= j Then
			Dim pTemp As LargeDouble = pVector[i]
			pVector[i] = pVector[j]
			pVector[j] = pTemp

			i += 1
			j -= 1
		End If

	Loop Until i > j

	Dim QsCount3 As Integer = 0
	If l < j Then
		QsCount3 = QuickSort(pVector, l, j, QsCount)
	End If

	Dim QsCount4 As Integer = 0
	If i < r Then
		QsCount4 = QuickSort(pVector, i, r, QsCount)
	End If

	Return QsCount3 + QsCount4 + size

End Function

Dim As Integer a = LBound(Vector), b = UBound(Vector)

For i As Integer = 0 To RepeatsLength - 1
	Print "Generating vector..."

	Randomize 0

	For j As Integer = a To b 
		Vector(j).LowPart = Rnd()
		Vector(j).HighPart = Rnd()
	Next

	Print "Sorting..."

	Dim dStart As Double = Timer()
	Dim QsCount As Integer = QuickSort(@Vector(0), a, b, 0)
	Dim dEnd As Double = Timer()

	Elapsed(i) = CInt(1000.0 * (dEnd - dStart) + 0.5)

	Print !"\tsort took msec:", Elapsed(i)
	Print !"\tqscount:"; QsCount
Next

Dim Elapseds As Integer = Elapsed(0)
For i As Integer = 1 To RepeatsLength - 1
	Elapseds += Elapsed(i)
Next

Dim Average As Integer = Elapseds \ RepeatsLength
Print "Average:", Average
