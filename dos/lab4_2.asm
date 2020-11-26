assume cs:code_seg

code_seg segment

    mov ax,20H
    mov ds,ax
    mov bx,0
    mov cx,64

s:  mov [bx],bl
    inc bx
    loop s

    mov ax,4c00H
    int 21H

code_seg ends
end
