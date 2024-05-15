#include once "windows.bi"
#include once "crt.bi"

Private Sub PrintWalkingHeapString( _
		ByVal hHeap As HANDLE _
	)

	Const BufSize As Integer = 256
	Const FormatString = WStr(!"Walking heap %#p...\r\n")
	Dim buf As WString * BufSize = Any
	wsprintfW( _
		@buf, _
		@FormatString, _
		hHeap _
	)

	Print buf

End Sub

Private Sub PrintAllocatedBlockString( _
		ByVal pMem As Any Ptr _
	)

	Dim IdString As ZString * 17 = Any
	CopyMemory( _
		@IdString, _
		pMem, _
		16 _
	)
	IdString[16] = 0

	Const BufSize As Integer = 256
	Const FormatString = WStr(!"Allocated block\t\t%hs\r\n")
	Dim buf As WString * BufSize = Any
	wsprintfW( _
		@buf, _
		@FormatString, _
		@IdString _
	)

	Print buf

End Sub

Private Sub PrintMovableWithHANDLEString( _
		ByVal hMem As Any Ptr _
	)

	Const BufSize As Integer = 256
	Const FormatString = WStr(!"\tMovable with HANDLE %#p\r\n")

	Dim buf As WString * BufSize = Any
	wsprintfW( _
		@buf, _
		@FormatString, _
		hMem _
	)

	Print buf

End Sub

Private Sub PrintDdeShareString( _
	)

	Print WStr(!"\tDdeShare")

End Sub

Private Sub PrintRegionString( _
		ByVal dwCommittedSize As DWORD, _
		ByVal dwUnCommittedSize As DWORD, _
		ByVal FirstBlockOffset As Integer, _
		ByVal LastBlockOffset As Integer _
	)

	Const BufSize As Integer = 256
	Const FormatString = WStr(!"Region\r\n\t%d bytes committed\r\n\t%d bytes uncommitted\r\n\tFirst block offset:\t0x%04X\r\n\tLast block offset:\t0x%04X\r\n")

	Dim buf As WString * BufSize = Any
	wsprintfW( _
		@buf, _
		@FormatString, _
		dwCommittedSize, _
		dwUnCommittedSize, _
		FirstBlockOffset, _
		LastBlockOffset _
	)

	Print buf

End Sub

Private Sub PrintUncommitedRangeString( _
	)

	Print WStr("Uncommitted range")

End Sub

Private Sub PrintFreeBlockString( _
	)

	Print WStr("Free block")

End Sub

Private Sub PrintDataPortionString( _
		ByVal DataOffset As Integer, _
		ByVal cbData As Integer, _
		ByVal cbOverhead As Integer, _
		ByVal iRegionIndex As Integer _
	)

	Const BufSize As Integer = 256
	Const FormatString = WStr(!"\tData portion begins at:\t0x%04X\r\n\tSize:\t\t%d bytes\r\n\tOverhead:\t%d bytes\r\n\tRegion index:\t%d\r\n")

	Dim buf As WString * BufSize = Any
	wsprintfW( _
		@buf, _
		@FormatString, _
		DataOffset, _
		cbData, _
		cbOverhead, _
		iRegionIndex _
	)

	Print buf

End Sub

Private Sub PrintWalkingHeap( _
		ByVal hHeap As HANDLE _
	)

	PrintWalkingHeapString(hHeap)

	Dim Entry As PROCESS_HEAP_ENTRY = Any
	Entry.lpData = NULL

	Dim resWalk As BOOL = HeapWalk(hHeap, @Entry)

	Do While resWalk <> 0

		Dim IsAllocatedBlock As Integer = Entry.wFlags And PROCESS_HEAP_ENTRY_BUSY

		If IsAllocatedBlock Then

			PrintAllocatedBlockString(Entry.lpData)

			Dim MovableFlag As Integer = Entry.wFlags And PROCESS_HEAP_ENTRY_MOVEABLE

			If MovableFlag Then
				PrintMovableWithHANDLEString(Entry.Block.hMem)
			End If

			Dim DdeShareFlag As Integer = Entry.wFlags And PROCESS_HEAP_ENTRY_DDESHARE

			If DdeShareFlag Then
				PrintDdeShareString()
			End If
		Else
			Dim IsRegion As Integer = Entry.wFlags And PROCESS_HEAP_REGION

			If IsRegion Then
				Dim FirstBlockOffset As Integer = Entry.Region.lpFirstBlock - hHeap
				Dim LastBlockOffset As Integer = Entry.Region.lpLastBlock - hHeap
				PrintRegionString( _
					Entry.Region.dwCommittedSize, _
					Entry.Region.dwUnCommittedSize, _
					FirstBlockOffset, _
					LastBlockOffset _
				)
			Else
				Dim IsUncommitted As Integer = Entry.wFlags And PROCESS_HEAP_UNCOMMITTED_RANGE

				If IsUncommitted Then
					PrintUncommitedRangeString()
				Else
					PrintFreeBlockString()
				End If
			End If
		End If

		Dim DataOffset As Integer = Entry.lpData - hHeap
		PrintDataPortionString( _
			DataOffset, _
			Entry.cbData, _
			Entry.cbOverhead, _
			Entry.iRegionIndex _
		)

		resWalk = HeapWalk(hHeap, @Entry)
	Loop

End Sub
