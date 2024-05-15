#include once "windows.bi"
#include once "crt.bi"

#ifdef __FB_64BIT__
Const FormatString = !"%lld\t%lld\r\n"
#else
Const FormatString = !"%d\t%d\r\n"
#endif

Const VECTOR_CAPACITY = 10

Type VectorI
	Items(0 To VECTOR_CAPACITY - 1) As Integer
End Type

' �������-����������
' ����� ������� ��������� ��� ��������� � ���������� ��������
' ����� �� ���� ���������� ������, ������ ��� ��� �����
' ������� ������ ���� �������� ��� "cdecl"
Private Function Comparator cdecl(ByVal p As Const Any Ptr, ByVal q As Const Any Ptr) As Long

	Dim ByRef x As Integer = *CPtr(Integer Ptr, p)
	Dim ByRef y As Integer = *CPtr(Integer Ptr, q)

	' ���������� �� �����������

	If x > y Then
		' ���������� 1 ����� ������ ������� ������
		Return 1
	End If

	If x = y Then
		' ����� �������� �����, ���������� 0
		Return 0
	End If

	' ���������� -1 ����� ������ ������� ������
	Return -1

End Function

' ������ ������ �����
Dim Vector As VectorI = Any
For i As Integer = LBound(Vector.Items) To UBound(Vector.Items)
	Vector.Items(i) = rand()
Next

' ������ �����
Dim Copy As VectorI = Vector

' �����������
qsort( _
	@Vector.Items(0), _    /' ������� ������� ��������� �� ������ ������� '/
	VECTOR_CAPACITY, _     /' ���������� ��������� � ������� '/
	SizeOf(Integer), _     /' ������ ������ �������� '/
	@Comparator _          /' ����� �������-����������� '/
)

' �������������
For i As Integer = LBound(Vector.Items) To UBound(Vector.Items)
	printf(FormatString, i, Vector.Items(i))
Next
