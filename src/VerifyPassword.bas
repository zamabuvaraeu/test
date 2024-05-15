#include once "VerifyPassword.bi"
#include once "crt.bi"
#include once "Hash.bi"

Const PASSWORD_CAPACITY = 32

Public Function VerifyPassword(ByVal Hash As UInteger) As Boolean
	
	' Пароль
	Dim Password As ZString * (PASSWORD_CAPACITY + 1) = Any
	
	' Получаем пароль с консоли
	fgets(@Password, PASSWORD_CAPACITY, stdin)
	
	' Вычисляем контрольную сумму
	Dim LocalHash As UInteger = CalculateHash(@Password)

	' Обнуляем память перед выходом из функции
	' чтобы злоумышленник не смог прочитать пароль
	memset(@Password, 0, PASSWORD_CAPACITY * SizeOf(ZString))

	' Проверить совпадение контрольных сумм
	If Hash = LocalHash Then
		Return True
	End If
	
	Return False
	
End Function
