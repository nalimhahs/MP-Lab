textprint macro msg
    lea dx, msg
    mov ah, 09h
    int 21h
endm

print macro num
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

calcsum macro 
    MOV CX, count
    LEA BX, array
    MOV AX, 00
    L1: 
        ADD AX, WORD PTR[BX]
        ADD BX, 02
        DEC CX
        CMP CX, 00
        JNZ L1
    mov sum, ax
endm

.MODEL SMALL
.STACK 100H
.DATA
    array dw 2999, 2999, 2999
    count dw 3
    msg1 db 10,13,'SUM = $'
    sum dw 0

.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX

    textprint msg1
    calcsum 
    print sum

    MOV AH, 4CH 
    INT 21H

MAIN ENDP

END MAIN
