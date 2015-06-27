;This program convert num_string to dec and show hex on screen
;@Author: 
;@Time:


.386
STACK SEGMENT USE16 STACK
DB 200 DUP(0)
STACK ENDS

DATA SEGMENT USE16
IN_TIP  DB 'Input number less than five and ended with . .' , 0DH, 0AH, '>>' , '$' ;input tips
IN_BUF  DB 10
        DB 0
        DB 10 DUP(0)                      ;input buffer
CREF    DB 0DH, 0AH, '$'                  ;enter-new_line key
OUT_TIP DB 'The number in hex>> ', '$'    ;output tips
DATA ENDS

CODE SEGMENT USE16
        ASSUME CS:CODE, DS:DATA, SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX
    
    CALL SHOW       ;show the input tips
    CALL GET_NUM    ;accept the string

    LEA BX, IN_BUF+2  ;get the offset address of string buffer
    CALL UATOI        ;convert string to dec
    CALL DEC_SHOW     ;show the converted number in hex 
    
    CALL GET_NUM  ;delay the screen existing.
   
    MOV AH, 4CH
    INT 21H
    
    

;@Function: print the tips
;@Parameter:no
;@Output:no
SHOW PROC
    LEA DX, IN_TIP  ;get the offset address of tips for INT21 
    MOV AH, 9
    INT 21H
    RET
SHOW ENDP

;@Function: get inputs
;@Parameter:no
;@Output:no
GET_NUM PROC
    LEA  DX, IN_BUF   ;get the offsset address of buffer
    MOV AH, 10
    INT 21H
    LEA DX, CREF
    MOV AH, 9
    INT 21H
    RET
GET_NUM ENDP


;@Function: convert string to unsigned interger;And the length of string is less than six
;@Parameter: BX(offset address of the string)
;@Output: AX(store the number)
;@Borrow: CX

UATOI PROC
	PUSH CX
	MOV AX, 0H
	MOV CH, 0H
UNTIL$:
    CMP [BX], BYTE PTR '.'  ;when the char is '.', end
    JZ END$
    
    MOV CL, 0AH
    MUL CL                  ;multiple
    MOV CL, [BX]
    SUB CL, 30H
    ADD AX, CX
    INC BX
    JMP UNTIL$
END$:
	POP CX
	RET
UATOI ENDP

;Funcktion: print converted number in decimal
;@Patameter: AX(which showed)
;@Output: no
;@Borrow: DX
DEC_SHOW PROC
	PUSH DX
	
	PUSH AX
    LEA DX, OUT_TIP
    MOV AH, 9
    INT 21H	           ;Output tips
    POP AX
    
    MOV DL, AH
    SHR DL, 4
    CALL JUDGE_CHAR
    
    MOV DL, AH
    AND DL, 00001111B
    CALL JUDGE_CHAR
    
    MOV DL, AL
    SHR DL, 4
    CALL JUDGE_CHAR
    
    MOV DL, AL
    AND DL, 00001111B
    CALL JUDGE_CHAR
    
    MOV DL, 'H'
    MOV AH, 2
    INT 21H
	
	LEA DX, CREF
	MOV AH, 9
	INT 21H
	
	POP DX
	RET
DEC_SHOW ENDP

;@Function: print character
;@Parameter: DL(decimal's binary)
;@Output:no
JUDGE_CHAR PROC
	PUSH AX
    CMP DL, BYTE PTR 9  ;(DL)>9, turn to GTA
    JG GTA
    ADD DL, 30H
    JMP EXIT
GTA:
	ADD DL, 37H
EXIT:
    MOV AH, 2
    INT 21H
	POP AX
	RET
JUDGE_CHAR ENDP

CODE ENDS
    END START