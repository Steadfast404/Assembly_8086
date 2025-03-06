INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    PRINT "ENTER 1ST DIGIT:"
    MOV AH,01
    INT 21H
    MOV BL,AL
    PRINTN
    
    PRINT "ENTER 2ND DIGIT:"
    MOV AH,01
    INT 21H
    MOV BH,AL
    PRINTN
    
    
    PRINTN "IN ASCENDING ORDER :"
    CMP BL,BH
    JLE INORDER
    
    MOV AH,02
    
    MOV DL,BH
    INT 21H
    PRINTN
    
    MOV DL,BL
    INT 21H
    JMP EXIT
    
    INORDER:

    MOV AH,02
            
    MOV DL,BL 
    INT 21H
    PRINTN
            
    MOV DL,BH
    INT 21H
          
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN