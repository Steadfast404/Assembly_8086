INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
    INITIAL_SP DW ?   ; To store initial SP value
    NEWLINE DB 0DH, 0AH, '$'  ; Newline for printing

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    PRINT "ENTER THE PARENTHESIS STRING: "

    MOV AX, SP        ; Store initial stack pointer
    MOV INITIAL_SP, AX

INPUT_LOOP:
    MOV AH, 1         ; Read a character
    INT 21H
    CMP AL, 0DH       ; Check if ENTER is pressed (0DH = carriage return)
    JE CHECK_BALANCE  

    CMP AL, '('       ; If '(' then push to stack
    JE PUSH_TO_STACK  

    CMP AL, ')'       ; If ')' then pop from stack
    JE POP_FROM_STACK  

    JMP INPUT_LOOP    ; Ignore non-parenthesis characters

PUSH_TO_STACK:
    PUSH AX           ; Push anything (AX is used as placeholder)
    JMP INPUT_LOOP

POP_FROM_STACK:
    CMP SP, INITIAL_SP  ; If SP matches initial, stack is empty (unmatched ')')
    JE UNBALANCED
    POP AX            ; Pop to balance
    JMP INPUT_LOOP

CHECK_BALANCE:
    CMP SP, INITIAL_SP  ; Check if stack is empty
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
