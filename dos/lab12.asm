; 实验12

assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov ax,0H
        mov es,ax
        mov si,offset do0
        mov di,200H
        cld
        mov cx,offset do0_end-offset do0
        rep movsb
        mov ax,0
        mov es,ax
        mov word ptr es:[0*4],200H  ; ip
        mov word ptr es:[0*4+2],0   ; cs
        mov ax,4c00H
        int 21H

do0:        jmp short do0_start
            db 'divide error!'
do0_start:  mov ax,0B800H
            mov es,ax
            mov ax,cs
            mov ds,ax
            mov cx,13
            mov si,202H
            mov di,12 * 160 + 36 * 2
do0_s:      mov al,ds:[si]
            mov es:[di],al
            inc si
            add di,2
            loop do0_s
            mov ax,4c00H
            int 21H
do0_end: nop
code ends
end start
