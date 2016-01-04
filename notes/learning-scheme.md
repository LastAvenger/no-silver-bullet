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

* '() 是 list
* (cons element list) 是 list，element 可以是任意类型


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
