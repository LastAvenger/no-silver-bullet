Bash 的基本用法
===============

* [Linux Shell脚本教程：30分钟玩转Shell脚本编程](http://c.biancheng.net/cpp/shell/)

# 变量

* 变量赋值时 `=` 两边不可以有空格, 变量不需要加 `$`, 使用变量时要加 `$`;
* 变量名外可加花括号: `{$TERM}`, 用来帮助解释器识别变量边界

## 特殊变量

* `$` 表示当前 shell 进程的 ID `echo $$`
* `$0` 表示当前执行的脚本文件名, 即使是 `sh shell.sh` 的 `$0` 也是 shell.sh
* `$#` 参数个数
* `$*` 所有参数
* `$@` 所有参数, 参数被双引号包含时有所不同(?)

```bash
for var in "$*"; do; echo "$var"; done
for var in "$@"; do; echo "$var"; done
```


* `$?` 上一个命令的退出状态

##字符串

* 单引号 单引号中的 **所有** 字符都会原样输出
* 双引号 可以转义, 可以包含变量
* ${#str} 获取长度
* ${str:1:4} 截取
* `expr index "$str" is` 查找 

## 数组

* 定义

```bash
arr=(1 2 3 4 5 6)
arr[1]=1
arr[2]=2
```

* 读取

```bash
val=${a[i]}
```


* 长度

```bash
len=${arr[n]} # 单个元素
len=${#arr[*]} # 元素个数
len=${#arr[@]} # 同上
```

# 运算

* 比较运算 `-eq` `-ne` `-gt` `-lt` `-ge` `-le`

```bash
a=10
b=11
if [ $a -eq $b ]; then # 与`[]`的空格不可省略
    echo "EQU"
fi
```


* 布尔运算 `!`(非) `-o` (或) `-a` (与)
* 字符串运算 `=` (相等) `!=` (不等) `-z` (长度为0返回 ture)
  `-n` (长度不为0返回 true) str(是否为空): `[ $var ]`
* 文件测试运算 `-d`(目录) `-f`(普通文件) `-p`(命名管道) `-r`(可读) `-w`(可写)
  `-x`(可执行) `-s` (是否为空) `-e` (是否存在)
* 数值运算 **不支持** 是使用 `expr` 代替, 运算符周围空格不可省略
    var=`expr 2 + 2` 或者 var=$(expr 2 + 2)

# 内置命令

* `read [VAR]`

> 从标准输入读取一行字符串, 参数 `-r` 表示不把反斜杠(`\`)转义

```bash
read person
echo $person
```

* `readonly [VAR]`

> 使该变量为只读


* `unset [VAR]`

> 删除变量, 无法删除只读变量


* `echo`

```bash
echo "OK\c"     # 不换行
echo 'xxx\/'    # 原样输出
```

* `printf`

```bash
printf "%d %s\n" 1 "abc"
```

* `source <file>`

> 包含另一个脚本, 该脚本不需要有 x 位.(是内置命令么?)

# 语句

## if

* `if [ ]; then ... fi`
* `if [ ]; then ... else ... fi`
* `if [ ]; then ... elif ... else ... fi`

## case

## for

```bash
for var in list
do
    ...
    ...
done
```

不指定 `list` 的话, 使用命令行的位置参数(?), 使用 `break`, `continue`
跳出循环(list 似乎以空格切分元素)

## 函数

```bash
func () {
    echo "param: $1"    # $1 函数的第一个参数
    echo "param: $2"
    return val          # 不加的话会以最后一个命令作为返回值
}
func "1" "2"            # 调用
unset -f func           # 去除定义
```

# 重定向

* 标准输入 `0` 
* 标准输出 `1`
* 错误输出 `2`
