.MODEL SMALL
.STACK 100H
.DATA

STRING DB 'milim', '$'
ISPAL DB 'String is palindrome', '$'
NOTPAL DB 'String is not palindrome', '$'

.CODE
 
MOV AX, @DATA               ; Load data segment
MOV DS, AX

MOV SI, OFFSET STRING       ; load starting addr of string

LOOP1 :
    MOV AX, [SI]            ; check value
    CMP AL, '$'             ; if end of string
    JE LABEL1               ; goto palindrome checking
    INC SI                  ; else increment to next element in string
    JMP LOOP1

LABEL1 :
    MOV DI,OFFSET STRING    ; load starting addr to diff var
    DEC SI                  ; reduce length to ignore terminating char

LOOP2 :
    CMP SI, DI              ; check if inc and dec counters are same
    JL OUTPUT1              ; if yes it is palindrome
    MOV AX,[SI]             ; load character at SI to reg
    MOV BX, [DI]            ; load character at DI to reg
    CMP AL, BL              ; compare both 
    JNE OUTPUT2             ; if NOT same then not palindrome

    DEC SI                  ; Update counters
    INC DI                  ; "  
    JMP LOOP2               ; repeat till entire string covered

OUTPUT1:
    LEA DX, ISPAL           ; Get addr of display string
    MOV AH, 09H             ; Load display string
    INT 21H                 ; Interrupt to display
    JMP EXIT

OUTPUT2:
    LEA DX, NOTPAL
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

END