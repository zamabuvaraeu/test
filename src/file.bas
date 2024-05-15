#include once "crt.bi"

' Функция‐компаратор
' Такая функция принимает два аргумента и возвращает значение
' какой из этих аргументов больше, меньше или они равны
' Функция должна быть отмечена как "cdecl"
Private Function Comparator cdecl(ByVal p As Const Any Ptr, ByVal q As Const Any Ptr) As Long
	
	Dim px As Integer Ptr = CPtr(Integer Ptr, p)
	Dim py As Integer Ptr = CPtr(Integer Ptr, q)
	
	' Для сортировки по возрастанию
	If *px > *py Then
		' Возвращаем 1 когда первый элемент больше
		Return 1
	Else
		If *py > *px Then
			' Возвращаем -1 когда второй элемент больше
			Return -1
		End If
	End If
	
	' Когда элементы равны, возвращаем 0
	Return 0
	
End Function

' Вводим массив чисел
Dim Vector(9) As Integer
For i As Integer = LBound(Vector) To UBound(Vector)
	Vector(i) = rand()
	printf(!"%lld\t%lld\r\n", i, Vector(i))
Next

' Сортировать
qsort( _
	@Vector(0), _      /' Функция требует указатель на начало массива '/
	10, _              /' Количество элементов в массиве '/
	SizeOf(Integer), _ /' Размер одного элемента '/
	@Comparator _      /' Адрес функции-компаратора '/
)

' Распечатываем
For i As Integer = LBound(Vector) To UBound(Vector)
	printf(!"%lld\t%lld\r\n", i, Vector(i))
Next
