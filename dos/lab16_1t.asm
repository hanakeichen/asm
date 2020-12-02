;实验16设置前景色测试
assume cs:code

code segment
start:  mov ah,1
        mov al,2
        int 7ch
        mov ax,4c00H
        int 21H
code ends
end start
