assume cs:code

stack segment
    db 64 dup (0)
stack ends

data segment
    dw 0,0
data ends

code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,64
        mov ax,data
        mov ds,ax

        mov ax,0
        mov es,ax
        mov ax,es:[9*4]
        mov ds:[0],ax
        mov ax,es:[9*4+2]
        mov ds:[2],ax       ; 保存原始int 9 cs:ip

        cli
        mov word ptr es:[9*4],offset int9
        mov es:[9*4+2],cs   ; 设置int 9
        sti

        mov ax,0B800H
        mov es,ax
        mov al,'a'
show_s: mov es:[160*12+40*2],al
        call delay
        inc al
        cmp al,'z'
        jna show_s

        cli
        mov ax,0
        mov es,ax
        mov ax,ds:[0]
        mov es:[9*4],ax
        mov ax,ds:[2]
        mov es:[9*4+2],ax   ; 恢复int 9
        sti

        mov ax,4c00H
        int 21H

delay:  push ax
        push dx
        mov ax,0
        mov dx,10H
delay_s:sub ax,1
        sbb dx,0
        cmp ax,0
        jne delay_s
        cmp dx,0
        jne delay_s
        pop dx
        pop ax
        ret

int9:   push ax
        push es
        in al,60H
        pushf
        call dword ptr ds:[0]
        cmp al,1
        jne int9ret
        mov ax,0B800H
        mov es,ax
        inc byte ptr es:[160*12+40*2+1]
int9ret:pop es
        pop ax
        iret
code ends
end start
