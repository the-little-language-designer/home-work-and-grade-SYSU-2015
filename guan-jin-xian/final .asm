DATAS  SEGMENT
    STRING  DB  'calculate X+Y+W=?,X=1,Y=2,Z=1',13,10,'$'
    X  DB    1
    Y  DB    2
    Z  DB    1
DATAS  ENDS

STACKS  SEGMENT
      DB  128 DUP (?)
STACKS  ENDS

CODES  SEGMENT
     ASSUME    CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    LEA  DX,STRING
    MOV  AH,9
    INT  21H
    MOV AL,X
    ADD AL,Y 
    ADD AL,Z
    ADD AL,30H
    MOV DL,AL
    MOV AH,2
    INT 21H
    
    MOV AH,4CH
    INT 21H
CODES  ENDS
    END  START




