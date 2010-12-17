# Define: munin::plugin
#
# Adds a custom Munin plugin
#
# Usage:
# With standard template:
# munin::plugin { "apache_activity": }
#
define munin::plugin ( $enable="yes" ) {

   include munin::params

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

   file { "Munin_plugin_${name}":
        path    => "${munin::params::pluginsdir}/${name}",
        owner   => root,
        group   => root,
        mode    => 755,
        ensure  => "${ensure}",
        require => Package["munin-node"],
        notify  => Service["munin-node"],
        source  => "${munin::params::general_base_source}/munin/munin-plugins/${name}",
   }

}
