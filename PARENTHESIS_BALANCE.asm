INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
    COUNT DB 0   ; Counter to track open parentheses

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    PRINT "ENTER THE PARENTHESIS STRING: "

    XOR BX, BX     ; Clear BX (temporary register for input)
    XOR SI, SI     ; Stack counter initialization

INPUT_LOOP:
    MOV AH, 1      ; Read a character
    INT 21H
    CMP AL, 0DH    ; Check if ENTER is pressed (0DH = carriage return)
    JE CHECK_BALANCE  

    CMP AL, '('    ; Check if '('
    JE INCREMENT_COUNT

    CMP AL, ')'    ; Check if ')'
    JE  DECREMENT_COUNT

    JMP INPUT_LOOP  ; Ignore other characters and continue reading

INCREMENT_COUNT:
 
    INC COUNT  ; Increase count
    JMP INPUT_LOOP

DECREMENT_COUNT:
    CMP COUNT, 0  ; If no unmatched '(', it's unbalanced
    JE UNBALANCED
  
    DEC COUNT  ; Decrease stack count
    JMP INPUT_LOOP

CHECK_BALANCE:
    CMP COUNT, 0  ; If stack is empty, it's balanced
    JNE UNBALANCED

    PRINTN
    PRINT "BALANCED"
    JMP EXIT

UNBALANCED:
    PRINTN
    PRINT "NOT BALANCED"
    
EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
