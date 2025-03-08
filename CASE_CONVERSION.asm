INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA

    letter DB ?

.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX

    
    PRINT "Enter a letter:"

    ; Read a single letter
    MOV AH, 01H
    INT 21H
    MOV letter, AL 

    PRINTN
    
    CALL CHECK_CASE

    CALL CONVERT_CASE

    ; Print the converted letter
    PRINT "Converted letter:"

    MOV DL, letter 
    MOV AH, 02H 
    INT 21H

    PRINTN

    ; exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Procedure to check if the letter is uppercase or lowercase
CHECK_CASE PROC
    MOV AL, letter
     
    CMP AL, 'A'
    JB NOT_UPPERCASE 
    CMP AL, 'Z'
    JA NOT_UPPERCASE 

    PRINTN "The letter is uppercase."
    JMP END_CHECK

NOT_UPPERCASE:
   
    CMP AL, 'a'
    JB END_CHECK 
    CMP AL, 'z'
    JA END_CHECK 

    PRINTN "The letter is lowercase."

END_CHECK:
    RET
CHECK_CASE ENDP

; Procedure to convert the letter to its alternate case
CONVERT_CASE PROC
    MOV AL, letter 

    CMP AL, 'A'
    JB NOT_UPPERCASE_CONVERT 
    CMP AL, 'Z'
    JA NOT_UPPERCASE_CONVERT 

    ADD AL, 32 ; Add 32 to convert to lowercase
    JMP END_CONVERT

NOT_UPPERCASE_CONVERT:
    
    CMP AL, 'a'
    JB END_CONVERT 
    CMP AL, 'z'
    JA END_CONVERT 

    
    SUB AL, 32 ; Subtract 32 to convert to uppercase

END_CONVERT:
    MOV letter, AL ; Store the converted letter back in memory
    RET
CONVERT_CASE ENDP

END MAIN