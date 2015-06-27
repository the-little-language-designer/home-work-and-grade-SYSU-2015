format PE GUI 4.0
include 'win32ax.inc' ;**********************数据*****************************
systime SYSTEMTIME
szBuffer db 30 dup ?
entry $
invoke GetLocalTime, systime
mov ebx,systime
movzx eax, word [ebx];?
movzx esi, word [ebx+2];月
movzx edx, word [ebx+4];星期
movzx edi, word [ebx+6];日
invoke wsprintf,szBuffer, '%d年%d月%d日 星期%d ', eax, esi, edi,edx
invoke MessageBox,NULL,szBuffer, '提示', MB_OK
invoke ExitProcess,NULL
section '.import' data import readable
library kernel32, 'kernel32.dll',\
user32, 'user32.dll'
include 'api\kernel32.inc'
include 'api\user32.inc'