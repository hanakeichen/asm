;实验16 测试清屏
assume cs:code

code segment
start:  mov ah,0
        int 7ch
        mov ax,4c00H
        int 21H
code ends
end start
