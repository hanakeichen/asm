; 实验13(1)
assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset show_str
        mov ax,0
        mov es,ax
        mov di,200H
        mov cx,offset show_str_end-offset show_str
        cld
        rep movsb

        mov word ptr es:[7cH*4],200H
        mov word ptr es:[7cH*4+2],0
        mov ax,4c00H
        int 21H

; 显示0结束的字符串
; 参数：(dh)=行号 (dl)=列号 (cl)=颜色
;       ds:si指向字符串首地址
; 返回：无
show_str:   push ax
            push es
            push si
            push di
            mov ax,0B800H
            mov es,ax
            mov ax,160
            mul dh
            mov di,ax
            mov ax,2
            mul dl
            add di,ax
            mov al,cl
scr_s:      mov cl,ds:[si]
            jcxz ok
            mov es:[di],cl
            mov es:[di+1],al
            inc si
            add di,2
            jmp short scr_s
ok:         mov cl,al
            pop di
            pop si
            pop es
            pop ax
            iret
show_str_end: nop
code ends
end start
