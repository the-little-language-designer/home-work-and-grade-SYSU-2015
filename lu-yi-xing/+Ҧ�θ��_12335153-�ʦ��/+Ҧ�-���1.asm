TITLE PROGRAM    (PROGRAM.asm)
;���񣺲���Դ�ַ�����Ŀ���ַ������״γ��ֵ�λ�ò�����ƥ���λ��
;�㷨����Ŀ���ַ����н�ȡ��Դ�ַ�������һ�����ַ�������Դ�ַ����Ƚϣ���ȼ���ʾ�ҵ�������ƥ��λ�ã�����Ⱦ��ٽ�ȡ��һ���µ��ַ�����ֱ���ҵ��󷵻�ƥ����Ҳ����˳�����


INCLUDE Irvine32.inc

.data
source byte "aka",0                     ;Դ�ַ��������ڴ˽��иĶ�
target byte "akdaka",0                  ;Ŀ���ַ��������ڴ˽��иĶ�

temp   byte lengthof source-1 DUP(?),0     ;���ڽ�ȡ��Դ�ַ����ȳ����ַ���

memo  dword 0                        ;���ڱ�������ȡ���ַ�������ĸλ�� 
count dword 0                        ;��ȡĳ���ض���memo�������ж��Ƿ����ʧ��

string1 byte "��������ҵ��ַ���Ϊ��",0
string2 byte "��ϲ����ҳɹ���ƥ���ַ�������λ�����edi��",0   ;���ڲ��ҳɹ��󷵻ص���ʾ
string3 byte "Ŀ���ַ���Ϊ��",0
string4 byte "�ܱ�Ǹ����Ĳ���ʧ��",0                          ;���ڲ���ʧ�ܺ󷵻ص���ʾ


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
	call crlf                                 ;һϵ�в���Ŀ�ĵ���ʾ

L0:                                           ;L0���ڳ�ʼ������ת
	mov esi,0
	mov edi,memo
    mov ecx,lengthof source-1
L1:                                           ;L1ѭ�����ڽ�ȡ��Դ�ַ����ȳ����ַ���
    mov al,target[edi]                      
    mov temp[esi],al
	inc esi
	inc edi
    loop L1
    
	add memo,1                                            ;һ�ν�ȡ��ɺ���memo�Լӣ������´ν�ȡ
	mov eax,memo
	mov count,eax                                         ;�Ѵ�ʱ��memo��ֵ��count�����������б��Ƿ���ҳɹ�
	.IF count > lengthof target +1 - lengthof source      ;��Ŀ���ַ�����Ҳ�Ҳ�����Դ�ַ����ȳ����ַ�����������ѭ�����˳�����
	jmp quit
	.ENDIF

	mov esi,0
    mov ecx,lengthof source-1
L2:                                           ;L2ѭ�����ڱȽ�����ȡ���ַ�����Դ�ַ����Ƿ����
	mov  al,temp[esi]	                       
	cmp  al,source[esi]                     
    jne  L0	 	                              ;���������ת��L0���½�ȡ�ַ������Ƚ�
	inc  esi
	loop L2

L3:
    mov edx,offset string2
    call writestring                           ;�����ҳɹ����򷵻سɹ���ʾ
	call crlf
	add memo,offset target
	sub memo,lengthof source
	mov edi,memo                               ;����ƥ���λ��
	call dumpregs

quit:                                                                               ;�˳������־
   .IF count > lengthof target +1 - lengthof source                                 ;������ʧ�ܣ��򷵻ز���ʧ����ʾ
    mov edx,offset string4
	call crlf
    call writestring
    .ENDIF
    call ReadInt
    exit
main ENDP
END main