# Define: nagios::plugin
#
# Adds a custom Nagios plugin
#
# Usage:
# With standard template:
# nagios::plugin { "check_mount": }
#
define nagios::plugin ( $enable="yes" ) {

   include nagios::params

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

   file { "Nagios_plugin_${name}":
        path    => "${nagios::params::pluginsdir}/${name}",
        owner   => root,
        group   => root,
        mode    => 755,
        ensure  => "${ensure}",
        source  => "${nagios::params::general_base_source}/nagios/nagios-plugins/${name}",
   }

}
