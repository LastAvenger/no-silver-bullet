Learning Scheme
===============
# 教程
* [Teach Yourself Scheme in Fixnum Days.zh-CN](http://songjinghe.github.io/TYS-zh-translation/)
* [Yet Another Scheme Tutorial.zh-CN](http://deathking.github.io/yast-cn/index.html)
* [The Little Schemer](N/A)

# 编译器
* guile 的自动补全

        ; pcaman -S readline
        ; ~/.guile
        (use-modules (ice-9 readline))
        (activate-readline)

* chicken (csi) 的自动补全

        ; chicken-install readline
        ; ~/.csirc
        (use readline)
        (current-input-port (make-readline-port))
        (install-history-file #f "/.csi.history")

# 正文
以下代码使用 chicken 运行。

### quote
`quote` 用来阻止符号（symbol）被求值，`'` 是其缩略形式:

    (+ 1 2)         => 3
    (quote (+ 1 2)) => (+ 1 2)
    '(+ 1 2)        => (+ 1 2)
    '()             => ()

#### 特殊形式(?)
普通的 symbol 会对所以参数求值并返回值，特殊形式的 symbol 不会对所有的参数求值：
`qutoe`（这是当然的） `lambda` `define` `if` `set!`

### pair & list 
`(cons 1 2)` 生成一个 pair `(1 . 2)`，pair 的第一个元素被称为 car，第二个元素被称为 cdr.

按照如下定义嵌套的 pair 被称为 list：

* `'()` 是 list
* `(cons element list)` 是 list，element 可以是任意类型

可以使用 `(null? list)` 来判断表是否空（`'()`）

    (cons 1 2)                      => (1 . 2)
    (cons 1 (cons 2 (cons 3 '())))  => (1 2 3)
    (cons 1 (cons 2 5))             => (1 2 . 5)
    (cons #\a (cons 3 "hello"))     => (#\a 3 . "hello")

#### car & cdr & list
函数 `car` 和 `cdr` 分别取回一个 pair 的 car  部分和 cdr 部分，`list` 用于构造一个表

    ; pair
    (car '(1 . 2))                          => 1
    (cdr '(1 . 2))                          => 2
    ; list 
    (cdr '(1 . (2 . ())))                   => (2)
    (cdr (cons 1 (cons 2 (cons 3 '()))))    => (2 3)
    (list 1 3 4)                            => (1 3 4)
    (list (cons 1 2) (cons 1 3))            => ((1 . 2) (1 . 3))

#### atom

以下数据类型是 atom：

* numbers
* strings
* symbols
* booleans
* characters

以下是 The Little Schemer 中对 atom 的定义：

    ; All that not a pair or null is an atom.
    ; define in The Little Schemer
    (define atom?
      (lambda (x)
        (and (not (pair? x)) (not (null? x)))))

### procedure

#### lambda
`lambda`，接受两个参数，返回一个 procedure，参数一是参数表，参数二是函数体：

    (lambda () (display "archlinuxcn"))     => #<procedure (?)>
    ((lambda () (display "archlinuxcn")))   => archlinuxcn
    ((lambda (x y) (+ x y)) 1 2)            => 3

#### define
`define` 声明并绑定一个全局变量，参数一为变量名，参数二为被绑定的对象，借此可以复用 `lambda` 所生成的 procedure。

    (define add (lambda (x y) (+ x y)))
    add         => #<procedure (add x y)>
    (add 1 3)   => 4
    (define str "arch")
    str         => "arch"

#### 不使用 lambda

    (define (add3 a b c) (+ a b c))
    add3            => #<procedure (add3 a b c)>
    (add3 1 2 3)    => 6

### 分支
#### if
`(if predicate then_value else_value)` 当 `predicate` 为真则对 `then_value` 求值，反之则对 `else_value` 求值，`else_value` 部分可以省略，求得的值会传出括号外。
对于 `predicate`，任意值（包括 `#t`）被认为 ture，`#f` 则是 false。

    (define (abs x) (if (< x 0) (- x)  x))
    
#### not and or
* `not` 接受一个参数，取反
* `and` 接受任意个参数，从左到右求值，若出现 `#f` 则返回 `#f`，若全不为 `#f` 则返回最后一个参数的值
* `and` 接受任意个参数，从左到右求值，返回第一个不是 `#f` 的参数，若全是 `#f` 则返回最后一个参数的值

#### cond
类似 case：

    (cond
      (predicate_1 clauses_1)
      (predicate_2 clauses_2)
        ...
      (predicate_n clauses_n)
      (else        clauses_else))

遇到成立的 `predicate` 则执行对应的子句后返回，全部不成立则执行 `else` 的子句。

#### equ
* `eq?` 比较两个参数的地址，不要使用它来比较数字
* `eqv?` 比较两个参数的类型和值
* `equal?` 比较 list 与 字符串 (?)

### let 
`(let bind body)` 为 `body` 语句绑定局部变量，变量在 `bind` 中初始化，`bind` 中的变量不可互相引用：

    (let ((i 1)) (+ i 2))   => 3

`let` 是 `lambda` 的语法糖：

    (let ((p v)) (+ p 1))       => 2
    ; equal to
    ((lambda (p) (+ p 1)) v)    => 2

#### let\*
使用 `let*` 可以引用定义在同个绑定中的变量（`let*` 事实上是嵌套的 `let` 的语法糖）：

    (let* ((i 1) (j (- i))) (+ i j))    => 0

#### named let
可以为一个 `let` 命名来实现循环：

    (define (fact-let n)
      (let loop((n1 n) (p n))
        (if (= n1 1) p
        (let ((m (- n1 1)))
            (loop (sub1 n1) (* p (sub1 n1)))))))

#### letrec
允许 `bind` 中的变量递归地调用自己：

    (define (sum-letrec xs)
      (letrec ((sum1 (lambda (xs1)
                      (if (null? xs1) 0
                        (+ (car xs1) (sum (cdr xs1)))))))
        (sum1 xs)))

### do
`(do binds (predicate value) body)` 变量在 `bind` 中被绑定，若 `predicate` 为真，则函数跳出 `do` 语句，值 `value` 被传递出来，否则循环继续。

    (define (fact-do n)
      (do ((n1 n (- n1 1)) (p n (* p (- n1 1)))) ((= n1 1) p)))

### 递归 

    (define (fact n)
      (if (= n 1) 1 (* n (fact (- n 1)))))

#### 尾递归
    
    (define (fact-tail n)
      (fact-rec n n))

    (define (fact-rec n p)
      (if (= n 1) p
        (fact-rec (sub1 n) (* p (sub1 n)))))
    ; 使用 named let 或者 letrec 的话可以不用两个函数
