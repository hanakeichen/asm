;实验16
assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset int7ch
        mov ax,0
        mov es,ax
        mov di,200H
        mov cx,offset sub3_end-offset int7ch
        cld
        rep movsw
       
        cli
        mov word ptr es:[7cH*4],200H
        mov word ptr es:[7cH*4+2],0
        sti
        
        mov ax,4c00H
        int 21H

; int 7ch中断
; 参数: (ah)=0(清屏)/1(设置前景色)/2(设置背景色)/3(向上滚动1行)
;       (al)=0/1/2/3/4/5/6/7 用作1/2功能设置颜色
; 返回: 无
int7ch:     jmp short int7ch_s
table       dw offset sub0-offset int7ch
            dw offset sub1-offset int7ch
            dw offset sub2-offset int7ch
            dw offset sub3-offset int7ch
int7ch_s:   push bx
            mov bl,ah
            mov bh,0
            add bx,bx
            mov bx,cs:[200H+2+bx]
            add bx,200H
            call bx
            pop bx
            iret

sub0:   push ax
        push cx
        push ds
        push si
        mov ax,0B800H
        mov ds,ax
        mov si,0
        mov cx,24*160
sub0_c: mov byte ptr ds:[si],' '
        mov byte ptr ds:[si+1],0
        add si,2
        loop sub0_c
        pop si
        pop ds
        pop cx
        pop ax
        ret

sub1:   push ax
        push bx
        push cx
        push ds
        mov bx,0B800H
        mov ds,bx
        mov bx,1
        mov cx,24*80
sub1_s: and byte ptr ds:[bx],11111000B
        or ds:[bx],al
        add bx,2
        loop sub1_s
        pop ds
        pop cx
        pop bx
        pop ax
        ret

sub2:   push ax
        push bx
        push cx
        push ds
        mov bx,0B800H
        mov ds,bx
        mov bx,1
        mov cx,24*80
        shl al,1
        shl al,1
        shl al,1
        shl al,1
sub2_s: and byte ptr ds:[bx],10001111B
        or ds:[bx],al
        add bx,2
        loop sub2_s
        pop ds
        pop cx
        pop bx
        pop ax
        ret

sub3:   push ax
        push cx
        push ds
        push es
        push si
        push di
        mov bx,0B800H
        mov ds,bx
        mov es,bx
        mov si,160
        mov di,0
        mov cx,24
        cld
cp_s:   push cx
        mov cx,80
        rep movsw
        pop cx
        loop cp_s
        mov cx,80
        mov si,0
sub3_s: mov byte ptr ds:[160*24+si],' '
        add si,2
        loop sub3_s
        pop di
        pop si
        pop es
        pop ds
        pop cx
        pop ax
        ret
sub3_end: nop
code ends
end start
