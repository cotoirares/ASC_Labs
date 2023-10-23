bits 32
global start        

extern exit            
import exit msvcrt.dll   

segment data use32 class=data
    a db 1
    b db 1
    c db 1
    d db 1
    e db 2


segment code use32 class=code
    start:
         ; [(a-d)+b]*2/c
        mov AX, [a]
        sub AX, [d]
        add AX, [b]
        mov DX, 0
        mul byte [e]
        div byte [c]
        push    dword 0     
        call    [exit]    
