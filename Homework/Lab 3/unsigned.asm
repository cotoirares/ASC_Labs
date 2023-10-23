bits 32 
global start        

extern exit          
import exit msvcrt.dll  

section data use32 class=data
     a dw 1000
     b db 3
     c db 10
     e dd 20
     x dq 10990

section code use32 class=code
    start:
        ; computing a*b-(100-c)/(b*b)+e+x; where a-word; b and c-byte; e-doubleword; x-quadword
        mov EAX, 0
        mov EDX, 0
        mov EBX, 0

        ; a*b
        mov AX, [a]
        mov BL, [b]
        mul BL
        
        push dword EAX ; a*b
        mov EAX, 0
        ; 100-c
        mov AL, [c]
        mov EBX, 100
        sub EBX, EAX
        
        push dword EBX ; 100-c
        mov EBX, 0
        mov EAX, 0
        ; b*b
        mov AL, [b]
        mov BL, [b]
        mul BL
        
        push dword EAX ; b*b
        mov EAX, 0
        mov EBX, 0

        ; (100-c)/(b*b)
        pop EBX ; b*b
        pop EAX ; 100-c
        mov EDX, 0
        div EBX ; (100-c)/(b*b)
        
        push dword EAX ; (100-c)/(b*b)
        pop EBX ; (100-c)/(b*b)
        pop EAX ; a*b
        sub EAX, EBX ; a*b - (100-c)/(b*b)
        add EAX, [e] ; a*b - (100-c)/(b*b) + e
        
        ; a*b - (100-c)/(b*b) + e + x, X - qword
        add EAX, [x]
        adc EDX, [x+4]
        
        push    dword 0   
        call    [exit]       
