1)小组人员
小组共四名成员，分别为：
杨旸，数学与计算科学学院2012级6班，12335253；
文艺，数学与计算科学学院2013级5班，13336195；
蓝芳，数学与计算科学学院2013级5班，12303067；
黄文雯，数学与计算科学学院2013级3班，12329069；


2)源代码 中 新增部分
define_function "cube", cube
;; <<  n -- n^3>>
   xx dup       ;;n n
   xx dup       ;;n n n
   xx multiple  ;;n^2 n
   xx multiple  ;;n^3
   xx end


define_function "square", square
;; <<  n -- n^2>>
   xx dup       ;;n n
   xx multiple  ;;n^2
   xx end


define_function "quadratic_sum", quadratic_sum
;; <<1^2+2^2+3^2+…+n^2=n*(n+1)*(2*n+1)/6>
   xx dup       ;; n n
   xx dup       ;; n n n
   xx zero      ;; n n n 0
   xx add1      ;; n n n 1
   xx addition  ;; n n n+1
   xx swap      ;; n n+1 n
   xx zero      ;; n n+1 n 0
   xx add2      ;; n n+1 n 2
   xx multiple  ;; n n+1 n*2
   xx zero      ;; n n+1 n*2 0
   xx add1      ;; n n+1 n*2 1
   xx addition
   xx multiple
   xx multiple
   xx zero
   xx add2
   xx add4
   xx division  ;; result
   xx end


define_function "gauss_sum", gauss_sum
   ;; << n -- 1+2+...+n >>
  xx dup, one?, false?branch, 2
  xx end
  xx dup,  sub1, gauss_sum
  xx addition
  xx end


define_function "factorial", factorial
  ;;<<n -- n!>>
  xx dup, one?, false?branch, 2
  xx end
  xx dup,  sub1, factorial
  xx multiple
  xx end



define_function "absolute", absolute
  ;;<<n -- |n|>>
  xx dup, positive?, false?branch, 2
  xx end
  xx negate
  xx end


3)代码说明
平方求和1^2+2^2+3^2+…+n^2的设计原理是直接代入计算公式，
先设计了计算数的平方(square)与立方(cube)函数为基础，
及第五阶段代码的前提下，完成了（quadratic_sum）。
在完成平方求和之前先简略设计套用公式高斯求和（gauss_sum），
后用分支原理进行优化，试图通过递归达到循环的效果，
并用同样的理论完成阶乘运算(factorial)和计算绝对值(absolute)函数。

4）可执行文件网盘链接：http://yun.baidu.com/share/link?shareid=3710575833&uk=3892912271