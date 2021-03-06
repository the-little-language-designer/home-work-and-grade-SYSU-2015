TITLE Extended Addition Example           (ExtAdd.asm)
;256位的扩展加法运算，两个数需要等字长
;程序实用一个循环把每对双字相加，保存进位标志，并使之加入后面双字的运算
;原则上通过修改可以实现任意位等长的加法运算
;由于数据太大，不便处理，目前能力不够，所以是以16进制输出结果的

INCLUDE Irvine32.inc


WriteString_m  macro  string		;;封装WriteString_m
			 push edx
			 mov edx,offset string
			 call WriteString
			 pop edx
			endm

.data
op1 qword 0a2b2a40674981234h,1111111111111111h,3333333322222222h,05555555566666666h				;此数为555555556666666633333333222222221111111111111111a2b2a40674981234h
op2 qword 08010870000234502h,2222222222222222h,4444444466666666h,0bbbb777799999999h				;此数为bbbb777799999999444444446666666622222222222222228010870000234502h
sum dword 9 dup(0ffffffffh) 															;此数为000000011110ccccffffffff7777777788888888333333334444444422c32b0674bb5736h
																						;长度已经足够，考虑到了溢出的情况	
str1 byte "第一个数是：",0
str2 byte "第二个数是：",0
str3 byte "和是：",0

.code
main PROC

WriteString_m str1
	mov  esi,OFFSET op1
	mov  ecx,8
	call	Display			;调用子程序

WriteString_m str2
	mov  esi,OFFSET op2
	mov  ecx,8
	call	Display			;调用子程序

	mov	esi,OFFSET op1		; 第一个数的地址
	mov	edi,OFFSET op2		; 第二个数的地址
	mov	ebx,OFFSET sum		; 和的地址
	mov	ecx,8   			; 字的长度
	call	Extended_Add		;调用子程序
	

; 输出 sum.
	
WriteString_m str3
	mov  esi,OFFSET sum
	mov  ecx,LENGTHOF sum
	call	Display			;调用子程序
	
	call readint 
	exit
main ENDP


Extended_Add PROC

	pushad						; 将所有的32位通用寄存器压入堆栈
	clc                			; 清除进位标志

L1:	mov	eax,[esi]      			; 找到第一个数
	adc	eax,[edi]      			; 与第二个数相加

	pushfd              		; 将32位标志寄存器EFLAGS压入堆栈，保留进位标志
	
	mov	[ebx],eax      			; 将这部分的和存起来
	
	add	esi,4         			; 将3个指针都移动
	add	edi,4
	add	ebx,4
	
	popfd               		; 将32位标志寄存器EFLAGS取出堆栈,恢复进位标志
	loop	L1           		; 继续循环
	

	mov	dword ptr [ebx],0		; 清除sum的高位
	adc	dword ptr [ebx],0		; 与剩余的相加

	popad						;将所有的32位通用寄存器取出堆栈
	ret
Extended_Add ENDP

Display PROC
	pushad						; 将所有的32位通用寄存器压入堆栈
	
	mov eax,ecx					;完成 esi=esi+ecx*4的目标，即找到要输出的数的最高位
	mov edx,4
	mul edx
	add esi,eax
	sub esi,4					
	
	
L2:	mov eax,[esi]			;找到并传给eax
	call WriteHex			;输出
	sub  esi,4				;转移到下一地址
	loop L2

	popad
	call crlf
	ret
Display ENDP



END main