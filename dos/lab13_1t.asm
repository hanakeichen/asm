; lab13 (1)测试
assume cs:code
data segment
    db 'Welcome to masm!',0
data ends

code segment
start:  mov dh,10
        mov dl,30
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        int 7ch
        mov ax,4c00H
        int 21H
code ends
end start
