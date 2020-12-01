; 检测点13
; (1) 0x8000~0x7fff

; (2)
assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset j_s
        mov ax,0
        mov es,ax
        mov di,200H
        mov cx,offset j_s_end-offset j_s
        cld
        rep movsb
        
        mov ax,0
        mov es,ax
        mov word ptr es:[7cH*4],200H
        mov word ptr es:[7cH*4+2],0
        mov ax,4c00H
        int 21H

j_s:    push bp
        mov ax,sp
        mov bp,ax
        add ss:[bp+2],bx
        pop bp
        iret
j_s_end: nop
code ends
end start
