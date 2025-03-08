;A=4XB-3XA WHERE THE INITIAL VALUE OF A=1 AND B=2 USE IMUL FOR MULTIPLICATION
include 'emu8086.inc'

.model small
.stack 100h

.data
  a db 1
  b db 2

.code
main proc 
  mov ax,@data
  mov ds,ax
  
  mov al,a
  mov bl,3
  imul bl
  
  mov cl,al
  
  mov al,b 
  mov bl,4
  imul bl
    
  sub al,cl 
  
  mov dl,al
  add dl,30h
  mov ah,02h
  int 21h
    
  exit:
  mov ah,4ch
  int 21h  
    
main endp  
end main 