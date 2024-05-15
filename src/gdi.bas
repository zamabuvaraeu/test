#include once "windows.bi"
#include once "win\GdiPlus.bi"

Const DEFAULT_CARD_WIDTH = 90
Const DEFAULT_CARD_HEIGHT = 140

Const DEFAULT_CARD_WIDTH_H2 = 45.0
Const DEFAULT_CARD_HEIGHT_H2 = 70.0

Type BoundsVector
	Vector(3) As Gdiplus.GpRect
End Type

Private Sub DrawCardFrame( _
		ByVal pGraphics As Gdiplus.GpGraphics Ptr, _
		ByVal pBackColorBrush As Gdiplus.GpSolidFill Ptr, _
		ByVal pBlackPen As Gdiplus.GpPen Ptr, _
		ByVal pBlackBrush As Gdiplus.GpSolidFill Ptr _
	)
	
	Dim pPath As Gdiplus.GpPath Ptr = Any
	Dim resCreatePath As Gdiplus.GpStatus = Gdiplus.GdipCreatePath( _
		Gdiplus.FillModeWinding, _
		@pPath _
	)
	
	If resCreatePath = Gdiplus.Ok Then
		
		Gdiplus.GdipStartPathFigure(pPath)
		
		Dim x As Integer = 0
		Dim y As Integer = 0
		
		Dim r As Integer = 10
		
		Dim w As Integer = DEFAULT_CARD_WIDTH - r - 1
		Dim h As Integer = DEFAULT_CARD_HEIGHT - r - 1
		
		Dim Bounds As BoundsVector = Any
		Bounds.Vector(0).X = x
		Bounds.Vector(0).Y = y
		Bounds.Vector(0).Width = r
		Bounds.Vector(0).Height = r
		
		Bounds.Vector(1).X = x + w
		Bounds.Vector(1).Y = y
		Bounds.Vector(1).Width = r
		Bounds.Vector(1).Height = r
		
		Bounds.Vector(2).X = x
		Bounds.Vector(2).Y = y + h
		Bounds.Vector(2).Width = r
		Bounds.Vector(2).Height = r
		
		Bounds.Vector(3).X = x + w
		Bounds.Vector(3).Y = y + h
		Bounds.Vector(3).Width = r
		Bounds.Vector(3).Height = r
		
		' Path.AddArc(El(0), 180, 90)
		Gdiplus.GdipAddPathArcI( _
			pPath, _
			Bounds.Vector(0).X, _
			Bounds.Vector(0).Y, _
			Bounds.Vector(0).Width, _
			Bounds.Vector(0).Height, _
			180, _
			90 _
		)
		
		' Path.AddLine(x + r \ 2, y, x + w + r \ 2, y)
		Gdiplus.GdipAddPathLineI( _
			pPath, _
			x + r \ 2, _
			y, _
			x + w + r \ 2, _
			y _
		)
		
		' Path.AddArc(El(1), 270, 90)
		Gdiplus.GdipAddPathArcI( _
			pPath, _
			Bounds.Vector(1).X, _
			Bounds.Vector(1).Y, _
			Bounds.Vector(1).Width, _
			Bounds.Vector(1).Height, _
			270, _
			90 _
		)
		
		' Path.AddLine(x + w + r, y + r \ 2, x + w + r, y + r \ 2 + h)
		Gdiplus.GdipAddPathLineI( _
			pPath, _
			x + w + r, _
			y + r \ 2, _
			x + w + r, _
			y + r \ 2 + h _
		)
		
		' Path.AddArc(El(3), 0, 90)
		Gdiplus.GdipAddPathArcI( _
			pPath, _
			Bounds.Vector(3).X, _
			Bounds.Vector(3).Y, _
			Bounds.Vector(3).Width, _
			Bounds.Vector(3).Height, _
			0, _
			90 _
		)
		
		' Path.AddLine(x + w + r \ 2, y + h + r, x + r \ 2, y + h + r)
		Gdiplus.GdipAddPathLineI( _
			pPath, _
			x + w + r \ 2, _
			y + h + r, _
			x + r \ 2, _
			y + h + r _
		)
		
		' Path.AddArc(El(2), 90, 90)
		Gdiplus.GdipAddPathArcI( _
			pPath, _
			Bounds.Vector(2).X, _
			Bounds.Vector(2).Y, _
			Bounds.Vector(2).Width, _
			Bounds.Vector(2).Height, _
			90, _
			90 _
		)
		
		' Path.AddLine(x, y + r \ 2 + h, x, y + r \ 2)
		Gdiplus.GdipAddPathLineI( _
			pPath, _
			x, _
			y + r \ 2 + h, _
			x, _
			y + r \ 2 _
		)
		
		Gdiplus.GdipClosePathFigure(pPath)
		
		Dim br As Gdiplus.GpBrush Ptr = CPtr(Gdiplus.GpBrush Ptr, pBackColorBrush)
		Gdiplus.GdipFillPath( _
			pGraphics, _
			br, _
			pPath _
		)
		
		Gdiplus.GdipDrawPath( _
			pGraphics, _
			pBlackPen, _
			pPath _
		)
		
		Gdiplus.GdipDeletePath(pPath)
	End If
	
