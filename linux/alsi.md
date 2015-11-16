alsi 无法识别 Window Manager
====
识别 WM 的相关代码如下:

```perl
my $config_dir = $ENV{XDG_CONFIG_HOME} || "$home_dir/.config";
my $alsi_config_dir = "$config_dir/$appname";
...
WM_FILE              => "$alsi_config_dir/alsi.wm",
DE_FILE              => "$alsi_config_dir/alsi.de",
...
my $wm = do $CONFIG{WM_FILE};
my $de = do $CONFIG{DE_FILE};
...
my $wm_de = ['Window Manager', "Unknown"];
open my $ps_pipe, '-|', $CONFIG{PS_COMMAND};
while (defined(my $process = <$ps_pipe>)) {
    $process = (split(' ', $process))[-1];
    if (exists $de->{$process}) {
        $wm_de = ['DE', $de->{$process}];
        last;
    }
    elsif (
        exists $wm->{$process} or (
            substr($process, -8) eq '-session' and exists $wm->{
                do { $process =~ s/-session$//; $process }
            }
        )
      ) {
        $wm_de = ['WM', $wm->{$process}];
        last;
    }
}
```

Perl 的语法实在奇怪, 大概是将 `PS_COMMAD`('ps -A') 执行结果输到 `$ps_pipe` 变量里, 遍历所有进程, 然后用进程名查 表($wm 或者 $de), 表里储存着进程名和 wm/de 之间的对应关系.

两个表储存在 `~/.config/alsi` 下.

所以找到 `xmonad` 那一项, 把左边的索引改成本机上 xmonad 的进程名就好了.

