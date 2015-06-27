       DATA SEGMENT
       ORG 3500H
       ASCLL DB '1','2','3','4'
       BIN DW 0
       TA DB 0AH
       DATA ENDS
       
       STACK SEGMENT STACK
	    DW 50 DUP(?)
       TOP LABEL WORD
       STACK ENDS
       
       CODE SEGMENT
	    ASSUME CS:CODE,DS:DATA,SS:STACK
       START: MOV AX,STACK
	      MOV SS,AX
	      MOV SP,OFFSET TOP
	      PUSH DS
	      SUB AX,AX
	      PUSH AX
	      MOV AX,DATA
	      MOV DS,AX
	      MOV CX,4
	      MOV AX,0
	      MOV DH,0
	      MOV BX,OFFSET ASCLL
       NEXT:  MOV DL,[BX]
	      AND DL,0FH
	      MUL [TA]
	      ADD AX,DX
	      INC BX
	      MOV [BIN],AX
	      LOOP NEXT
	      RET
       CODE  ENDS
	      END START


