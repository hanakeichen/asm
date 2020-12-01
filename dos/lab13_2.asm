; 实验13(2)
assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset loop_s
        mov ax,0
        mov es,ax
        mov di,200H
        mov cx,offset loop_s_end-offset loop_s
        cld
        rep movsb

        mov word ptr es:[7cH*4],200H
        mov word ptr es:[7cH*4+2],0
        mov ax,4c00H
        int 21H

; 完成loop指令的功能
; 参数：(cx)=循环次数   (bx)=位移
loop_s: push bp
        dec cx
        jcxz ok
        mov bp,sp
        add [bp+2],bx
ok:     pop bp
        iret
loop_s_end: nop
code ends
end start
