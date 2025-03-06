INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    MOV DL,50
    MOV CX,4
    MOV AH,02H
    FOR:
        INT 21H
        PRINT " "
        ADD DL,2
    LOOP FOR
    
    EXIT:
         MOV AH,4CH
         INT 21H
         MAIN ENDP
END MAIN