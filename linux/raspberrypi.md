Raspberry Pi
================

* 树莓派 1 B+： ￥120
* 无线网卡： ￥29
* HDMI2VGA 转接口：￥20
* SD 卡： ￥19

# 系统安装
## raspbain
参见 [Installing Operating System Images on Linux](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)， 将 raspbian 镜像直接刷进 SD 卡就好了。

```shell
wget http://director.downloads.raspberrypi.org/raspbian/images/raspbian-2015-09-28/2015-09-24-raspbian-jessie.zip
7z e raspbian-2015-05-07/2015-05-05-raspbian-wheezy.zip     # get 2015-09-24-raspbian-jessie.img
# 把 SD 卡插入电脑
df -h
umount /dev/sdxY    # 注意要卸载 SD 卡的 **所有** 分区
dd bs=4M if=2015-09-24-raspbian-jessie.img of=/dev/sdx
# dd 执行后无反馈，等上 5 分钟就好了
```

### 锐捷路由
#### 编译 mentohust
参见 [这里](http://www.cnblogs.com/yefang/p/Raspbian_wireless_network_configuration.html)

```shell
apt-get install libpcap-dev autotools-dev libgtk2.0-dev libscim-dev libtool automake1.9
git clone https://github.com/microcai/mentohust.git
cd mentohust
./autogen.sh
./configure --prefix=/usr
make
sudo make install
```

#### 编译配置无线网络
参见 [这里](http://wangye.org/blog/archives/845/)  
[How to Set up a Raspberry Pi as a Wireless Access Point](https://www.maketecheasier.com/set-up-raspberry-pi-as-wireless-access-point/) 也值得参考，但是里面 isc-dhcp-server 的配置我没有成功……

1. 使用 hostapd 开启无线热点，我的网卡不支持 `nl80211` 的驱动，请使用编译好 `rtl871xdrv`驱动的 hostapd 版本，详见上面的链接
2. 使用 udhcpd 做 dhcp 服务器，似乎 udcpd 的服务必须晚于 hostapd 启动才行，于是手动在 `/etc/rc.local` 启动 udcpd 服务了
3. 设置有线网卡和无线网卡间的转发： iptable

## archlinux-armo
参见：[Raspberry Pi | Arch Linux ARM](https://archlinuxarm.org/platforms/armv6/raspberry-pi)

gpio: 安装 `alarm/wiringpi`

### 锐捷路由
`mentohust` + `create_ap` 即可
