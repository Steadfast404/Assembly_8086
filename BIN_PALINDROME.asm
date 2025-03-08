.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'Enter binary sequence: $'  
MSG2 DB 0DH, 0AH, 'Palindrome$'  
MSG3 DB 0DH, 0AH, 'Not a Palindrome$'  
SEQ DB 20 DUP('$') ; Store input (max 20 bits)
LEN DB 0 ; Length of the input

.CODE
MAIN PROC
    ; Load Data Segment
    MOV AX,@DATA
    MOV DS,AX
      
    MOV DX, OFFSET MSG1
    MOV AH, 09H ; Print string
    INT 21H

    ; Read input
    LEA SI, SEQ ; Load address of sequence
    MOV CX, 0 ; Initialize length counter

READ_LOOP:  
    MOV AH, 01H ; Read character
    INT 21H
    CMP AL, 0DH ; Check if Enter is pressed
    JE DONE_INPUT    
    MOV [SI], AL ; Store in sequence buffer
    INC SI ; Move to next position
    INC CX ; Increment length counter
    JMP READ_LOOP ; Continue reading

DONE_INPUT:  
    MOV LEN, CL ; Store length of sequence

    ; Check Palindrome
    LEA SI, SEQ ; SI points to start of sequence
    LEA DI, SEQ ; DI points to start
    ADD DI, CX ; Move DI to end position
    DEC DI ; Point to last character

CHECK_LOOP:  
    CMP SI, DI ; If SI >= DI, stop checking
    JGE PALINDROME

    MOV AL, [SI] ; Load left character
    MOV BL, [DI] ; Load right character
    CMP AL, BL ; Compare both
    JNE NOT_PALINDROME

    INC SI ; Move forward from start
    DEC DI ; Move backward from end
    JMP CHECK_LOOP ; Continue checking

PALINDROME:  
    MOV DX, OFFSET MSG2
    JMP PRINT_RESULT

NOT_PALINDROME:  
    MOV DX, OFFSET MSG3

PRINT_RESULT:  
    MOV AH, 09H ; Print result message
    INT 21H
    MOV AH, 4CH ; Exit program
    INT 21H
    MAIN ENDP
END MAIN