#include once "crt.bi"

Const USER_NAME_CAPACITY = 255

Dim user_name As ZString * (USER_NAME_CAPACITY + 1) = Any
Dim user_age As Integer = Any

Print "Enter your name"
scanf(!"%255[^\r\n]", @user_name)

Print "Enter your age"
scanf("%d", @user_age)

Print "You are " & user_name & " and " & user_age & " years old."

Print "Great!"
