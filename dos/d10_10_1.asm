assume cs:code

data segment
    dw 1,2,3,4,5,6,7,8
    dd 0,0,0,0,0,0,0,0
data ends

code segment
; 计算N^3
; 参数: (bx) N
; 结果: (dx:ax) N^3
cube:   mov ax,bx
        mul bx
        mul bx
        ret

start:  mov ax,data
        mov ds,ax
        mov cx,8
        mov si,0
        mov di,0
s:      mov bx,ds:[si]
        call cube
        mov ds:[16+di],ax
        mov ds:[16+di+2],dx
        add si,2
        add di,4
        loop s
        mov ax,4c00H
        int 21H
code ends
end start
