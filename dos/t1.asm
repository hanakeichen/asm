assume cs:codeseg
codeseg segment

    mov ax,2000H        ; ax=2000H
    mov ss,ax           ; ss=2000H
    mov sp,0            ; sp=0
    add sp,4            ; sp=4
    pop ax              ; ax=0, sp=6
    pop bx              ; bx=0, sp=8
    push ax             ; ax=0, sp=6
    push bx             ; bx=0, sp=4
    pop ax              ; ax=0, sp=6
    pop bx              ; bx=0, sp=8
    mov ax,4c00H        ; ax=4c00H
    int 21H

codeseg ends

end
