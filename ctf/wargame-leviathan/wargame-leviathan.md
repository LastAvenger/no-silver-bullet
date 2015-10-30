wargame-leviathan
======================

* ssh addr: leviathan.labs.overthewire.org 
* url: http://overthewire.org/wargames/leviathan/ 

###leviathan0
flag: leviathan0

####leviathan1
flag: rioGegei8m

在 `~/.backup/bookmarks.html` 搜索 `password` 可得。

####leviathan2
flag: ougahZi8Ta

home 目录下有一程序名为 check，执行之，要求输入密码， 首先 `strings check` 查看一下程序中的字符串，似乎没有发现什么像 flag 的字串，不过倒是发现了一个 `/bin/sh`，推测程序会启动一个 shell。

用 gdb 调试，对 main 下断点后反汇编，关键部分如下：

```gas
0x0804857a <+77>:    call   0x80483c0 <printf@plt>
0x0804857f <+82>:    call   0x80483d0 <getchar@plt>
0x08048584 <+87>:    mov    %al,0x14(%esp)
0x08048588 <+91>:    call   0x80483d0 <getchar@plt>
0x0804858d <+96>:    mov    %al,0x15(%esp)
0x08048591 <+100>:   call   0x80483d0 <getchar@plt>
0x08048596 <+105>:   mov    %al,0x16(%esp)
0x0804859a <+109>:   movb   $0x0,0x17(%esp)
0x0804859f <+114>:   lea    0x18(%esp),%eax
0x080485a3 <+118>:   mov    %eax,0x4(%esp)
0x080485a7 <+122>:   lea    0x14(%esp),%eax
0x080485ab <+126>:   mov    %eax,(%esp)
0x080485ae <+129>:   call   0x80483b0 <strcmp@plt>
0x080485b3 <+134>:   test   %eax,%eax
0x080485b5 <+136>:   jne    0x80485c5 <main+152>
0x080485b7 <+138>:   movl   $0x804868b,(%esp)
0x080485be <+145>:   call   0x8048400 <system@plt>
0x080485c3 <+150>:   jmp    0x80485d1 <main+164>
```

`printf` 用来输出 “password” 字样，之后连续三个 `getchar`，之后把该字符串和 `esp + 14` 处的字符串作为参数给 `strcmp@plt`，根据比较的结果决定流程，因此对 `strcmp` 下断： `break strcmp@plt`，输入密码后查看堆栈：`x/10x $esp`

过程如下：

```
0xffffd63c:     0x080485b3      0xffffd654      0xffffd658      0x0804a000
0xffffd64c:     0x08048642      0x00000001      0x00333231      0x00786573
0xffffd65c:     0x00646f67      0x65766f6c
```

`0xffffd658` 处即是该程序的 password，用 `x/s 0xffffd658` 可看。