End Sub

Private Sub DrawCardSignature( _
		ByVal pGraphics As Gdiplus.GpGraphics Ptr, _
		ByVal pBlackBrush As Gdiplus.GpSolidFill Ptr, _
		ByVal pRedBrush As Gdiplus.GpSolidFill Ptr, _
		ByVal pFont As Gdiplus.GpFont Ptr, _
		ByVal pStringFormat As Gdiplus.GpStringFormat Ptr _
	)
	
	Dim StringBounds As Gdiplus.RectF = Any
	StringBounds.X = 1.0
	StringBounds.Y = 1.0
	StringBounds.Width = 100.0
	StringBounds.Height = 100.0
	
	Const AceString = WStr("A")
	
	Dim br As Gdiplus.GpBrush Ptr = CPtr(Gdiplus.GpBrush Ptr, pBlackBrush)
	Gdiplus.GdipDrawString( _
		pGraphics, _
		@AceString, _
		Len(AceString), _
		pFont, _
		@StringBounds, _
		pStringFormat, _
		br _
	)
	
	Gdiplus.GdipScaleWorldTransform( _
		pGraphics, _
		-1.0, _
		-1.0, _
		Gdiplus.MatrixOrderAppend _
	)
	
	Gdiplus.GdipTranslateWorldTransform( _
		pGraphics, _
		DEFAULT_CARD_WIDTH, _
		DEFAULT_CARD_HEIGHT, _
		Gdiplus.MatrixOrderAppend _
	)
	
	Gdiplus.GdipDrawString( _
		pGraphics, _
		@AceString, _
		Len(AceString), _
		pFont, _
		@StringBounds, _
		pStringFormat, _
		br _
	)
	
	Gdiplus.GdipResetWorldTransform(pGraphics)
	
End Sub

Private Sub Render( _
		ByVal pGraphics As Gdiplus.GpGraphics Ptr, _
		ByVal pBackColorBrush As Gdiplus.GpSolidFill Ptr, _
		ByVal pBlackPen As Gdiplus.GpPen Ptr, _
		ByVal pBlackBrush As Gdiplus.GpSolidFill Ptr, _
		ByVal pRedBrush As Gdiplus.GpSolidFill Ptr, _
		ByVal pFont As Gdiplus.GpFont Ptr, _
		ByVal pStringFormat As Gdiplus.GpStringFormat Ptr _
	)
	
	Gdiplus.GdipSetSmoothingMode( _
		pGraphics, _
		Gdiplus.SmoothingModeHighQuality _
	)
	
	DrawCardFrame( _
		pGraphics, _
		pBackColorBrush, _
		pBlackPen, _
		pBlackBrush _
	)
	
	DrawCardSignature( _
		pGraphics, _
		pBlackBrush, _
		pRedBrush, _
		pFont, _
		pStringFormat _
	)
	
End Sub

