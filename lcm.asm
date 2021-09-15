textprint macro msg
    lea dx, msg
    mov ah, 09h
    int 21h
endm

print macro num
    local label1, print1, exit
    mov ax, num
    mov cx, 0 
    mov dx, 0 

    label1:
        cmp ax, 0 
        je print1
        mov bx, 10
        div bx
        push dx
        inc cx
        xor dx, dx
        jmp label1

    print1:
        cmp cx, 0 
        je exit
        pop dx
        add dx, 48
        mov ah, 02h 
        int 21h
        dec cx
        jmp print1

    exit:
        nop
endm

.MODEL SMALL
.STACK 100H
.DATA
    d1 dw 16 
    d2 dw 24
    msg1 db 10,13,'The GCF = $'
    msg2 db 10,13,'The LCM = $'
    lcm dw 0
    gcf dw 0

.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX
    mov bx, d2
    mov ax, d1

    textprint msg1
    call gcd
    mov ax, cx
    mov gcf, ax
    print gcf

    textprint msg2
    mov ax, d1
    mul d2
    div gcf
    mov lcm, ax
    print lcm

    MOV AH, 4CH 
    INT 21H

MAIN ENDP


GCD PROC
    cmp bx, 0 
    jne continue

    mov cx, ax
    ret

    continue:
        xor dx, dx
        div bx
        mov ax, bx
        mov bx, dx
        call GCD
        ret
GCD ENDP

END MAIN