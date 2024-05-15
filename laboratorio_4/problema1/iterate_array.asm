.data
myArray:     .word   1, 2, 3, 4, 5, 6, 7, 8, 9, 10
arraySize:   .word   10     @size of myArray
y:			 .word	 3		@constant


.global _start
.text
_start:
LDR   r1, =arraySize    @ r1 = &arraySize
LDR   r1, [r1]          @ r1 = arraySize

LDR   r2, =myArray      @ load myArray start address
                        @ r2 will always point at array start

MOV   r3, #0            @ r3 = loop counter
MOV   r5, #0            @ r5 = bytes into array to current element
LDR   r4, =y			@ r4 = &y
LDR   r4, [r4]          @ r4 = y

B     looptest          @ jump ahead to loop test

loopstart:
@Calculate address of current element by adding offset r5 to base address
LDR   r6, [r2, r5]      @ r6 = element at address r2 + r5
CMP   r6, r4
BGE   first_condition

ADD r7, r6, r4 
B next_step

first_condition:
MUL r7, r6, r4

next_step:
STR r7, [r2, r5]		@ store new array value
@go to next step
ADD   r3, r3, #1        @ add one to counter
ADD   r5, r5, #4        @ add 4 to offset value for "current element"

looptest:
CMP   r3, r1            @ Compare counter r3 to size of array in r1
BLT   loopstart         @ If counter Less Than size, go back to start

end:
B     end               @stop here