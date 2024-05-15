#include once "crt.bi"
#include once "Tree.bi"
#include once "VerifyPassword.bi"

#ifdef __FB_64BIT__
	Const FormatString = !"Value: %lld\tRepeats: %lld\r\n"
#else
	Const FormatString = !"Value: %d\tRepeats: %d\r\n"
#endif

Private Function TreeAscendingComparator( _
		ByVal Param As Any Ptr, _
		ByVal LeftKey As Integer, _
		ByVal RightKey As Integer _
	)As Integer
	
	If LeftKey > RightKey Then
		Return 1
	Else
		If LeftKey = RightKey Then
			Return 0
		End If
	End If
	
	Return -1
	
End Function

Private Function TreeDescendingComparator( _
		ByVal Param As Any Ptr, _
		ByVal LeftKey As Integer, _
		ByVal RightKey As Integer _
	)As Integer
	
	If LeftKey > RightKey Then
		Return -1
	Else
		If LeftKey = RightKey Then
			Return 0
		End If
	End If
	
	Return 1
	
End Function

Private Sub TreeVisitor( _
		ByVal Param As Any Ptr, _
		ByVal Key As Integer, _
		ByVal Value As Integer, _
		ByVal Repeats As Integer _
	)
	
	printf(@Str(FormatString), Value, Repeats)
	
End Sub

#ifndef WITHOUT_RUNTIME
Private Function EntryPoint()As Integer
#else
Public Function EntryPoint Alias "EntryPoint"()As Integer
#endif
	
	' Dim pTree As Node Ptr = CreateNode()
	' If pTree = 0 Then
	' 	Return 1
	' End If
	
	' Dim mVector(0 To ...) As Integer = {10, 2, 7, 3, 14, 7, 32}
	
	' For i As Integer = LBound(mVector) To UBound(mVector)
	' 	TreeAdd(pTree, mVector(i), mVector(i), @TreeDescendingComparator, 0)
	' Next
	
	' TreeVisit(pTree, @TreeVisitor, 0)
	
	' Dim p As UByte Ptr = Allocate(1024)
	' p[0] = 45
	
	Dim resVerify As Boolean = VerifyPassword(42)

	If resVerify = False Then
		Return 1
	End If
	
	Return 0
	
End Function

#ifndef WITHOUT_RUNTIME
Dim RetCode As Long = CLng(EntryPoint())
End(RetCode)
#endif
