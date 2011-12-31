# Define: munin::pluginconf
#
# Basic munin plugin configuration management
#
# Usage:
# munin::pluginconf { "apache": }
#
define munin::pluginconf ( ) {

    require munin::params

    file { "MuninPluginConf_$name":
        path => "${munin::params::plugins_includedir}/$name",
        source => [
            "puppet:///modules/munin/munin-plugins.conf/$name--$hostname",
            "puppet:///modules/munin/munin-plugins.conf/$name-$role-$type",
            "puppet:///modules/munin/munin-plugins.conf/$name-$role",
            "puppet:///modules/munin/munin-plugins.conf/$name"
        ],
        owner => "root",
        group => "root",
        mode  => 640,
    }

}
