#include once "windows.bi"

Const MSGF_SLEEPMSG = &h5300
Const NET_EVENT_RECEIVE = 1
Const NET_EVENT_SEND = 2

Private Function GetNetworkMessage() As Boolean
	
	' 10 seconds
	Const dwTimeout As DWORD = 10 * 1000
	
	Dim dwStart As DWORD = GetTickCount()
	Dim dwFinish As DWORD = dwStart
	
	Dim dwElapsed As DWORD = dwFinish - dwStart
	
	Do
		Dim dwTimes As DWORD = dwTimeout - dwElapsed
		Dim dwStatus As DWORD = MsgWaitForMultipleObjects( _
			0, _
			NULL, _
			TRUE, _
			dwTimes, _
			QS_ALLINPUT _
		)
		
		If dwStatus = WAIT_OBJECT_0 Then
			
			Dim m As MSG = Any
			Dim resPeek As BOOL = PeekMessage(@m, NULL, 0, 0, PM_REMOVE)
			
			Do While resPeek
				Select Case m.message
					Case WM_QUIT
						PostQuitMessage(m.wParam)
						Return False
					Case NET_EVENT_RECEIVE
						' Пришли данные из сети
						' TODO обработать
					Case NET_EVENT_SEND
						' Можно отправлять данные в сеть
						
				End Select
				
				Dim resCallFilter As BOOL = CallMsgFilter(@m, MSGF_SLEEPMSG)
				If resCallFilter = 0 Then
					TranslateMessage(@m)
					DispatchMessage(@m)
				End If
				
				resPeek = PeekMessage(@m, NULL, 0, 0, PM_REMOVE)
			Loop
		End If
		
		dwFinish = GetTickCount()
		dwElapsed = dwFinish - dwStart
	Loop While dwElapsed < dwTimeout
	
	Return True
	
End Function
