# 常用软件列表
* WM/DE: xmonad
* 虚拟终端：konsole
* 编辑器：vim
* 输入法：fcitx+rime
* 浏览器：firefox
* 状态栏：xmobar
* 启动器：dmenu
* 托盘： ~~trayer~~(不支持多屏幕, 弃用), trayer-srg<sup>AUR</sup>
* 图片浏览： feh
* 文件管理： dolphin
* Office： wps-offic
* PDF：okular
* 截图：scrot
* 混频器： alsamixer, pnmxier-gtk3<sup>AUR</sup>
* 主题更改：lxappearance(gtk), qtconfig-qt4(qt4)
* IM: qtox-git, ~~cutegram~~(无法登录，弃用), telegram-desktop-bin-dev
* 词典：goldlendict
* 网盘：nutstore<sup>AUR</sup>
* 网络管理前端： network-manager-applet

# 网络
* networkmanger
* network-manager-applet(nm-applet)
* gnome-keyring (否则无法连接至加密的无线网络)

注意 networkmanger 与 netctl 冲突， 因此安装 networkmanger 后要在 systemctl disable netclt 的服务

## 校园网
* mentohust

## 开启热点
[createap 脚本](https://wiki.archlinux.org/index.php/Software_access_point)

## Wine TMQQ-2013
为什么 winetrick 不管用... 安装时总是提示 该verb 已存在  

安装:
* wine
* winetrick
* lib32-ncurses
* lib32-mpg123
* [邓攀打包的TM2013](http://www.zhihu.com/question/23770274/answer/45703773) (似乎该配置的我都自己配置了)
* winetrick riched20 ie6 mfc42 cjkfonts

## SSH
保持连接：

```
Host *
ServerAliveInterval 30
```

对不同网站指定不同的私钥：
```
Host gitcafe.com www.gitcafe.com
    IdentityFile ~/.ssh/gitcafe.private

Host github.com www.github.com
    IdentityFile ~/.ssh/github.private
```

# 声音
## 禁用蜂鸣器:
    modprobe -r pcspkr # 禁用一次

在`/etc/modprobe.d/modprobe.conf`中，加入`blacklist pcspkr` # 永久禁用

## ALSA
参见 [ALSA](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture)

ALSA 默认已经安装，只是所有声道被静音。

需要做的有：
* 将用户加入 `audio` 组 (本地用户默认加入)
* 安装 `alsa-utils` 软件包
* 执行 `alsamixer`， 标有 MM 的声道是静音的，按 M 键解除
* 启动服务 `alsa-restore.service`

# 显示
## 屏幕
参见 [Multihead](https://wiki.archlinux.org/index.php/Multihead)

安装 `xorg-xrandr` 软件包，其中包含 `xrandr` 工具可用来设置各显示器的参数

```shell
xrandr --output VGA-0 --auto --output LVDS --auto --right-of VGA-0
```

另外有前端 arandr 和 drandr<sup>AUR</sup> 可用。

# Pacman
* 更新数据库: `pacman -Syy`
* 滚: `pacman -Syu`
* 不升级软件包: `/etc/pacman.conf` 中 `IgnoreGroup = package_name`
* 递归删除软件包及所有依赖该包的程序: `pacman -Rsc package_name`
* 删除软件包但不删除依赖该包的其他程序: `pacman -Rdd package_name`
* 检查未安装软件包中的文件列表: `pkgfile`
* 回滚某个包: `pacman -R package_name`, 到`/var/cache/pacman/pkg/`中寻找其旧版本并忽略该包的升级

# 字体
用户的自定义设置在 `$XDG_CONFIG_HOME/.config/fontconfig/fonts.conf` 中。

在线生成配置： [Fontconfig Designer](http://wenq.org/cloud/fcdesigner_local.html#`)

# 电源
使用 systemd 管理, **没有** 安装 `acpi` 或 `pm-utils`.

## 合盖
合盖问题在双屏情况下无法复现, 暂时忽略

## 睡眠
默认配置下使用 `systemctl suspend` 表现正常

## 休眠
需要稍作配置, 参见 [Hibernation](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation)

1. 需要一个 swap 分区, 如果 swap 分区大小小于 RAM 大小, 请增大 swap 分区, 或者减小  `/sys/power/image_size`, 对于使用 swap file 的情况不讨论
2. 在 bootloader 中增加一个内核参数 `resume=/dev/sdxY` (sdxY 是 swap 分区的名字), 代表从哪个分区 resume. 对于 grub2, 编辑 `/etc/default/grub` 文件中的 `GRUB_CMDLINE_LINUX_DEFAULT` 参数, 本次编辑如下:
    ```patch
    - GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
    + GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=/dev/sda5"
    ```
新 grub 配置 `grub-mkconfig -o /boot/grub/grub.cfg`

3. 配置 initramfs, 编辑 `/etc/mkinitcpio.conf` 中的 `HOOKS` 参数, 在 `udev` 后增加 `resume`, 改动如下:
    ```patch
    - HOOKS="base udev autodetect modconf block filesystems keyboard fsck"
    + HOOKS="base udev resume autodetect modconf block filesystems keyboard fsck"
    ```
    重新生成 initramfs 镜像: `mkinitcpio -p linux`

4. 现在可以使用 `systemctl hibernate` 休眠了

另, 将按下电源键的动作绑定为休眠: 编辑 `/etc/systemd/logind.conf` 中 HandlePowerKey=hibernate

# 虚拟化
## Virtual Box
1. 安装软件包 `virtualbox` `virtualbox-host-modules` 后者包含了默认内核使用的内核模块。
2. 加载内核模块： 需要加载的模块有 `vboxdrv` `vboxnetadp` `vboxnetflt` 和 `vboxpci`。
    * 手动加载：`modprobe module_name`
    * 开机自动加载： 建立 `/etc/modules-load.d/vbox.conf`， 每个模块名为一行。

3. 添加用户到 `vboxusers` 组： ``gpasswd -a `whoami` vboxusers``
4. 为 guest 安装增强功能： 崔土豪说增强功能的光盘在包 `virtualbox-guset-iso` 中，然而装了没有用，直接根据 VirtualBox 的提示从网上下载了。

# 数据库
## MySQL
### 安装
参见 [MySQL](https://wiki.archlinux.org/index.php/MySQL_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

使用 arch 官方推荐的开源实现 MariaDB：安装 `mariadb` `mariadb-clients` `libmariadbclient`

安装后运行命令：

```shell
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mysqld
sudo mysql_secure_installation  # 运行安装脚本
systemctl restart mysqld
```

### 配置
配置文件之一在 `/etc/mysql/my.cnf`

* 禁用远程登录：取消注释配置文件中 `skip-networking` 一行；
* 自动补全： 将配置文件中的 `no-auto-rehash` 一行替换为 `auto-rehash`，并在启动客户端时加上 `--auto-rehash` 选项；

#### Python Support
安装 `python-mysql-connector`，作用于 Python 3.5

测试代码：

```python
#!/usr/bin/python
import mysql.connector as mariadb

mariadb_connection = mariadb.connect(user='user_name', password='root_psw', database='db_name')
cursor = mariadb_connection.cursor()

cursor.execute("SELECT * FROM table_name")

for i in cursor:
    print(i)

mariadb_connection.close()
```

# 现存的问题
- [x] 错误的 fstab：已改正
- [ ] 光驱莫名弹出
- [ ] A 卡驱动的 `UVD clock timeout`
- [x] 无法休眠：遵循 Wiki 配置，依然有机率唤醒失败。
- [x] 字体渲染：遵循 Wiki 配置。
- [x] 键盘调节音量： pnmixer 自带我竟然不知道。
- [ ] 单屏幕合盖后屏幕闪烁
- [ ] 换一个 IRC 客户端
- [ ] haskell 包安装卸载时提示的 warnning 和 error
- [x] wine qq 只能在一个屏幕上运行：勉强解决，使用 wine 的虚拟桌面可破。
- [x] 无线热点： AUR 脚本 `create_ap`
