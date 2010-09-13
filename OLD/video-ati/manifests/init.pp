class video-ati {

    package { xorg-x11-drv-radeonhd:
        name => $operatingsystem ? {
            default    => "xorg-x11-drv-radeonhd",
            },
        ensure => present,
    }

    file {    
             "/etc/X11/xorg.conf":
            mode => 644, owner => root, group => root,
            require => Package[xorg-x11-drv-radeonhd],
            ensure => present,
            path => $operatingsystem ?{
                default => "/etc/X11/xorg.conf",
            },
            source => "puppet://$servername/video-ati/xorg.conf",
    }

}
