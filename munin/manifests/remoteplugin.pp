define munin::remoteplugin($ensure = "present", $source, $config = '') {
    case $ensure {
        "absent": { munin::plugin{ $name: ensure => absent } }
        default: {
            file {
                "/var/lib/puppet/modules/munin/plugins/${name}":
                    source => $source,
                    mode => 0755, owner => root, group => 0;
            }
            munin::plugin { $name:
                ensure => $ensure,
                config => $config,
                script_path_in => "/var/lib/puppet/modules/munin/plugins",
            }
        }
    }
}

