#
# Class: rsync::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class rsync::debug {

    # Load the variables used in this module. Check the params.pp file 
    require rsync::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_rsync":
        path    => "${puppet::params::debugdir}/variables/rsync",
        mode    => "${rsync::params::configfile_mode}",
        owner   => "${rsync::params::configfile_owner}",
        group   => "${rsync::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("rsync/variables_rsync.erb"),
    }

}
