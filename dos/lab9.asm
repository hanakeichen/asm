assume cs:code

data segment
    db 00000010B    ; 绿色
    db 00100100B    ; 绿底白色
    db 01110001B    ; 白底蓝色
    db 'welcome to masm'
data ends

stack segment
    dw 0,0
stack ends

code segment
start:  mov ax,0B800H
        mov ds,ax
        mov ax,data
        mov es,ax
        mov ax,stack
        mov ss,ax
        mov sp,4
        mov cx,3
        mov bx,8c0H
        mov ax,0
s:      push cx
        mov cx,15
        mov si,0
        mov di,60
s0:     mov dl,es:[3][si]
        mov [bx][di],dl
        push si
        mov si,ax
        mov dl,es:[si]
        mov [bx][di+1],dl
        pop si
        inc si
        add di,2
        loop s0
        pop cx
        inc ax
        add bx,160
        loop s
        mov ax,4c00H
        int 21H 
code ends
end start
