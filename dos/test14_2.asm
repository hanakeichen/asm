; 检测点14.2
assume cs:code

code segment
start:  mov ax,2
        mov bx,ax
        shl ax,1
        mov cl,3
        shl bx,cl
        add ax,bx
        mov ax,4c00H
        int 21H
code ends
end start
