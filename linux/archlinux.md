#����
* xmonad
* xmobar (״̬��)
* dmenu (������)
* ~~trayer~~ ��֧�ֶ���Ļ, ����.
* trayer-srg(AUR) (����)
* feh (���汳��)
* xscreensaver (��������)
* scrot (��ͼ)
* lxappearance (gtk ��������) | gtk-chtheme
* qtconfig-qt4

#����
* networkmanger 
* network-manager-applet(nm-applet)
* gnome-keyring (�����޷����������ܵ���������)
ע�� networkmanger �� netctl ��ͻ�� ��˰�װ networkmanger ��Ҫ�� systemctl disable netclt �ķ���

##У԰��
* mentoHUST

##�����ȵ�
[createap �ű�](https://wiki.archlinux.org/index.php/Software_access_point)

##Wine TMQQ-2013
Ϊʲô winetrick ������... ��װʱ������ʾ ��verb �Ѵ���
��װ:
* wine
* winetrick
* lib32-ncurses
* lib32-mpg123
* [���ʴ����TM2013](http://www.zhihu.com/question/23770274/answer/45703773)
  (�ƺ������õ��Ҷ��Լ�������)
* winetrick riched20 ie6 mfc42 cjkfonts

#����

##���÷�����: 
    modprobe -r pcspkr # ����һ��
��`/etc/modprobe.d/modprobe.conf`�У�����`blacklist pcspkr` # ���ý���

##ALSA
[ALSA](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture)
ALSA Ĭ���Ѿ���װ��ֻ������������������

��Ҫ�����У�
* ���û����� `audio` �� (�����û�Ĭ�ϼ���)
* ��װ `alsa-utils` �����
* ִ�� `alsamixer`�� ���� MM �������Ǿ����ģ��� M ����� 
* �������� `alsa-restore.service`

#�ļ�����

##����
* mlocate 

##����
* �����(AUR)

#��ʾ

##��Ļ
[Multihead](https://wiki.archlinux.org/index.php/Multihead)
��װ `xorg-xrandr` ����������а��� `xrandr` ���߿��������ø���ʾ���Ĳ���
    xrandr --output VGA-0 --auto --output LVDS --auto --right-of VGA-0

#�ʵ�
[goldendict](http://blog.yuanbin.me/posts/2013/01/goldendictxia-san-da-you-zhi-ci-ku-shi-yong-xiao-ji.html)

#Pacman
* �������ݿ�: `pacman -Syy`
* ��: `pacman -Syu`
* �����������: `/etc/pacman.conf` �� `IgnoreGroup = package_name`
* �ݹ�ɾ������������������ð��ĳ���: `pacman -Rsc package_name`
* ɾ�����������ɾ�������ð�����������: `pacman -Rdd package_name`
* ���δ��װ������е��ļ��б�: `pkgfile`
* �ع�ĳ����: `pacman -R package_name`, ��`/var/cache/pacman/pkg/`��Ѱ����ɰ汾�����Ըð�������

#����
�û����Զ��������� `$XDG_CONFIG_HOME/.config/fontconfig/fonts.conf` �С�
�����������ã� [Fontconfig Designer](http://wenq.org/cloud/fcdesigner_local.html#`)

#��Դ
ʹ�� systemd ����, **û��**��װ `acpi` �� `pm-utils`.

##�ϸ�
�ϸ�������˫��������޷�����, ��ʱ����

##˯��
Ĭ��������ʹ�� `systemctl suspend` ��������

##����
��Ҫ��������, �μ�:
[Hibernation](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation)
1. ��Ҫһ�� swap ����, ��� swap ������СС�� RAM ��С, ������ swap ����, ���߼�С  `/sys/power/image_size`, ����ʹ�� swap file �����������
2. �� bootloader ������һ���ں˲��� `resume=/dev/sdxY` (sdxY �� swap ����������), ������ĸ����� resume. ���� grub2, �༭ `/etc/default/grub` �ļ��е� `GRUB_CMDLINE_LINUX_DEFAULT` ����, ���α༭����:
```
- GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+ GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=/dev/sda5"
```
���� grub ���� `grub-mkconfig -o /boot/grub/grub.cfg`
3. ���� initramfs, �༭ `/etc/mkinitcpio.conf` �е� `HOOKS` ����, �� `udev` ������ `resume`, �Ķ�����:
```
- HOOKS="base udev autodetect modconf block filesystems keyboard fsck"
+ HOOKS="base udev resume autodetect modconf block filesystems keyboard fsck"
```
�������� initramfs ����: `mkinitcpio -p linux`
4. ���ڿ���ʹ�� `systemctl hibernate` ������

��, �����µ�Դ���Ķ�����Ϊ����: �༭ `/etc/systemd/logind.conf` �� HandlePowerKey=hibernate 

#�ִ������
- [ ] ����� fstab
- [ ] ����Ī������
- [ ] A �������� `UVD clock timeout`
- [x] �޷����ߣ���ѭ Wiki ���ã���Ȼ�л��ʻ���ʧ�ܡ�
- [x] ������Ⱦ����ѭ Wiki ���á�
- [x] ���̵��������� pnmixer �Դ��Ҿ�Ȼ��֪����
- [ ] ����Ļ�ϸǺ���Ļ��˸
- [ ] ��һ�� IRC �ͻ���
- [ ] haskell ����װж��ʱ��ʾ�� warnning �� error
- [ ] wine qq ֻ����һ����Ļ������
- [x] �����ȵ㣺 AUR �ű� `create_ap`
