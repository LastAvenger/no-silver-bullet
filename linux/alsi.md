alsi �޷�ʶ�� Window Manager
====
ʶ�� WM ����ش�������:

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

Perl ���﷨ʵ�����, ����ǽ� `PS_COMMAD`('ps -A') ִ�н���䵽 `$ps_pipe` ������, �������н���, Ȼ���ý������� ��($wm ���� $de), ���ﴢ���Ž������� wm/de ֮��Ķ�Ӧ��ϵ.

���������� `~/.config/alsi` ��.

�����ҵ� `xmonad` ��һ��, ����ߵ������ĳɱ����� xmonad �Ľ������ͺ���.

