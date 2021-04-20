.MODEL SMALL
.STACK 100H
.DATA

STRING DB 'milan', '$'
VOW DW 0

.CODE
 
MOV AX, @DATA                   ; Load data segment
MOV DS, AX

MOV SI, OFFSET STRING           ; load starting addr of string
MOV DI, 00H

LOOP1 :
    MOV AX, [SI]                ; check value
    CMP AL, '$'                 ; if end of string
    JE RESULT

	CMP AL, 'a'
	JE VOWEL
	CMP AL, 'e'
	JE VOWEL
	CMP AL, 'i'
	JE VOWEL
	CMP AL, 'o'
	JE VOWEL
	CMP AL, 'u'
	JE VOWEL

    JMP AFTER

    VOWEL: 
        MOV DX, VOW
        INC DX
        MOV VOW, DX

    AFTER:
        INC SI                  ; else increment to next element in string
        JMP LOOP1

RESULT:
    MOV AH, 2
    MOV DX, VOW
    ADD DX, 30H
    INT 21H

MOV AH, 4CH
INT 21H

END