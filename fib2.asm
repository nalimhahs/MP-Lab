.MODEL SMALL
.STACK 100H
.DATA

COUNT EQU 05H

.CODE

MOV AX, @DATA                   
MOV DS, AX

MOV AL, 00H
MOV BL, 00H
MOV CL, 01H

MOV DX, [BL]
MOV AH, 02H
ADD DX, 30H
INT 21H

LOOP1:     
	CMP AL, COUNT
	JE  EXIT

	MOV DX, CL
	ADD DX, 30H
	MOV AH, 02H
	INT 21H

	MOV BH, CL
	ADD CL, BL
	MOV BL, BH

	INC AL
	JMP LOOP1

EXIT:     
    MOV AH, 4CH
    INT 21H

END 