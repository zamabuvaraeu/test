	/'
	Подсчёт количества символов в тексте
	Const TextLength As Integer = 44
	Dim pText As WString Ptr = @"Текст, в котором считают количество символов"
	' For i As Integer = 0 To Len(*pText) - 1
	For i As Integer = 0 To TextLength - 1
		Dim c As Integer = pText[i]
		Chars(c) += 1
	Next
	
	For i As Integer = 0 To UBound(Chars)
		If Chars(i) <> 0 Then
			Dim wszChar As WString * (2) = Any
			wszChar[0] = i
			wszChar[1] = 0
			
			' Print wszChar, Chars(i)
			Dim wszValue As WString * (256) = Any
			_itow(Chars(i), @wszValue, 10)
			MessageBox(0, wszValue, wszChar, MB_OK)
		End If
	Next
	'/
