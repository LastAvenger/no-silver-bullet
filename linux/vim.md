# 插件列表

* Vundle 
* youcompleteme
* nerdtree
* powerline
* fcitx.vim

# TIPS
## 批量处理文件

用 `args` 批量打开文件, 用 `argdo` 批量处理.

    " 给 MnO2 的 PR: 把书中所有的 ``` 替换为 ```haskell 
    :cd GitHub\learnyouahaskell-zh\
    :args *\*\*.md
    :argdo %s/```\(\n.\)\@=/```haskell/ge | update

* 其中`\(\)\@=`是正则的零宽断言
* `/ge`的`e`代表忽略错误
* `|`是命令连接符
* `update` 表示文件发生改动后存盘, 不用 `update` 的话处理完一个文件会提示
  文件未保存(意思大概是处理完一个文件随即退出, 要手动存盘)

## 去除 BOMB 头

    :set nobomb

# Pentadactyl

* Mkpentadactylrc 创建新的 Pentadactylrc 配置文件, 位于 `%USERPROFILE%`.
* "恢复剪切复制黏贴的使用(占用了Ctrl + C, 需要寻找替代)

```viml
noremap <C-a> <C-v><C-a>
noremap <C-c> <C-v><C-c>
noremap <C-f> <C-v><C-f>
noremap <C-x> <C-v><C-f> 

cnoremap <C-a> <C-v><C-a>
cnoremap <C-c> <C-v><C-c>
cnoremap <C-v> <C-v><C-v>
cnoremap <C-x> <C-v><C-x>

inoremap <C-a> <C-v><C-a>
inoremap <C-c> <C-v><C-c>
inoremap <C-v> <C-v><C-v>
inoremap <C-x> <C-v><C-x>
```

* 使用 n,m 唤出地址栏书签栏 (!= 可以切换状态)

```viml
map n :set go!=B<CR>
map m :set go!=T<CR>
```

* :mkv 生成vim需要的脚本文件
