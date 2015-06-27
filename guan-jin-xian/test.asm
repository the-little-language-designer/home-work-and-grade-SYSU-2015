DATAS SEGMENT
mess db 0dh,0ah
     db 'Input letter is wrong!Please Input a lowercase'
     db 0dh,0ah,'$' 
DATAS ENDS

STACKS SEGMENT
    byte 64 dup(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    cmpl:   
        mov ah,1
        int 21h
        cmp al,0dh
        je  exit
        cmp al,'a'
        jb  disp
        cmp al,'z'
        ja  disp
        mov bl,'z'
        sub bl,al
        add bl,'a'
        mov dl,20h
        int 21h
        mov dl,bl
        int 21h
again:
        mov ah,2
        mov dl,13
        int 21h
        mov dl,10
        int 21h
        jmp cmpl
disp:
        mov dx,offset mess
        mov ah,09h
        int 21h
        jmp cmpl
exit:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
