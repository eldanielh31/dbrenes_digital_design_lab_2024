.text
.global _start

.equ STDOUT, 1
.equ RAM_START, 0x00000000  @ Dirección de inicio de la RAM
.equ RAM_SIZE, 1024          @ Tamaño de la RAM en bytes

_start:
    @ Load the start address of the message into r1
    ldr r1, =RAM_START
    
    @ Load the end address of the message into r2
    add r2, r1, #RAM_SIZE
    
    @ Call the function to count words with 3 vowels and replace vowels with *
    bl count_and_replace_vowels
    
    @ Load the file descriptor (stdout) into r0
    mov r0, #STDOUT
    
    @ Call the write function from the C library to print the modified message
    mov r1, r1
    sub r2, r2, r1   @ Calculate the length of the message
    mov r7, #4       @ Syscall number for write
    swi 0            @ Invoke syscall
    
    @ Exit
    mov r7, #1       @ Syscall number for exit
    mov r0, #0       @ Return 0 status
    swi 0            @ Invoke syscall

count_and_replace_vowels:
    @ Initialize counters
    mov r3, #0      @ Counter for words with 3 vowels
    mov r4, #0      @ Counter for vowels
    mov r5, #0      @ Word length counter (to handle only the current word)
    
    loop_start:
        @ Check if we have reached the end of the message
        cmp r1, r2
        bge loop_end

        @ Load a character from the message into r7
        ldrb r7, [r1]
        
        @ Check if the character is a space or punctuation
        cmp r7, #' '
        beq check_end_of_word
        cmp r7, #','
        beq check_end_of_word
        cmp r7, #'.'
        beq check_end_of_word
        cmp r7, #'!'
        beq check_end_of_word
        cmp r7, #'?'
        beq check_end_of_word

        @ Check if the character is a vowel (only lowercase)
        cmp r7, #'a'
        beq vowel_found
        cmp r7, #'e'
        beq vowel_found
        cmp r7, #'i'
        beq vowel_found
        cmp r7, #'o'
        beq vowel_found
        cmp r7, #'u'
        beq vowel_found

        @ Move to the next character
        add r1, r1, #1
        add r5, r5, #1
        b loop_start

    check_end_of_word:
        @ Check if the word has exactly 3 vowels
        cmp r4, #3
        bne reset_counters

        @ Replace vowels in the word with *
        sub r0, r1, r5   @ Point to the start of the current word
        replace_vowel_loop:
            ldrb r7, [r0]
            cmp r7, #'a'
            beq replace_vowel
            cmp r7, #'e'
            beq replace_vowel
            cmp r7, #'i'
            beq replace_vowel
            cmp r7, #'o'
            beq replace_vowel
            cmp r7, #'u'
            beq replace_vowel

            b next_char_in_word

        replace_vowel:
            mov r7, #'*'
            strb r7, [r0]

        next_char_in_word:
            add r0, r0, #1
            sub r5, r5, #1
            cmp r5, #0
            bne replace_vowel_loop

        reset_counters:
        @ Reset vowel and word length counters
        mov r4, #0
        mov r5, #0

        @ Move to the next character
        add r1, r1, #1
        b loop_start

    vowel_found:
        @ Increment vowel counter
        add r4, r4, #1

        @ Move to the next character
        add r1, r1, #1
        add r5, r5, #1
        b loop_start

    loop_end:
        @ Return
        mov pc, lr
