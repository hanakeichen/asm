; 检测点11.4

; (ax)=01000101B

assume cs:code

code segment
start:  mov ax,0
        push ax
        popf
        mov ax,0fff0H
        add ax,0010H
        pushf
        pop ax
        and al,11000101B
        and ah,00001000B
        mov ax,4c00H
        int 21H
code ends
end start
