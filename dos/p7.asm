assume cs:code_seg

code_seg segment

    mov ax,0
    mov ds,ax
    mov ds:[26H],ax
    mov ax,4c00H
    int 21H

code_seg ends
end
