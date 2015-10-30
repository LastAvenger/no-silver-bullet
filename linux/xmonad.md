XMonad
==============
#基本操作
[XMonad Guide Tour](http://xmonad.org/tour.html)
依赖： xterm, dmenu

> modkey: 默认是 `mod1(alt)`, `mod4` 是 mate 键
> 主面板是初始布局下靠左的面板
> 新窗口默认会从屏幕的左边插入, 作为主面板
> mod + shift + slash(/) 显示默认键绑定

##启动
* mod + shift + enter: 打开终端，默认 `xterm`
* mod + P:  启动器， 默认 `dmenu_run`

##布局和移动
* mod + space: 改变布局
* mod + j/k: 焦点到: 下一个/上一个 窗口
* mod + ,/. (comma/period): 增加/减少 主面板中窗口的数目
* mod + enter: 当前焦点窗口和主面板窗口交换位置
* mod + shift + j/k: 当前焦点窗口和 下一个/上一个 窗口交换位置

##调整
* mod + h/l: 调整主面板和从面板的宽度 (左/右)
* mod + button1(鼠标左键): 按住指定窗口并拖动可以使窗口浮动, 浮动的窗口始终置顶
* mod + button3(鼠标右键): 调整浮动窗口的大小
* mod + T: 让浮动的窗口回到平铺模式
* mod + button2(鼠标中键?): 将浮动窗口置顶

##管理
* mod + shift + c: 关闭当前窗口
* mod + q: 重启 XMonad
* mod + shift + q: 退出 XMonad
 
##工作空间
XMonad 默认提供九个工作空间
* mod + num: 切换工作空间 
* mod + shift + num: 将焦点窗口移动到工作空间

##多屏
* mod + w/e/r 移动到屏幕 1/2/3
* mod + shift + w/e/r 移动窗口到屏幕 1/2/3

##托盘和状态栏
[Xmobar & Trayer](https://wiki.haskell.org/Xmonad/Config_archive/John_Goerzen%27s_Configuration)

