assume cs:code

code segment
start:  mov ax,4240H
        mov dx,000FH
        mov cx,0AH
        call divdw
        mov ax,4c00H
        int 21H

; 除法运算
; 参数: (ax)=dword型数据的低16位
;       (dx)=dword型数据的高16位
;       (cx)=除数
; 返回: (dx)=结果的高16位, (ax)=结果的低16位
;       (cx)=余数
divdw:  push bx
        push ax
        mov ax,dx
        mov dx,0
        div cx
        mov bx,ax
        pop ax
        div cx
        mov cx,dx
        mov dx,bx
        pop bx
        ret
code ends
end start
