bits 32 
global start        

extern exit          
import exit msvcrt.dll  

section data use32 class=data
     a dw 20
     b db 1
     c db 90
     e dd 20
     x dq 20

section code use32 class=code
    start:
        ; computing a*b-(100-c)/(b*b)+e+x; where a-word; b and c-byte; e-doubleword; x-quadword
        mov EAX, 0
        mov EDX, 0
        
        ; a*b (signed)
        mov AX, [a]
        mov AL, [b]
        imul AL ; AL * [a]
        
        push dword EAX ; a*b
        
        ; 100-c (signed)
        mov AL, [c]
        sub 100 ; 100 - [c]
        adc AH, 0 ; carry flag
        
        push dword EAX ; 100-c
        
        ; b*b (signed)
        mov AL, [b]
        imul AL ; AL * [b]
        
        push dword EAX ; b*b

        pop EBX ; b*b
        pop EAX ; 100-c
        idiv EBX ; (100-c)/(b*b)
        
        push dword EAX ; (100-c)/(b*b)
        
        pop EBX ; (100-c)/(b*b)
        pop EAX ; a*b
        sub EAX, EBX ; a*b - (100-c)/(b*b)
        add EAX, [e] ; a*b - (100-c)/(b*b) + e
        
        ; a*b - (100-c)/(b*b) + e + x
        add EAX, [x]
        
        ; exit
        push    dword 0   
        call    [exit]       
