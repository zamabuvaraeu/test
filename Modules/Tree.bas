#include "Tree.bi"

	/'
	Const TextLength As Integer = 44
	Dim pText As WString Ptr = @"Текст, в котором считают количество символов"
	' Dim pText As WString Ptr = @"текст"
	
	Dim pTree As Node Ptr = New Node
	' For i As Integer = 0 To Len(*pText) - 1
	For i As Integer = 0 To TextLength - 1
		Dim Char As Integer = pText[i]
		TreeAdd(pTree, Char)
	Next
	
	PrintTree(pTree)
	'/

Sub TreeAdd(ByVal pNode As Node Ptr, ByVal Char As Integer)
	If pNode->Char = 0 Then
		pNode->Char = Char
		pNode->Count = 1
	Else
		Select Case pNode->Char
			Case Is > Char
				If pNode->pRight = 0 Then
					pNode->pRight = New Node
				End If
				TreeAdd(pNode->pRight, Char)
			Case Char
				pNode->Count += 1
			Case Is < Char
				If pNode->pLeft = 0 Then
					pNode->pLeft = New Node
				End If
				TreeAdd(pNode->pLeft, Char)
		End Select
	End If
End Sub

Sub PrintTree(ByVal pNode As Node Ptr)
	If pNode <> 0 Then
		
		PrintTree(pNode->pLeft)
		
		Dim wszChar As WString * (2) = Any
		wszChar[0] = pNode->Char
		wszChar[1] = 0
		
		' Print wszChar, pNode->Count
		Dim wszValue As WString * (256) = Any
		_itow(pNode->Count, @wszValue, 10)
		MessageBox(0, wszValue, wszChar, MB_OK)
		
		PrintTree(pNode->pRight)
		
	End If
End Sub
