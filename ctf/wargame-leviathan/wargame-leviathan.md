wargame-leviathan
======================

* ssh addr: leviathan.labs.overthewire.org 
* url: http://overthewire.org/wargames/leviathan/ 

#### leviathan0
flag: leviathan0

#### leviathan1
flag: rioGegei8m

在 `~/.backup/bookmarks.html` 搜索 `password` 可得。

#### leviathan2
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

#### leviathan3
flag: Ahdiemoo1j

这道题想了很久还是不会，最终上网看答案了……

登入机器后发现家目录有个带 `suid` 权限的可执行文件 `printfile`，属主是 `leviathan3`，用户组是 `leviathan2`，带 `suid` 的程序执行时可以获得和 owner/grouper 相同的权限（euid/egid）。

> **Note:** 关于 linux 下的权限，更多请参见 [linux/privileges.md//TODO](TODO)。

```text
leviathan2@melinda:~$ ll printfile  
-r-sr-x--- 1 leviathan3 leviathan2 7498 Nov 14  2014 printfile*
leviathan2@melinda:~$ ./printfile 
*** File Printer ***
Usage: ./printfile filename
leviathan2@melinda:~$ ./printfile /etc/leviathan_pass/leviathan3
You cant have that file...
```

从字面意思上看，这个程序接受一个文件路径然后把文件的内容显示出来，但是要求它打印 `/etc/leviathan_pass/leviathan3` 却提示 `You cant have that file...`，上 gdb 分析看看。

以下是 `diaasm main` 的结果，假设执行了 `r filename`：

```gas
   0x0804852d <+0>:     push   %ebp
   0x0804852e <+1>:     mov    %esp,%ebp
   0x08048530 <+3>:     and    $0xfffffff0,%esp
   0x08048533 <+6>:     sub    $0x230,%esp
   0x08048539 <+12>:    mov    0xc(%ebp),%eax           ; argv 参数地址
   0x0804853c <+15>:    mov    %eax,0x1c(%esp)          ; argv 保存到 [esp + 0x1c]
   0x08048540 <+19>:    mov    %gs:0x14,%eax            ; Thread-Local Storage, 不知道是什么
   0x08048546 <+25>:    mov    %eax,0x22c(%esp)
   0x0804854d <+32>:    xor    %eax,%eax
   0x0804854f <+34>:    cmpl   $0x1,0x8(%ebp)           ; \ argc 和 1 比较，此处 argc 应该为 2
   0x08048553 <+38>:    jg     0x804857e <main+81>      ; / argc > 1 则跳 
   0x08048555 <+40>:    movl   $0x8048690,(%esp)
   0x0804855c <+47>:    call   0x80483d0 <puts@plt>
   0x08048561 <+52>:    mov    0x1c(%esp),%eax
   0x08048565 <+56>:    mov    (%eax),%eax
   0x08048567 <+58>:    mov    %eax,0x4(%esp)
   0x0804856b <+62>:    movl   $0x80486a5,(%esp)
   0x08048572 <+69>:    call   0x80483b0 <printf@plt>
   0x08048577 <+74>:    mov    $0xffffffff,%eax
   0x0804857c <+79>:    jmp    0x80485e8 <main+187>

; -> 来自 0x08048553 <+38> 的跳转，以上代码不必分析了
   0x0804857e <+81>:    mov    0x1c(%esp),%eax          ; 取出储存的 argv
   0x08048582 <+85>:    add    $0x4,%eax                ; 移动到 argv 的第一个参数（从 0 计数）
   0x08048585 <+88>:    mov    (%eax),%eax              ; 取出 argv[1] 的值，指向字符串 ‘filename’
   0x08048587 <+90>:    movl   $0x4,0x4(%esp)           ; \ 参数二：int amode
   0x0804858f <+98>:    mov    %eax,(%esp)              ; | argv[1] 作参数一： char *path
   0x08048592 <+101>:   call   0x8048420 <access@plt>   ; / access(argv[1], 4)，成功返回 0
   0x08048597 <+106>:   test   %eax,%eax
   0x08048599 <+108>:   je     0x80485ae <main+129>     ; 跳
   0x0804859b <+110>:   movl   $0x80486b9,(%esp)
   0x080485a2 <+117>:   call   0x80483d0 <puts@plt>
   0x080485a7 <+122>:   mov    $0x1,%eax
   0x080485ac <+127>:   jmp    0x80485e8 <main+187>

; -> 来自 0x08048599 <+108> 的跳转
   0x080485ae <+129>:   mov    0x1c(%esp),%eax          ; \
   0x080485b2 <+133>:   add    $0x4,%eax                ; | 取得 argv[1]
   0x080485b5 <+136>:   mov    (%eax),%eax              ; /
   0x080485b7 <+138>:   mov    %eax,0xc(%esp)           ; \ ...: argv[1]
   0x080485bb <+142>:   movl   $0x80486d4,0x8(%esp)     ; | char *format: string "/bin/cat %s"
   0x080485c3 <+150>:   movl   $0x1ff,0x4(%esp)         ; | size_t size: 511
   0x080485cb <+158>:   lea    0x2c(%esp),%eax          ; | 
   0x080485cf <+162>:   mov    %eax,(%esp)              ; | char *str
   0x080485d2 <+165>:   call   0x8048410 <snprintf@plt> ; / snprintf(str, 511, "/bin/cat %s", argv[1]);
   0x080485d7 <+170>:   lea    0x2c(%esp),%eax
   0x080485db <+174>:   mov    %eax,(%esp)              ; \
   0x080485de <+177>:   call   0x80483e0 <system@plt>   ; / system("/bin/cat filename");
   0x080485e3 <+182>:   mov    $0x0,%eax
   0x080485e8 <+187>:   mov    0x22c(%esp),%edx
   0x080485ef <+194>:   xor    %gs:0x14,%edx
   0x080485f6 <+201>:   je     0x80485fd <main+208>
   0x080485f8 <+203>:   call   0x80483c0 <__stack_chk_fail@plt>
   0x080485fd <+208>:   leave  
   0x080485fe <+209>:   ret    
End of assembler dump.
```

可以看到程序接受一个文件路径，先检查对该文件的访问权限，然后执行 shell 命令 "/bin/cat filename"。

问题出在 `access` 函数， man 是这样说的：

> The access() function shall check the file named by the pathname pointed to by the path argument for accessibility  according  
> to  the bit pattern contained in amode, **using the real user ID in place of the effective user ID and the real group ID in   
> place of the effective group ID.**

而 `suid` 权限改变的只是进程的 `euid`，因此当你执行 `./printfile /etc/leviathan_pass/leviathan3` 的时候，access 函数总是失败的。

但是用 gdb 改变程序的流程也是[不可行](http://unix.stackexchange.com/questions/15911/can-gdb-debug-suid-root-programs)的，非 root 的 gdb 调试带 suid 权限的程序时，程序不会获得本来应该有的权限（否则 gdb 就可以任意地改变程序的行为了），即使绕过了 access 函数，你依然会得到一个 `Permission denied`。

到这里我就没辙了，只能看别人的 writeup 了：[OverTheWire Leviathan Wargame Solution 2](https://rundata.wordpress.com/2013/03/27/overthewire-leviathan-wargame-solution-2/)，看完发现脑洞确实不够大。

**Solution:**  
access() 接受的是个字符串参数，而 cat 的参数却是由 shell 处理的，执行 `./printfile "flag here"`，对于 access 函数来说是执行了 `access("flag here", 4)`, 检查对 `flag here` 这个文件的访问权限，而对 cat 来说是这样的 `system("cat flag here")` = `system*("cat flag; cat here")`，因此可以利用这个区别来绕过 access 函数。

```shell
leviathan2@melinda:/tmp$ mkdir slove
leviathan2@melinda:/tmp$ cd slove
leviathan2@melinda:/tmp/slove$ touch 'flag here'    # 带空格的文件名
leviathan2@melinda:/tmp/slove$ ln -s /etc/leviathan_pass/leviathan3 flag
leviathan2@melinda:/tmp/slove$ ls
flag  flag here
leviathan2@melinda:/tmp/slove$ ~/printfile 'flag here'  # access 检测的是刚刚建立的新文件， cat 显示的则是 flag 和 here
Ahdiemoo1j
/bin/cat: here: No such file or directory
```
