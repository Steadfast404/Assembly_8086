;The program takes the number of days(up to 65535) as input
;And convert and displays in years,months,weeks and days

INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
    INPUT DB 6, ?, 6 DUP('$')
    DAYS DW ?
    YEARS DW ?
    MONTHS DW ?
    WEEKS DW ?
    REMAINING_DAYS DW ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    PRINT "Enter number of days (up to 65535):"
    
    CALL INDEC
    MOV DAYS,AX
    PRINTN
    
    ; Calculate years
    MOV AX, DAYS
    MOV BX, 365
    XOR DX, DX
    DIV BX
    MOV YEARS, AX
    MOV REMAINING_DAYS, DX
   
    ; Calculate months
    MOV AX, REMAINING_DAYS
    MOV BX, 30
    XOR DX, DX
    DIV BX
    MOV MONTHS , AX
    MOV REMAINING_DAYS, DX
    
    ; Calculate weeks
    MOV AX, REMAINING_DAYS
    MOV BX, 7
    XOR DX, DX
    DIV BX
    MOV WEEKS, AX
    MOV REMAINING_DAYS, DX
    
    ; Display results
    ; Display years
    PRINT "YEARS:"
    MOV AX, YEARS
    CALL OUTDEC
    PRINTN
    
    ; Display months
    PRINT "MONTHS:"
    MOV AX, MONTHS
    CALL OUTDEC
    PRINTN
    
    ; Display weeks
    PRINT "WEEKS:"
    MOV AX, WEEKS
    CALL OUTDEC
    PRINTN
    ; Display remaining days
    PRINT "DAYS:"
    MOV AX, REMAINING_DAYS
    CALL OUTDEC
    PRINTN
    

    MOV AH,4CH
    INT 21H
    MAIN ENDP

INDEC PROC
    ;reads a number in range -32768 to 32767
    ;input:none
    ;output:AX=binary equivalent of number
    PUSH BX
    PUSH CX
    PUSH DX
    ;print prompt
    BEGIN:
    MOV AH,2
    MOV DL,'?'
    INT 21H
    ;total=0
    XOR BX,BX
    ;negative=false
    XOR CX,CX
    ;read a character
    MOV AH,1
    INT 21H
    ;case character of
    CMP AL,'-'
    JE MINUS
    CMP AL,'+'
    JE PLUS
    JMP REPEAT2
    MINUS:
    MOV CX,1
    PLUS:
    INT 21H
    ;end_case
    REPEAT2:
    ;if character is between '0' and '9'
    CMP AL,'0'
    JNGE NOT_DIGIT
    CMP AL,'9'
    JNLE NOT_DIGIT
    ;then convert character to a digit
    AND  AX,000FH
    PUSH AX
    ;total=totalx10+digit
    MOV AX,10
    MUL BX
    POP BX
    ADD BX,AX
    ;read a character
    MOV AH,1 
    INT 21H
    CMP AL,0DH
    JNE REPEAT2
    ;until  CR
    MOV AX,BX
    ;if negative
    OR CX,CX
    JE EXIT
    ;then
    NEG AX
    ;end_if
    EXIT:
    POP DX
    POP CX
    POP BX
    RET
    ;here if illegal character entered
    NOT_DIGIT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP BEGIN
    INDEC ENDP

;-120
;120/10->12 0(s)
;12/10->1 2(s)
;1(s)
OUTDEC PROC
    ;prints AX as a signed decimal integer
    ;input: AX 
    ;output: none 
    
    ;saving values of AX-DX as they will be changed during operations
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    ;if AX<0 [i.e. negative number]
    OR AX,AX    
    JGE END_IF1
    ;then
    PUSH AX  ;to conserve the value of AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX   ;to restore the value of AX
    NEG AX   ;to get absolute value  -(-AX) = AX
    
    
    END_IF1:
    ;get decimal digits
    XOR CX,CX
    MOV BX,10D
    REPEAT1:
    XOR DX,DX
    DIV BX   ;AX/10
    PUSH DX  ;remainder (i.e. digit in LSB position)
    INC CX   ;to keep count of number of digits
    
    ;until value becomes 0
    OR AX,AX
    JNE REPEAT1
    
    
    ;convert digits to characters and print
    MOV AH,2
    ;for count times do
    PRINT_LOOP: 
    POP DX   
    OR DL,30H 
    INT 21H
    LOOP PRINT_LOOP
    ;end_for
    
    ;restoring values of AX-DX
    POP DX 
    POP CX
    POP BX
    POP AX
    
    RET
    OUTDEC ENDP 
         
END MAIN