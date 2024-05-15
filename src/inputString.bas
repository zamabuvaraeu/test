#include once "crt.bi"

Dim user_name As ZString * 265 = Any
Dim user_age As Integer = Any

Print "Enter your name"
scanf("%s", @user_name)

Print "Enter your age"
scanf("%d", @user_age)

Print "You are " & user_name & " and " & user_age & " years old."

Print "Great!"
