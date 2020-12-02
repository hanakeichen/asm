;实验16 设置背景色测试
assume cs:code

code segment
start:  mov ah,2
        mov al,1
        int 7ch
        mov ax,4c00H
        int 21H
code ends
end start
