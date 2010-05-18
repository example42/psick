# plugin.pp - configure a specific munin plugin
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.
# adapted and improved by admin(at)immerda.ch

### defines

define munin::plugin (
    $ensure = "present",
    $script_path_in = '',
    $config = '')
{
    include munin::plugin::scriptpaths
    $real_script_path = $script_path_in ? { '' => $munin::plugin::scriptpaths::script_path, default => $script_path_in }

    $plugin_src = $ensure ? { "present" => $name, default => $ensure }
    $plugin = "/etc/munin/plugins/$name"
    $plugin_conf = "/etc/munin/plugin-conf.d/$name.conf"
    case $ensure {
        "absent": {
            file { $plugin: ensure => absent, }
        }
        default: {
        case $operatingsystem {
        openbsd: { $basic_require = File['/var/run/munin'] }
        suse: { $basic_require = Package['munin'] }
        default: { $basic_require = Package['munin-node'] }
        }
        if $require {
        $real_require = [ $require, $basic_require ]
        } else {
        $real_require = $basic_require
        }
            file { $plugin:
            ensure => "${real_script_path}/${plugin_src}",
                require => $real_require,
                notify => Service['munin-node'];
            }

        }
    }
    case $config {
        '': {
            file { $plugin_conf: ensure => absent }
        }
        default: {
            case $ensure {
                absent: {
                    file { $plugin_conf: ensure => absent }
                }
                default: {
                    file { $plugin_conf:
                        content => "[${name}]\n$config\n",
                        mode => 0644, owner => root, group => 0,
                    }
            if $require {
            File[$plugin_conf]{
                require +> $require,
            }
            }
                }
            }
        }
    }
}
