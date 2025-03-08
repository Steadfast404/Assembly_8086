; PROGRAM TO TAKE AN 8-BIT BINARY INPUT AND REVERSE ITS BITS
INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
    INPUT   DB 8 DUP(?)  ; Store 8-bit binary input as a string
    VALUE   DB 0         ; Store converted binary value
    REVERSE DB 0         ; Store reversed bits
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; PROMPT USER FOR 8-BIT BINARY INPUT
    PRINTN "ENTER AN 8-BIT BINARY NUMBER:"

    ; READ 8-CHARACTER BINARY INPUT
    MOV SI, 0
    MOV CX, 8

INPUT_LOOP:
    MOV AH, 01H        ; Read a character
    INT 21H
    MOV INPUT[SI], AL  ; Store character
    INC SI
    LOOP INPUT_LOOP
    PRINTN
    
    ; CONVERT BINARY STRING TO NUMERIC VALUE
    MOV SI, 0
    MOV CX, 8
    XOR AL, AL         ; Clear AL

CONVERT_LOOP:
    SHL AL, 1          ; Shift left to make space for next bit
    MOV DL, INPUT[SI]  ; Get character
    SUB DL, '0'        ; Convert ASCII '0'/'1' to numeric 0/1
    OR AL, DL          ; Merge bit into AL
    INC SI
    LOOP CONVERT_LOOP

    MOV VALUE, AL      ; Store converted value

    ; REVERSE THE BITS
    MOV AL, VALUE      ; Move input value to AL
    MOV CL, 8
    XOR BL, BL         ; Clear BL

REVERSE_LOOP:
    ROR AL, 1          ; Rotate AL right
    RCL BL, 1          ; Rotate BL left
    LOOP REVERSE_LOOP

    MOV REVERSE, BL    ; Store reversed bits

    ; PRINT REVERSED BINARY
    PRINTN "REVERSED BINARY: "
    MOV AH,02H
    MOV DL,REVERSE
    INT 21H
    PRINTN
    
    MOV CL, 8

PRINT_REVERSED:
    ROL REVERSE, 1     ; Rotate left to get MSB
    JC PRINT_1
    PRINT "0"
    JMP NEXT_BIT

PRINT_1:
    PRINT "1"

NEXT_BIT:
    LOOP PRINT_REVERSED

    PRINTN
    JMP EXIT

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
