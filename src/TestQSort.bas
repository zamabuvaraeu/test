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

' Функция-компаратор
' Такая функция принимает два аргумента и возвращает значение
' какой из этих аргументов больше, меньше или они равны
' Функция должна быть отмечена как "cdecl"
Private Function Comparator cdecl(ByVal p As Const Any Ptr, ByVal q As Const Any Ptr) As Long

	Dim ByRef x As Integer = *CPtr(Integer Ptr, p)
	Dim ByRef y As Integer = *CPtr(Integer Ptr, q)

	' Сортировка по возрастанию

	If x > y Then
		' Возвращаем 1 когда первый элемент больше
		Return 1
	End If

	If x = y Then
		' Когда элементы равны, возвращаем 0
		Return 0
	End If

	' Возвращаем -1 когда второй элемент больше
	Return -1

End Function

' Вводим массив чисел
Dim Vector As VectorI = Any
For i As Integer = LBound(Vector.Items) To UBound(Vector.Items)
	Vector.Items(i) = rand()
Next

' Создаём копию
Dim Copy As VectorI = Vector

' Сортировать
qsort( _
	@Vector.Items(0), _    /' Функция требует указатель на начало массива '/
	VECTOR_CAPACITY, _     /' Количество элементов в массиве '/
	SizeOf(Integer), _     /' Размер одного элемента '/
	@Comparator _          /' Адрес функции-компаратора '/
)

' Распечатываем
For i As Integer = LBound(Vector.Items) To UBound(Vector.Items)
	printf(FormatString, i, Vector.Items(i))
Next
