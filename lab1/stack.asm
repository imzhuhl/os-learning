mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; if the stack is empty then sp points to bp

push 'A'
push 'B'
push 'C'

mov al, [0x7ffe]  ; first character, 'A'
int 0x10

push 'D'

mov al, [0x7ffc]  ; second character, 'B'
int 0x10


; recover our characters using the standard procedure: 'pop'
; We can only pop full words so we need an auxiliary register to manipulate
; the lower byte

mov al, '1'
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10



jmp $
times 510-($-$$) db 0
dw 0xaa55
