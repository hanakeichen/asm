; 实验15

assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset int9
        mov ax,0
        mov es,ax
        mov di,200H
        mov cx,offset int9end-offset int9
        cld
        rep movsb   ; 存储int9

        mov ax,es:[9*4]
        mov es:[200H+2],ax
        mov ax,es:[9*4+2]
        mov es:[200H+4],ax   ;保存原始int9
        
        cli
        mov word ptr es:[9*4],200H
        mov word ptr es:[9*4+2],0    ; 设置新的int9
        sti

        mov ax,4c00H
        int 21H

int9:   jmp short int9s
        dw 0,0
int9s:  push ax
        push bx
        push cx
        push es
        in al,60H
        pushf
        call dword ptr cs:[200H+2]
        cmp al,1EH+80H  ; A通码+80H
        jne int9r
        mov ax,0B800H
        mov es,ax
        mov bx,0
        mov cx,2000
show_a: mov byte ptr es:[bx],'A'
        add bx,2
        loop show_a
int9r:  pop es
        pop cx
        pop bx
        pop ax
        iret
int9end:nop
code ends
end start
