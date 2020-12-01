;实验14
assume cs:code

code segment
start:  mov ax,0B800H
        mov ds,ax
        mov si,160*12+2*30
        mov al,9    ;年
        call readt
        mov [si],ah
        mov [si+2],al
        mov byte ptr [si+4],'/'
        mov al,8    ;月
        call readt
        mov [si+6],ah
        mov [si+8],al
        mov byte ptr [si+10],'/'
        mov al,7    ;日
        call readt
        mov [si+12],ah
        mov [si+14],al
        mov byte ptr [si+16],' '

        mov al,4    ;时
        call readt
        mov [si+18],ah
        mov [si+20],al
        mov byte ptr [si+22],':'
        mov al,2    ;分
        call readt
        mov [si+24],ah
        mov [si+26],al
        mov byte ptr [si+28],':'
        mov al,0    ;秒
        call readt
        mov [si+30],ah
        mov [si+32],al
    
        mov ax,4c00H
        int 21H
; 读取CMOS RAM，返回十进制字符串
; 参数: (al)=单元
; 返回: (ah)=十位 (al)=个位
readt:  out 70H,al
        in al,71H
        call bcd2c
        ret

; bcd码转为字符串
; 参数: (al)=bcd码
; 返回: (ah)=十位 (al)=个位
bcd2c:  push cx
        mov ah,al
        mov cl,4
        shr ah,cl
        add ah,30H
        and al,1111B
        add al,30H
        pop cx
        ret
code ends
end start
