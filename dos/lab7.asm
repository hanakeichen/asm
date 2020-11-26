assume cs:codesg

data segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    ; 21个年份
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ; 21年总收入
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,45257,17800 
    ; 21年员工
data ends

table segment
    db 21 dup ('year summ ne ?? ')
table ends

stack segment
    dw 8 dup (0)
stack ends

codesg segment
start:
    mov ax,data
    mov ds,ax
    mov ax,table
    mov es,ax
    mov ax,stack
    mov ss,ax
    mov sp,8
    mov bx,0
    mov si,0
    mov di,0
    mov cx,21
s:  mov ax,ds:[si]
    mov es:[bx],ax                          ; 年份
    mov ax,ds:[si][2]
    mov es:[bx].2,ax                        ; 年份
    mov ax,ds:[84][si][0]                    ; 收入
    mov dx,ds:[84][si][2]                    ; 收入
    mov es:[bx].5,ax                        ; 收入
    mov es:[bx].7,dx                        ; 收入
    push ds:[168][di]
    pop es:[bx+10]                          ; 保存雇员
    div word ptr es:[bx+10]                                 ; 人均收入
    mov es:[bx+13],ax
    add bx,16
    add si,4
    add di,2
    loop s
    mov ax,4c00H
    int 21H
codesg ends
end start
