; 课程设计1

assume cs:code

data segment
    db 11 dup (0)
    ; 21个年份
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ; 21年总收入
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ; 21年雇员
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,45257,17800
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov si,0
        mov di,0
        mov cx,21
        mov bl,30       ; 列数
        mov bh,2       ; 行数
s_scr:  push cx
        push bx
        mov ax,ds:[11+si]
        mov ds:[0],ax
        mov ax,ds:[11+si].2
        mov ds:[2],ax
        mov byte ptr ds:[4],0
        mov al,bh               ; 设置行数
        mov ch,bl               ; 设置列数
        mov cl,7                ; 设置字符属性
        push si
        mov si,0
        call show_str           ; 显示年份
        pop si
        add bl,22

        mov ax,ds:[95+si]          ; 95: 11+21*4
        mov dx,ds:[95+si].2
        push si
        mov si,0
        call dtoc               ; 转换收入字段为字符串到ds:si中
        mov al,bh
        mov ch,bl
        mov cl,7
        call show_str           ; 显示收入
        pop si
        add bl,22

        mov ax,ds:[179+di]
        push si
        mov si,0
        call wtoc               ; 转换雇员字段为字符串
        mov al,bh
        mov ch,bl
        mov cl,7
        call show_str           ; 显示雇员
        pop si
        add bl,22

        mov cx,ds:[179+di]
        mov ax,ds:[95+si]
        call divdw
        push si
        mov si,0
        call dtoc
        mov al,bh
        mov ch,bl
        mov cl,7
        call show_str
        pop si

        inc bh                  ; 增加行数
        pop ax                  ; 恢复行+列到ax中
        mov bl,al
        pop cx
        add si,4
        add di,2
        loop s_scr
        mov ax,9768H
        mov dx,5aH
        call dtoc
        mov ax,4c00H
        int 21H

; 将dword型数据转变为表示十进制数的字符串,以0结尾
; 参数: (ax)=dword的低16位
;       (dx)=dword的高16位
;       ds:si指向字符串的首地址
; 返回: 无
dtoc:   push ax
        push bx
        push dx
        push cx
        push si
        mov bx,0
s:      mov cx,10
        call divdw
        add cx,30H
        push cx
        inc bx
        mov cx,dx
        jcxz h_ok
        jmp s
h_ok:   mov cx,ax
        jcxz l_ok
        jmp s
l_ok:   mov cx,bx
fill:   pop bx
        mov ds:[si],bl
        inc si
        loop fill
        mov byte ptr ds:[si],0
        pop si
        pop cx
        pop dx
        pop bx
        pop ax
        ret

; 将word型数据转变为表示十进制数的字符串,以0结尾
; 参数: (ax)=word型数值
;       ds:si指向字符串的首地址
; 返回: 无
wtoc:   push ax
        push bx
        push cx
        push dx
        push di
        push si
        mov bx,10
        mov di,0
w_s:    mov dx,0
        div bx
        mov cx,ax
        add dx,30H
        push dx
        inc di
        jcxz w_ok
        jmp w_s
w_ok:   mov cx,di
w_fill: pop ax
        mov ds:[si],al
        inc si
        loop w_fill
        mov byte ptr ds:[si],0
        pop si
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        ret

; 除法运算，被除数dword，除数word，结果dword
; 参数: (ax)=被除数低16位
;       (dx)=被除数高16位
;       (cx)=除数
; 返回: (ax)=商低16位
;       (dx)=商高16位
;       (cx)=余数
divdw:  push bx
        mov bx,ax
        mov ax,dx
        mov dx,0
        div cx  ; (ax)=int(被除数高16位/cx) (dx)=rem(被除数高16位/cx)
        push ax
        mov ax,bx
        div cx
        mov cx,dx
        pop dx
        pop bx
        ret

; 显示字符串
; 参数: (al)=行数
;       (ch)=列数
;       (cl)=属性
;       ds:si 字符串的首地址，以0结尾
show_str:   push ax
            push bx
            push cx
            push si
            push es
            mov bl,al
            mov ax,0B800H
            mov es,ax
            mov al,bl
            mov ah,0
            mov bl,160
            mul bl
            mov bh,0
            mov bl,ch
            add bx,ax
            mov al,cl
            mov ch,0
show_s:     mov cl,ds:[si]
            jcxz show_ok
            mov es:[bx],cl
            mov es:[bx+1],al
            add bx,2
            inc si
            jmp show_s
show_ok:    pop es
            pop si
            pop cx
            pop bx
            pop ax
            ret
code ends
end start
