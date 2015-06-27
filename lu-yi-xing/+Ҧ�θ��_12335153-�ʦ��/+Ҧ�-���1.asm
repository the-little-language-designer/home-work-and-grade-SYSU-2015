TITLE PROGRAM    (PROGRAM.asm)
;任务：查找源字符串在目的字符串中首次出现的位置并返回匹配的位置
;算法：从目的字符串中截取和源字符串长度一样的字符串，和源字符串比较，相等即表示找到，返回匹配位置；不相等就再截取下一个新的字符串，直到找到后返回匹配或找不到退出程序


INCLUDE Irvine32.inc

.data
source byte "aka",0                     ;源字符串，可在此进行改动
target byte "akdaka",0                  ;目的字符串，可在此进行改动

temp   byte lengthof source-1 DUP(?),0     ;用于截取与源字符串等长的字符串

memo  dword 0                        ;用于保存所截取的字符串首字母位置 
count dword 0                        ;截取某个特定的memo，用于判断是否查找失败

string1 byte "你所需查找的字符串为：",0
string2 byte "恭喜你查找成功，匹配字符串所在位置请见edi：",0   ;用于查找成功后返回的提示
string3 byte "目的字符串为：",0
string4 byte "很抱歉，你的查找失败",0                          ;用于查找失败后返回的提示


.code
main PROC
    

	mov edx,offset string3
	call writestring
	mov edx,offset target
	call writestring
	call crlf
	mov edx,offset string1                 
	call writestring   
    mov edx,offset source
    call writestring
	call crlf                                 ;一系列步骤目的的提示

L0:                                           ;L0用于初始化和跳转
	mov esi,0
	mov edi,memo
    mov ecx,lengthof source-1
L1:                                           ;L1循环用于截取与源字符串等长的字符串
    mov al,target[edi]                      
    mov temp[esi],al
	inc esi
	inc edi
    loop L1
    
	add memo,1                                            ;一次截取完成后让memo自加，方便下次截取
	mov eax,memo
	mov count,eax                                         ;把此时的memo赋值给count，用于下面判别是否查找成功
	.IF count > lengthof target +1 - lengthof source      ;当目的字符串再也找不到与源字符串等长的字符串，则跳出循环，退出程序
	jmp quit
	.ENDIF

	mov esi,0
    mov ecx,lengthof source-1
L2:                                           ;L2循环用于比较所截取的字符串与源字符串是否相等
	mov  al,temp[esi]	                       
	cmp  al,source[esi]                     
    jne  L0	 	                              ;不相等则跳转到L0重新截取字符串并比较
	inc  esi
	loop L2

L3:
    mov edx,offset string2
    call writestring                           ;若查找成功，则返回成功提示
	call crlf
	add memo,offset target
	sub memo,lengthof source
	mov edi,memo                               ;返回匹配的位置
	call dumpregs

quit:                                                                               ;退出程序标志
   .IF count > lengthof target +1 - lengthof source                                 ;若查找失败，则返回查找失败提示
    mov edx,offset string4
	call crlf
    call writestring
    .ENDIF
    call ReadInt
    exit
main ENDP
END main