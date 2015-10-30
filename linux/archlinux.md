#桌面
* xmonad
* xmobar (状态栏)
* dmenu (启动器)
* ~~trayer~~ 不支持多屏幕, 弃用.
* trayer-srg(AUR) (托盘)
* feh (桌面背景)
* xscreensaver (锁屏界面)
* scrot (截图)
* lxappearance (gtk 界面美化) | gtk-chtheme
* qtconfig-qt4

#网络
* networkmanger 
* network-manager-applet(nm-applet)
* gnome-keyring (否则无法连接至加密的无线网络)
注意 networkmanger 与 netctl 冲突， 因此安装 networkmanger 后要在 systemctl disable netclt 的服务

##校园网
* mentoHUST

##开启热点
[createap 脚本](https://wiki.archlinux.org/index.php/Software_access_point)

##Wine TMQQ-2013
为什么 winetrick 不管用... 安装时总是提示 该verb 已存在
安装:
* wine
* winetrick
* lib32-ncurses
* lib32-mpg123
* [邓攀打包的TM2013](http://www.zhihu.com/question/23770274/answer/45703773)
  (似乎该配置的我都自己配置了)
* winetrick riched20 ie6 mfc42 cjkfonts

#声音

##禁用蜂鸣器: 
    modprobe -r pcspkr # 禁用一次
在`/etc/modprobe.d/modprobe.conf`中，加入`blacklist pcspkr` # 永久禁用

##ALSA
[ALSA](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture)
ALSA 默认已经安装，只是所有声道被静音。

需要做的有：
* 将用户加入 `audio` 组 (本地用户默认加入)
* 安装 `alsa-utils` 软件包
* 执行 `alsamixer`， 标有 MM 的声道是静音的，按 M 键解除 
* 启动服务 `alsa-restore.service`

#文件管理

##搜索
* mlocate 

##网盘
* 坚果云(AUR)

#显示

##屏幕
[Multihead](https://wiki.archlinux.org/index.php/Multihead)
安装 `xorg-xrandr` 软件包，其中包含 `xrandr` 工具可用来设置各显示器的参数
    xrandr --output VGA-0 --auto --output LVDS --auto --right-of VGA-0

#词典
[goldendict](http://blog.yuanbin.me/posts/2013/01/goldendictxia-san-da-you-zhi-ci-ku-shi-yong-xiao-ji.html)

#Pacman
* 更新数据库: `pacman -Syy`
* 滚: `pacman -Syu`
* 不升级软件包: `/etc/pacman.conf` 中 `IgnoreGroup = package_name`
* 递归删除软件包及所有依赖该包的程序: `pacman -Rsc package_name`
* 删除软件包但不删除依赖该包的其他程序: `pacman -Rdd package_name`
* 检查未安装软件包中的文件列表: `pkgfile`
* 回滚某个包: `pacman -R package_name`, 到`/var/cache/pacman/pkg/`中寻找其旧版本并忽略该包的升级

#字体
用户的自定义设置在 `$XDG_CONFIG_HOME/.config/fontconfig/fonts.conf` 中。
在线生成配置： [Fontconfig Designer](http://wenq.org/cloud/fcdesigner_local.html#`)

#电源
使用 systemd 管理, **没有**安装 `acpi` 或 `pm-utils`.

##合盖
合盖问题在双屏情况下无法复现, 暂时忽略

##睡眠
默认配置下使用 `systemctl suspend` 表现正常

##休眠
需要稍作配置, 参见:
[Hibernation](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation)
1. 需要一个 swap 分区, 如果 swap 分区大小小于 RAM 大小, 请增大 swap 分区, 或者减小  `/sys/power/image_size`, 对于使用 swap file 的情况不讨论
2. 在 bootloader 中增加一个内核参数 `resume=/dev/sdxY` (sdxY 是 swap 分区的名字), 代表从哪个分区 resume. 对于 grub2, 编辑 `/etc/default/grub` 文件中的 `GRUB_CMDLINE_LINUX_DEFAULT` 参数, 本次编辑如下:
```
- GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+ GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=/dev/sda5"
```
更新 grub 配置 `grub-mkconfig -o /boot/grub/grub.cfg`
3. 配置 initramfs, 编辑 `/etc/mkinitcpio.conf` 中的 `HOOKS` 参数, 在 `udev` 后增加 `resume`, 改动如下:
```
- HOOKS="base udev autodetect modconf block filesystems keyboard fsck"
+ HOOKS="base udev resume autodetect modconf block filesystems keyboard fsck"
```
重新生成 initramfs 镜像: `mkinitcpio -p linux`
4. 现在可以使用 `systemctl hibernate` 休眠了

另, 将按下电源键的动作绑定为休眠: 编辑 `/etc/systemd/logind.conf` 中 HandlePowerKey=hibernate 

#现存的问题
- [ ] 错误的 fstab
- [ ] 光驱莫名弹出
- [ ] A 卡驱动的 `UVD clock timeout`
- [x] 无法休眠：遵循 Wiki 配置，依然有机率唤醒失败。
- [x] 字体渲染：遵循 Wiki 配置。
- [x] 键盘调节音量： pnmixer 自带我竟然不知道。
- [ ] 单屏幕合盖后屏幕闪烁
- [ ] 换一个 IRC 客户端
- [ ] haskell 包安装卸载时提示的 warnning 和 error
- [ ] wine qq 只能在一个屏幕上运行
- [x] 无线热点： AUR 脚本 `create_ap`
