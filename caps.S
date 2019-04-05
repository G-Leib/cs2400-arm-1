		;		ARM Programming Assignment #1: Capitalizer
		;
		;		Write a program that goes through the characters in chars,
		;		and Capitalizes every lower-case letter that it finds..
		;		Write the number of capitalizations the program performed
		;		In the caps "fill" memory provided.
		
		;		Your code here
		
		;		To capitalize, subtract 32 from character value
		;		Capitalizable letters have values >= 97 and <= 122
		
chars	DCD		'a', 'B', '5', 'q', '0', 'O', '1', 's', 'b', 'i', 'G'
caps		FILL		4
		ADR		R0, chars			;Find address of chars
		MOV		R1, #0			;Use R1 as offset, initialize as 0
		MOV		R6, #0			;Initialize count as zero in R6
loop
		LDR		R3, [R0, R1]		;Load into R3 value from address in R0 offset by R1
		CMP		R3, #97			;Compare R3 to 97
		BLge		make_cap			;If greater than (lower-case) branch to make_cap
		B		exit				;Branch to exit label (exit condition)
		
make_cap
		SUB		R2, R3, #32		;Subtract 32 from word value (capitalize)
		STR		R2, [R0, R1]		;Store capitalized value back into address at R0 offset by R1
		ADD		R6, R6, #1		;Add one to "count register" (R6)
exit
		ADD		R1, R1, #4		;Add 4 to the offset value
		CMP		R1, #48			;If compare R1 to 48 (size of array)
		Blt		loop				;If offset is still within array, branch to loop
		STR		R6, [R0, R1]		;Store count after array
