Type CycleCounter
	Declare Constructor( ByVal n As Integer )
	'' Implicit step versions
	Declare Operator For ( )
	Declare Operator Step( )
	Declare Operator Next( ByRef end_cond As CycleCounter ) As Integer
	
	'' Explicit step versions
	Declare Operator For ( ByRef step_var As CycleCounter )
	Declare Operator Step( ByRef step_var As CycleCounter )
	Declare Operator Next( ByRef end_cond As CycleCounter, ByRef step_var As CycleCounter ) As Integer
	
	i As Integer
End Type

Const WHITESPACE_CHAR = 32

Dim Shared HelloWorld As WString * 16 = WStr("Hello world!")
Dim Shared TerminationChar As Integer = 0

Dim CharsCount As Integer = 0

' Upper bound (1) is not used in this example
For i As CycleCounter = 0 To 1
	
	If HelloWorld[i.i] = WHITESPACE_CHAR Then
		Continue For
	End If
	
	CharsCount += 1
	
	' Print i.i, clause_terminations[i.i]
	
Next

Print "Not space characters count", CharsCount

Private Constructor CycleCounter( ByVal n As Integer )
	
	i = n
	
End Constructor

Private Operator CycleCounter.For( )
	
	' Print "implicit step"
	
End Operator

Private Operator CycleCounter.Step( )
	
	Dim step_temp As CycleCounter = Type(1)
	this.i += step_temp.i
	
End Operator

Private Operator CycleCounter.Next( ByRef end_condition As CycleCounter ) As Integer
	
	' end_condition is not used in this example
	' we independently from the condition from the cycle

	If i < (SizeOf(HelloWorld) \ SizeOf(WString)) AndAlso HelloWorld[i] <> TerminationChar Then
		Return 1
	End If

	Return 0
	
End Operator