Private Sub MyCreateMetafile()
	
	Dim pBackColorBrush As Gdiplus.GpSolidFill Ptr = Any
	Dim resCreateBrush As Gdiplus.GpStatus = Gdiplus.GdipCreateSolidFill( _
		&hFFFAFAFA, _
		@pBackColorBrush _
	)
	
	If resCreateBrush = Gdiplus.Ok Then
	
		Dim pBlackBrush As Gdiplus.GpSolidFill Ptr = Any
		Dim resCreateBlackBrush As Gdiplus.GpStatus = Gdiplus.GdipCreateSolidFill( _
			&hFF000000, _
			@pBlackBrush _
		)
		
		If resCreateBlackBrush = Gdiplus.Ok Then
			Dim pRedBrush As Gdiplus.GpSolidFill Ptr = Any
			Dim resCreateRedBrush As Gdiplus.GpStatus = Gdiplus.GdipCreateSolidFill( _
				&hFFFF0000, _
				@pRedBrush _
			)
			
			If resCreateRedBrush = Gdiplus.Ok Then
				Dim pBlackPen As Gdiplus.GpPen Ptr = Any
				Dim resCreatePen As Gdiplus.GpStatus = Gdiplus.GdipCreatePen1( _
					&hFF000000, _
					1.0, _
					Gdiplus.UnitPixel, _
					@pBlackPen _
				)
				
				If resCreatePen = Gdiplus.Ok Then
					Dim pArialFontFamily As Gdiplus.GpFontFamily Ptr = Any
					Dim resCreateFontFamily As Gdiplus.GpStatus = Gdiplus.GdipGetGenericFontFamilySansSerif(@pArialFontFamily)
					
					If resCreateFontFamily = Gdiplus.Ok Then
						
						Dim pFont As Gdiplus.GpFont Ptr = Any
						Dim resCreateFont As Gdiplus.GpStatus = Gdiplus.GdipCreateFont( _
							pArialFontFamily, _
							18.0, _
							Gdiplus.FontStyleRegular, _
							Gdiplus.UnitPoint, _
							@pFont _
						)
						
						If resCreateFont = Gdiplus.Ok Then
							Dim pStringFormat As Gdiplus.GpStringFormat Ptr = Any
							Dim resStringFormat As Gdiplus.GpStatus = Gdiplus.GdipStringFormatGetGenericDefault( _
								@pStringFormat _
							)
							
							If resStringFormat = Gdiplus.Ok Then
								Dim hDC As HDC = GetDC(NULL)
								
								If hDC Then
									
									Dim Bounds As Gdiplus.GpRect = Any
									Bounds.X = 0
									Bounds.Y = 0
									Bounds.Width = DEFAULT_CARD_WIDTH
									Bounds.Height = DEFAULT_CARD_HEIGHT
									
									Const MetaFileName = WStr("Metafile.emf")
									
									Dim pMetaFile As Gdiplus.GpMetafile Ptr = Any
									Dim resMetaFile As Gdiplus.GpStatus = Gdiplus.GdipRecordMetafileFileNameI( _
										@MetaFileName, _
										hDC, _
										Gdiplus.EmfTypeEmfPlusOnly, _
										@Bounds, _
										Gdiplus.MetafileFrameUnitPixel, _
										NULL, _
										@pMetaFile _
									)
									
									If resMetaFile = Gdiplus.Ok Then
										
										Dim img As Gdiplus.GpImage Ptr = CPtr(Gdiplus.GpImage Ptr, pMetaFile)
										
										Dim pGraphics As Gdiplus.GpGraphics Ptr = Any
										Dim resGraphics As Gdiplus.GpStatus = Gdiplus.GdipGetImageGraphicsContext( _
											img, _
											@pGraphics _
										)
										
										If resGraphics = Gdiplus.Ok Then
											Render( _
												pGraphics, _
												pBackColorBrush, _
												pBlackPen, _
												pBlackBrush, _
												pRedBrush, _
												pFont, _
												pStringFormat _
											)
											
											Gdiplus.GdipDeleteGraphics(pGraphics)
										End If
										
										Gdiplus.GdipDisposeImage(img)
									End If
									
									ReleaseDC(NULL, hDC)
								End If
	
								Gdiplus.GdipDeleteStringFormat(pStringFormat)
							End If
							
							Gdiplus.GdipDeleteFont(pFont)
						End If
						
						Gdiplus.GdipDeleteFontFamily(pArialFontFamily)
					End If
					
					Gdiplus.GdipDeletePen(pBlackPen)
				End If
				
				Dim br1 As Gdiplus.GpBrush Ptr = CPtr(Gdiplus.GpBrush Ptr, pRedBrush)
				Gdiplus.GdipDeleteBrush(br1)
			End If
			
			Dim br2 As Gdiplus.GpBrush Ptr = CPtr(Gdiplus.GpBrush Ptr, pBlackBrush)
			Gdiplus.GdipDeleteBrush(br2)
		End If
		
		Dim br3 As Gdiplus.GpBrush Ptr = CPtr(Gdiplus.GpBrush Ptr, pBackColorBrush)
		Gdiplus.GdipDeleteBrush(br3)
	End If
	
End Sub

Private Function RunGdi()As HRESULT
	Dim GdiplusToken As ULONG_PTR = Any
	
	' GDI+ Initialize
	Dim gsi As Gdiplus.GdiplusStartupInput = Any
	ZeroMemory(@gsi, SizeOf(Gdiplus.GdiplusStartupInput))
	gsi.GdiplusVersion = 1
	Dim status As Gdiplus.GpStatus = Gdiplus.GdiplusStartup(@GdiplusToken, @gsi, NULL)
	If status <> Gdiplus.Ok Then
		Return E_FAIL
	End If
	
	MyCreateMetafile()
	
	Gdiplus.GdiplusShutdown(GdiplusToken)
	
	Return S_OK
	
End Function
