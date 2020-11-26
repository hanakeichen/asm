assume cs:code

data segment
    dw 123,12666,1,8,3,38
data ends

str segment
    db 6 dup (0)
str ends

code segment
start:  mov ax,data
        mov es,ax
        mov ax,str
        mov ds,ax
        mov cx,6
        mov si,0
        mov dh,8
        mov dl,4
show:   mov ax,es:[si]
        call dtoc
        push cx
        mov cl,2H
        call show_str
        add si,2
        pop cx
        loop show
        mov ax,4c00H
        int 21H

; word数值转为字符串
; 参数: (ax)=需要转换的数值
;      ds:si指向字符串的首地址
; 返回: 无
dtoc:   push bx
        push dx
        push cx
        push si
        push ax

        mov bx,10
        mov dx,0
        mov si,0

s:      div bx
        mov cx,ax
        add dl,30H
        push dx
        mov dx,0
        inc si
        jcxz ok
        jmp s

ok:     mov cx,si
        mov si,0
s0:     pop dx
        mov ds:[si],dl
        inc si
        loop s0

        mov byte ptr ds:[si],0
        pop ax
        pop si
        pop cx
        pop dx
        pop bx
        ret

; 指定的位置使用指定的颜色显示用0结尾的字符串
; 参数: (dh)=行号(0~24)   (dl)=列号(0~79)
;       (cl)=颜色, ds:si 指向字符串的首地址
show_str:   push ax
            push cx
            push si
            push es
            push di
            mov ax,0B800H
            mov es,ax
            mov ah,0
            mov al,160
            mul dh
            mov di,ax
            mov ah,0
            mov al,dl
            add di,ax
            mov al,cl
            mov ch,0
            mov si,0
sh:         mov cl,ds:[si]
            jcxz ok_1
            mov es:[di],cl
            mov es:[di+1],al
            inc si
            add di,2
            jmp sh
ok_1:       mov cl,al
            pop di
            pop es
            pop si
            pop cx
            pop ax
            ret
code ends
end start

