#include "crt.bi"

Private Sub ac_truncate_blocks_proc(sText As ZString, sMarkerBegin As String , sMarkerEnd As String)
	
	Dim psMarkerBegin As ZString Ptr = StrPtr(sMarkerBegin)
	If psMarkerBegin = 0 Then
		Exit Sub
	End If
	
	Dim psMarkerEnd As ZString Ptr = StrPtr(sMarkerEnd)
	Dim MarkerBeginLength As Integer = Len(sMarkerBegin)
	Dim MarkerEndLength As Integer = Len(sMarkerEnd)
	
	Do
		Dim pStart As ZString Ptr = strstr(sText , psMarkerBegin)
		
		If pStart Then
			
			Dim pEnd As ZString Ptr
			
			If MarkerEndLength Then
				pEnd = strstr(pStart + MarkerBeginLength, psMarkerEnd)
			Endif 
			
			If pEnd Then
				
				Dim TextLength As Integer = Len(sText)
				Dim pNullChar As ZString Ptr = @sText[TextLength]
				memmove(pStart, @pEnd[MarkerEndLength], pNullChar - pEnd - MarkerEndLength + 1)
				
			Else
			
				pStart[0] = 0
				Exit Do
				
			Endif
			
		Else
			Exit Do
		Endif
		
	Loop
	
End Sub

Private Function ac_truncate_blocks_proc2(sText As String , sMarkerBegin As String , sMarkerEnd As String) As String
	
	Dim As Integer iStart = 0 , iEnd
	
	If Len(sMarkerBegin) Then
		
		Do
			
			Dim As Byte Ptr pString0 = Strptr(sText)
			
			If pString0 = 0 Then Exit Do
			
			Dim As Byte Ptr pFind_1 = pString0+iStart
			
			pFind_1 = strstr( pFind_1 , Strptr(sMarkerBegin))
			
			If pFind_1 Then
				
				iStart = pFind_1-pString0
				
				Dim As Byte Ptr pFind_2
				
				If Len(sMarkerEnd) Then
					
					pFind_2 = strstr(pFind_1+1 , Strptr(sMarkerEnd))
					
				Endif 
				
				If pFind_2 Then
					
					Dim As Long iAlloc = Len(sText)
					
					Dim As Zstring Ptr psz1 = Allocate(iAlloc+1)
					
					If psz1 = 0 Then Exit Do
					
					psz1[iAlloc] = 0
					
					iAlloc = Len(sText)-(pFind_2-pString0)
					
					Dim As Zstring Ptr psz2 = Allocate(iAlloc+1)
					
					If psz2 = 0 Then Exit Do
					
					psz2[iAlloc] = 0
					
					strcpy(psz1 , pString0)
					
					(*psz1)[pFind_1-pString0] = 0
					
					strcpy(psz2 , pFind_2+Len(sMarkerEnd))
					
					sText = (*psz1) & (*psz2)
					
					Deallocate(psz1)
					
					Deallocate(psz2)
					
				Else
					
					Dim As Long iAlloc = Len(sText)
					
					Dim As Zstring Ptr psz1 = Allocate(iAlloc+1)
					
					If psz1 = 0 Then Exit Do
					
					psz1[iAlloc] = 0
					
					strcpy(psz1 , pString0)
					
					(*psz1)[pFind_1-pString0] = 0
					
					sText = *psz1
					
					Deallocate(psz1)
					
					Exit Do
					
				Endif
				
			Else
				
				Exit Do
				
			Endif       
			
		Loop 
		
	Endif   
	
	Return sText
	
End Function

Private Function misc_replace_string_proc ( _
		Byval sString As String, _
		Byval sSearchStr As String, _
		Byval sReplaceStr As String, _
		Byval iPosition As Integer = 1 , _
		Byval iSearchParam As Integer = 0 _
	) As String
    
    Dim As String szTempString , sReturnString = sString
    
    Dim As Long iPosSearch, iPosSearchNext = iPosition, iPos0 = 1
    
    Do
    
        iPosSearch = Instr(iPosSearchNext , sReturnString , sSearchStr)
        
        If iPosSearch<>0 Then
        
            szTempString = Mid(sReturnString , iPos0 , iPosSearch - 1 ) & sReplaceStr & Mid(sReturnString , iPosSearch + Len(sSearchStr))
            
            If iSearchParam = 1 Then
            
                sReturnString = szTempString
                
                iPosSearchNext = iPosSearch + Len(sReplaceStr)
            
            Else
            
                Return szTempString
            
            Endif
            
        Else
            
            Return sReturnString
        
        Endif
    
    Loop
  
End Function

' Const SourceText = "1/' грамматике лексер '/ 2/''/3"

' Dim MarkBegin As String = "/'"
' Dim MarkEnd As String = "'/"

' Dim As Double tt

' For j As Long = 0 To 99
	
	' Dim sTextTemp As ZString Ptr = Allocate(Len(SourceText) + 1)
	' memcpy(sTextTemp, @SourceText, Len(SourceText) + 1)
	
	' Var t = Timer()
	
	' For i As Long = 0 To 100000
		' ac_truncate_blocks_proc(*sTextTemp, MarkBegin, MarkEnd)
	' Next
	
	' tt += Timer() - t
	
	' Deallocate(sTextTemp)
	
' Next

' ? tt / 100.0

' For j As Long = 0 To 99
	
	' Dim As String sTextTemp = SourceText
	' Var t = Timer()
	
	' For i As Long = 0 To 100000
		' ac_truncate_blocks_proc2(sTextTemp , "/'" , "'/")
	' Next
	
	' tt += Timer() - t
' Next

' ? tt / 100.0


/'
Dim Shared tbspc_tab_to_spaces_proc As Sub()

Dim Shared enc_encode_buffer_proc As Function (pszEncToStack As Zstring Ptr , pszEncFromStack As Zstring Ptr , pbBuf As Byte Ptr, iSizeBuf As Integer , Byref iSizeReturnBytes As Integer , multitext As Any Ptr = 0 , iProjectFlag As Long = 0) As Byte Ptr

Dim pDll As Any Ptr = Dylibload("fbnp.exe")

If pDll Then
	Print "Success DLL"

	enc_encode_buffer_proc = Dylibsymbol(pDll, "ENC_ENCODE_BUFFER_PROC")
	If enc_encode_buffer_proc Then
		Print "Success enc_encode_buffer_proc"
	End If

	tbspc_tab_to_spaces_proc = Dylibsymbol(pDll, "TBSPC_TAB_TO_SPACES_PROC")
	If tbspc_tab_to_spaces_proc Then
		Print "Success tbspc_tab_to_spaces_proc"
	End If
	
End If

'/
