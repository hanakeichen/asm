;实验16 向上滚动1行测试
assume cs:code

code segment
start:  mov ah,3
        int 7ch
        mov ax,4c00H
        int 21H
code ends
end start
