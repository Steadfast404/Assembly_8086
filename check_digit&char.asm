;program takes a character as an input
;If it is a letter, displays it on the next line.
;If it is a digit, checks whether it is even or odd.
;For an even digit, subtracts 1 from it and displays it on the next line. 
;For an odd digit, adds 1 to it and displays it on the next line.

INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
   INPUT DB ?
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    PRINT "ENTER A CHARACTER:"
    MOV AH,1
    INT 21H
    MOV INPUT,AL
    
    PRINTN
    
    SUB INPUT,48
    
    CMP INPUT,0
    JB EXIT
    CMP INPUT,9
    JA DISPLAY   ;INPUT IS A CHARACTER
    
    MOV BL,INPUT
    SHR BL,1
    JC ODD
    
    SUB INPUT,1
    JMP DISPLAY
    
    ODD:
    ADD INPUT,1
    JMP DISPLAY
    
    DISPLAY:
    ADD INPUT,48
    MOV AH,2
    MOV DL,INPUT
    INT 21H
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN