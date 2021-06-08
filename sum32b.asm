display macro output
    xor cx,cx
    mov ax, output
    call print
endm

.model small
.stack 100
.data
   num1 dd 23654312h
   num2 dd 12543265h
   cons dw 10h
   res  dw 02 dup(00)
.code
     
    main proc far  
        mov ax, @data           ; initializing data segment
        mov ds, ax
        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx

        mov ax, word ptr num1   
        mov bx, word ptr num1+2 

        mov cx, word ptr num2   
        mov dx, word ptr num2+2 

        add ax, cx
        daa
        mov word ptr res, ax    
        mov ax, bx
        adc ax, dx              
        
        mov word ptr res+2, ax  
        
        display res+2
        display res
        mov ah , 4ch            
        int 21h 
	main endp

	print proc
        mov bx,00h
        lab:    
            cmp ax, 00h
            je disp1
            xor dx, dx   
            div cons
            add dx, bx
            mov bx, 00h
            inc cx
            cmp dx, 10
            jl nextlab
            mov bx, 01h
            nextlab: 
                push dx
            jmp lab
        disp1:  
            disp:
            pop dx
            add dx, 00h
            next:   
            cmp dx, 10
            jl continue
            sub dx, 0ah
            continue: 
                add dx, 30h
                mov ah, 02h
                int 21h
            loop disp1
        ret
    print endp

    end main