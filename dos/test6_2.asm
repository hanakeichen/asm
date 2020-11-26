assume cs:code_seg

code_seg segment
    dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
    dw 0,0,0,0,0    ; 5个字单元用作栈空间
start:  mov ax,cs
        mov ss,ax
        mov sp,26
        mov ax,0
        mov ds,ax
        mov bx,0
        mov cx,8
s:      push ds:[bx]
        pop cs:[bx]
        add bx,2
        loop s
        mov ax,4c00H
        int 21H

code_seg ends
end start
