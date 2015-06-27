# 汇编实验报告

组员 :

   姓名    |   学号   | 班级
----------|----------|--------
郭大为     | 13336045 | 13级一班
葛永强     | 13336043 | 13级一班
鲁育辰     | 12335151 | 12级一班
徐子祺     | 12335237 | 12级一班

## 实验环境

系统：linux(CentOS)
编辑器：vim
编译器：fasm

## 实验要求

1. 在线串码解释器中写一个primitive-function 或写一个 function
2. 定制一个你自己的REPL
3. 在自己写的解释器汇中，用自己所设计的语言来定义新的函数，写几个函数


## 函数、REPL源码与使用说明

1. 解释器中实现 求立方函数`cube`

`cube`功能为: 求一数的立方数，比如

`4 cube`会输出为 64

下面代码加入文件`cicada-nymph.fasm`中，(前面的数字表示所在行号)

	2075 define_function "cube", cube
	2076    ;; << a -- a*a*a >>
	2077    xx dup
	2078    xx dup
	2079    xx multiple
	2080    xx multiple
	2081    xx end

2. 定制了一个简单的 REPL， 可以完成简单的聊天（chat）

在文件`core.in`中加入如下代码来导入 聊天文件

	744 : chat!
	745   << -- >>
	746   "chat.cn" load-file
	747   end
	748 ; define-function

`chat!` 的具体代码放在文件`chat.cn`中

使用方式：终端运行

	./cicada-nymph
	chat!
	chat
	chat

3. 设计函数 `gcd` 求两个数的最大公约数，(个人认为写得非常的漂亮简洁）

功能为：求两个数的最大公约数 < a, b -- gcd(a,b) >

下面代码加入文件`core.in`文件中，(前面的数字表示所在行号)

	750 : gcd
	751   over
	752   over
	753   less-than? if
	754     swap
	755   then
	756   tuck
	757   mod
	758   dup zero? if
	759   "zero " write-string
	760   drop
	761   end
	762   then
	763   gcd
	764   end
	765 ; define-function

使用方式：终端运行

	32 24 gcd

4. 设计嵌套调用函数`square`, `squaresum`, 其中函数`squaresum`调用子函数`suqare`。

`squaresum`功能为: 求一个小于某个数的所有正整数的平方和，比如

`4 squaresum`会输出为 4^2+3^2+2^2+1^2

函数代码放在文件`myfun.cn`中

**注意！文件`myfun.cn`已有测试代码**

使用方式：终端运行
	
	./cicada-nymph
	myfun
	2 square
	4 squaresum


## 总结

注：以上所有测试都在 linux 系统上测试成功

个人对这次实验完成的情况比较满意，特别是函数`gcd`与聊天机器人`chat`的实现,非常有成就感。

个人感觉`gcd`可以作为`cicada`的范例程序，用于教学，或者写入教程文档中

在函数设计过程中遇到过非常多的麻烦，这种麻烦的产生个人觉得，是解释器的设计不够理想

主要体现在如下几个方面：

1. 没有类似 C 语言中的 while 语法
2. `1ess-than`会将参数栈中的两元素弹出，如果我希望保留这两个参数在栈中，就只能`over over less-than`
3. 逻辑判断时总是需要使用一个`dup`,比如`dup zero? if`
4. 已有的接口没有函数列表，在设计自己的函数时不知道自己是否在重新造轮子，只能通过执行`show-dictionary`查看，最好能做出一份文档。
5. 例程不够多，特别是像 if else then 这类控制语法的说明非常的缺乏
