;PROGRAM WILL TAKE A DIGIT AS INPUT, AND PRINT IT'S CORRESPONDING BINARY VALUE  
INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
     INPUT DB ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    PRINT "ENTER A HEX DIGIT (0-F):" 
    
    MOV AH,01H
    INT 21H
    MOV INPUT,AL
    
    CMP INPUT, '0'
    JL SHOW_ERROR
    CMP INPUT, '9'
    JG LETTER
    
    AND INPUT,0FH
    JMP INITIALIZE
    
    LETTER:
    CMP INPUT, 'A'
    JL SHOW_ERROR
    SUB INPUT, 55
    JMP INITIALIZE
    
    SHOW_ERROR:
    PRINTN "NOT A VALID INPUT $"
    JMP EXIT
    
    INITIALIZE:
    XOR CX,CX
    MOV CL,8
    
    PRINTN
    PRINT "IN BINARY: "
    
    PRINT_BINARY:
    ROL INPUT,1
    JC PRINT_1
    
    PRINT "0"
    JMP CONDITION
    
    PRINT_1:
    PRINT "1"
    
    CONDITION:
    LOOP PRINT_BINARY
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN