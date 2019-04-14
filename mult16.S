		;		ARM Programming Assignment #1: 16 bit multiplier
		;
		;		Write a 16-bit multiplier, meaning numbers that have their high 16 bits set to 0.
		;		Use the standard shift-and-add operation.
		;		Note that we cannot address half-words here. We can only address words and bytes (B).
		;		Use the two numbers as an example but write it so it works for any two 16-bit numbers.
		;		Write the result in the provided "fill" word.
		;		Indicate if there was a high-bit carry using the provided "fill" word.
		
		;		Your code here
			
numbers		DCD		0b1100101010010001, 0b1111010101000011
result		FILL		4		;51443
carry		FILL		4		;Yes
bits_amt		DCD		16
overflow		DCD		0b10000000000000000
			ADR		R6, numbers
			MOV		R0, #0			;Counter initialized to 0
			ADR		R7, bits_amt		;Find the amount of bits
			LDR		R7, [R7]			;Load the amount of bits
			LDMia	R6!, {R1, R2}		;Load numbers to be multiplied (added) into R1 and R2
			MOV		R3, #0			;Initialize product (sum) as 0
			MOV		R5, #1			;Use R5 as mask for 0b1
			ADR		R8, overflow		;check for overflow
			LDR		R8, [R8]			;Overflow mask
			MOV		R10, #0			;Initialize R10 to 0, will set to 1 if overflow occurs
check_lsb
			AND		R4, R2, R5		;Check if least significant bit is 1
			CMP		R4, #1			;Compare mask result
			Beq		adder
increment_1
			LSL		R1, R1, #1		;Shift R1 to the left to be added
			AND		R9, R1, R8		;Check if there is a bit greater than 16
			CMP		R9, R8			;Compare mask result
			Bne		increment_2		;Skip truncation if no overflow
			SUB		R1, R1, R8		;Truncate overflow bit
increment_2
			LSR		R2, R2, #1		;Shift R2 to the right to check least significant bit
			ADD		R0, R0, #1		;Increment bit counter
			CMP		R0, R7			;Check if current bit is less than total bits
			Bge		exit
			B		check_lsb
adder
			ADD		R3, R3, R1		;Add shifted bits
			AND		R9, R3, R8		;Check if there is a bit greater than 16
			CMP		R9, R8			;Compare mask result
			Beq		sum_overflow		;Branch to sum overflow handler
			B		increment_1
exit
			ADR		R1, result		;Load address of result in R1
			ADR		R2, carry			;Load address of carry in R2
			STR		R3, [R1]			;Store result in result fill of memory
			STR		R10, [R2]			;Store carry in carry fill of memory
			END
sum_overflow
			SUB		R3, R3, R8		;Truncate overflow bit
			MOV		R10, #1			;R10 indicates overflow occured
			B		increment_1
