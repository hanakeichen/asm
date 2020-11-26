assume cs:code
a segment
    db 1,2,3,4,5,6,7,8
a ends
b segment
    db 1,2,3,4,5,6,7,8
b ends

c segment
    db 0,0,0,0,0,0,0,0
c ends

code segment
start:
        mov ax,a
        mov ss,ax
        mov sp,0
        mov ax,b
        mov ds,ax
        mov ax,c
        mov es,ax
        mov cx,8
        mov bx,0
s:      pop ax
        add ax,ds:[bx]
        mov es:[bx],ax
        add bx,2
        loop s
        mov ax,4c00H
        int 21H
code ends
end start
