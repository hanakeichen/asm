; 实验11

assume cs:code

data segment
    db "Beginner's All-purpose Symblic Instruction Code.",0
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov si,0
        call letterc
        mov ax,4c00H
        int 21H

; 将包含任意字符，以0结尾的字符串的任意小写字母转变为大写字母
; 参数: ds:si 指向字符串首地址
; 返回: 无
letterc:    push si
            mov ch,0
s:          mov cl,[si]
            jcxz up_ok
            cmp cl,'a'
            jnb l_ok
            inc si
            jmp s
l_ok:       cmp cl,'z'
            jna h_ok
            inc si
            jmp s
h_ok:       sub cl,20H
            mov [si],cl
            inc si
            jmp s
up_ok:      pop si
            ret
code ends
end start
