assume cs:code

data segment
    db 'hello world',0
data ends

code segment
start:      mov dh,8
            mov dl,4
            mov cl,2
            mov ax,data
            mov ds,ax
            mov si,0
            call show_str   ; 8行3列显示一个字符串
            
            mov ax,4c00H
            int 21H

; 指定的位置用指定的颜色显示一个用0结束的字符串
; 参数: (dh)=行号   (dl)=列号   (cl)=颜色   (ds:si)指向字符串的首地址
; 返回无
show_str:   push si
            push ax
            push es
            push di
            push cx
            mov ax,0B800H
            mov es,ax
            mov al,160
            mov ah,0
            mul dh
            mov di,ax
            mov ah,0
            mov al,dl
            add di,ax
            mov ah,cl
s:          mov cl,ds:[si]
            jcxz ok
            mov byte ptr es:[di],cl
            mov es:[di+1],ah
            add di,2
            inc si
            jmp s
ok:         pop cx
            pop di
            pop es
            pop ax
            pop si
            ret 
code ends
end start
