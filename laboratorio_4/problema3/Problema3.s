.global sum_matrices

sum_matrices:
    @ Inicialización de registros
    MOV r2, #0      @ Índice de fila
    MOV r3, #0      @ Índice de columna
    
loop_row:
    @ Verificar si hemos alcanzado el final de las filas
    CMP r2, #4		@ 4 FILAS 
    BEQ end_sum  @ sale del ciclo y va a end sum 
    
    MOV r3, #0      @ Restablecer el índice de columna para cada fila
    
loop_column:
    @ Verificar si hemos alcanzado el final de las columnas
    CMP r3, #4
    BEQ next_row
    
    @ Calcular el índice actual en las matrices
    MOV r4, #4      @ Tamaño de la fila
    MUL r5, r2, r4  @ Índice de fila * tamaño de la fila
    ADD r5, r5, r3  @ Índice de fila * tamaño de la fila + índice de columna
    
    @ Cargar elementos de las matrices en registros
    LDR r6, [r0, r5, LSL #2]  @ Cargar elemento de la primera matriz
    LDR r7, [r1, r5, LSL #2]  @ Cargar elemento de la segunda matriz
    
    @ Sumar los elementos y almacenar el resultado
    ADD r6, r6, r7
    STR r6, [r0, r5, LSL #2]  @ Almacenar el resultado en la primera matriz
    
    @ Incrementar el índice de columna
    ADD r3, r3, #1 @ suma 1 a r3
    B loop_column

next_row:
    @ Incrementar el índice de fila
    ADD r2, r2, #1  @ suma 1 a r2
    B loop_row

end_sum:
    BX lr   @ Retornar

.data
matrix1:
    .word 1, 2, 3, 4
    .word 5, 6, 7, 8
    .word 9, 10, 11, 12
    .word 13, 14, 15, 16

matrix2:
    .word 16, 15, 14, 13
    .word 12, 11, 10, 9
    .word 8, 7, 6, 5
    .word 4, 3, 2, 1

.text
.global _start
_start:
    LDR r0, =matrix1    @ Cargar la dirección base de la primera matriz en r0
    LDR r1, =matrix2    @ Cargar la dirección base de la segunda matriz en r1
    BL sum_matrices     @ Llamar a la función sum_matrices

    @ FIN 
    B .

