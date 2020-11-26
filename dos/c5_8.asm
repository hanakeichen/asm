assume cs:code_seg

code_seg segment

    mov ax,0ffffH
    mov ds,ax
    mov cx,6H
    mov dx,20H
    mov ax,0
    mov ss,ax

s:  mov bx,dx
    mov ax,ds:[bx]
    add bx,200H
    mov ss:[bx],ax
    inc dx
    inc dx
    loop s

    mov ax,4c00H
    int 21H

code_seg ends
end
