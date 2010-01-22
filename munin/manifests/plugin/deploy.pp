define munin::plugin::deploy($source = '', $ensure = 'present', $config = '') {
    $plugin_src = $ensure ? {
        'present' => $name,
        'absent' => $name,
        default => $ensure
    }
    $real_source = $source ? {
        ''  =>  "munin/plugins/$plugin_src",
        default => $source
    }
    include munin::plugin::scriptpaths
    file { "munin_plugin_${name}":
            path => "$munin::plugin::scriptpaths::script_path/${name}",
            source => "puppet://$server/modules/$real_source",
            mode => 0755, owner => root, group => 0;
    }

    case $kernel {
        openbsd: { $basic_require = File['/var/run/munin'] }
        default: { $basic_require = Package['munin-node'] }
    }
    if $require {
        File["munin_plugin_${name}"]{
            require => [ $basic_require, $require ],
        }
    } else {
        File["munin_plugin_${name}"]{
            require => $basic_require,
        }
    }
    # register the plugin
    if $require {
        munin::plugin{$name: ensure => $ensure, config => $config, require => $require }
    } else {
        munin::plugin{$name: ensure => $ensure, config => $config }
    }
}
