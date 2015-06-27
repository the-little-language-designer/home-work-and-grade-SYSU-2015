我們對函數進行了定義，例如fact函數的定義是進行階乘的運算，而perm函數是進行排列組合的運算
define_function "fact", factorial
   xx dup, one?, false?branch, 2
   xx end
   xx dup , sub1, factorial
   xx multiple
   xx end


   ;;perm is permutation ::a of b
define_function "perm",permutation
   ;;<<  a,b -- a PERMUTATION b, a>b >>
   xx swap
   xx factorial,swap,factorial
   xx division
   xx end
                                                                                                                               