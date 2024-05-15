#include once "Hash.bi"

' Public Function CalculateHash(ByVal pwd As UByte Ptr) As UInteger
	
' 	Dim Hash As UInteger = 0
' 	Dim pChar As UByte Ptr = pwd
' 	Dim ch As UByte = *pChar
	
' 	Do
' 		Hash += ch
		
' 		pChar += 1
' 		ch = *pChar
' 	Loop While ch
	
' 	Return Hash
	
' End Function

Private Function CalculateHashRec(ByVal pwd As UByte Ptr, ByVal acc As UInteger) As UInteger

	Dim ch As UByte = *pwd
	
	If ch = 0 Then
		Return acc
	End If
	
	Dim pNext As UByte Ptr = pwd + 1
	Dim accNext As UInteger = acc + ch
	
	Return CalculateHashRec(pNext, accNext)
	
End Function

Public Function CalculateHash(ByVal pwd As UByte Ptr) As UInteger
	
	Return CalculateHashRec(pwd, 0)
	
End Function
