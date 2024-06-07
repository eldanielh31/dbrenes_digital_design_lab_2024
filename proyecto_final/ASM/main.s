.text
.global _start

.equ STDOUT, 1

_start:
    @ Load the message address into r1
    ldr r1, =message
    
    @ Load the length of the message into r2
    ldr r2, =message_end
    
    @ Calculate the length of the message
    sub r2, r2, r1
    
    @ Load the file descriptor (stdout) into r0
    mov r0, #STDOUT   @ Agrega "#" antes de STDOUT
    
    @ Call the write function from the C library
    mov r7, #4       @ Syscall number for write
    swi 0            @ Invoke syscall
    
    @ Exit
    mov r7, #1       @ Syscall number for exit
    mov r0, #0       @ Return 0 status
    swi 0            @ Invoke syscall

.data
message:
    .ascii "Hola, Mundo!\n"
message_end:
