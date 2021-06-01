.model small
.stack 100h
.data
   list db 1,2,3,4,5,6,7,8,9
   len dw 9
.code
main proc
	mov ax,@data
	mov ds,ax

	lea si,list

	mov al, [si+3]
	mov bl, [si+1]
	mov [si+1], al
	mov [si+3], bl
	mov bl, [si+2]
	mov al, [si+6]
	mov [si+2], al
	mov [si+6], bl
	mov bl, [si+5]
	mov al, [si+7]
	mov [si+5], al
	mov [si+7], bl

	mov cx, len
	l1:
		mov dx,[si]
		add dx,30h
		mov ah,02h
		int 21h
		inc si
		loop l1

	mov ah,4ch
	int 21h
	main endp
end