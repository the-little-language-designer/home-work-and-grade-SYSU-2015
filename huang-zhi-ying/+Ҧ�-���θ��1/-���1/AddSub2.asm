INCLUDE Irvine32.inc

.data
jmptab dword multiply
       dword plus
	   dword minus
	   dword division
val1 sdword ?
val2 sdword ?
ope byte ?
string1 byte "输入的运算符有误！",0
string2 byte "请输入第一个整数：",0
string3 byte "请输入第二个整数：",0
string4 byte "是否继续？（y/n）：",0
string5 byte "请输入运算符：",0
string6 byte "运算结果为：",0
string7 byte "商",0
string8 byte "，余数",0

.code

main PROC
.repeat
    mov edx,offset string2
	call WriteString
    call ReadInt
    mov val1,eax
	mov edx,offset string3
	call WriteString
	call ReadInt
	mov val2,eax
	mov edx,offset string5
	call WriteString
	call ReadChar
	call WriteChar
	call Crlf
	mov ope,al
    mov ebx,offset jmptab
	mov ecx,0
	mov cl,ope
	.if cl=='*'
	    call near ptr [ebx]
    .elseif cl=='+'
		call near ptr [ebx+4]
	.elseif cl=='-'
		call near ptr [ebx+8]
	.elseif cl=='/'
		call near ptr [ebx+12]
	.else 
		mov edx,offset string1
		call WriteString
	.endif
	mov edx,offset string4
	call WriteString
	call ReadChar
	call Crlf
	.if al=='N'
	    mov al,'n'
	.endif
.until al=='n'
	call ReadInt
    exit
main ENDP

multiply proc
    push eax
	push edx
	mov eax,val1
	mov ebx,val2
	imul ebx
	mov val1,eax
	mov eax,edx
	mov edx,offset string6
	call WriteString
	call WriteHex
	mov eax,val1
	call WriteHex
	pop edx
	pop eax
	ret
multiply endp

plus proc
    push eax
	mov eax,val1
	add eax,val2
	mov edx,offset string6
	call WriteString
	call WriteInt
	call Crlf
	pop eax
	ret
plus endp

minus proc
    push eax
	mov eax,val1
	sub eax,val2
	mov edx,offset string6
	call WriteString
	call WriteInt
	call Crlf
	pop eax
	ret
minus endp

division proc
    push eax
	push edx
	mov eax,val1
	cdq
	mov ebx,val2
	idiv ebx
    mov val1,edx
	mov edx,offset string7
	call WriteString
	call WriteInt
	mov edx,offset string8
	call WriteString
	mov eax,val1
	call WriteInt
	call Crlf
	pop edx
	pop eax
	ret
division endp

  END main