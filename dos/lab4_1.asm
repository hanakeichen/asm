assume cs:code_seg

code_seg segment

    mov ax,0
    mov ds,ax
    mov bx,200H
    mov cx,40H

s:  mov ds:[bx],ax
    inc bx
    inc ax
    loop s

    mov ax,4c00H
    int 21H

code_seg ends
end
