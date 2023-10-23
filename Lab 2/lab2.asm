bits 32 ; 
global start        


extern exit              
import exit msvcrt.dll    

segment data use32 class=data
   a db 1
   c db 1
   d db 1
   f dw 1

   
segment code use32 class=code
    start:
        mov AX, [c]
        sub AX, 2
        mov CX, AX
        mov AX, [a]
        add AX, 3
        mul CX
        mov BX, [d]
        sub BX, 4
        div BX
        add AX, [f]
    
        push    dword 0   
        call    [exit]       
