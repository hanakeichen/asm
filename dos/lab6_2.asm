assume cs:codesg,ss:stacksg,ds:datasg

stacksg segment
    dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
datasg ends

codesg segment
start:
    mov ax,datasg
    mov ds,ax
    mov ax,stacksg
    mov ss,ax
    mov sp,8
    mov cx,4
    mov bx,0
s:  push cx
    mov cx,4
    mov si,0
s0: mov al,ds:[bx+si+3]
    and al,11011111B
    mov ds:[bx+si+3],al
    inc si
    loop s0
    pop cx
    add bx,16
    loop s
    mov ax,4c00H
    int 21H 
codesg ends
end start
