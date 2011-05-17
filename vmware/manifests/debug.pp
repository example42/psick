#
# Class: vmware::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class vmware::debug {

    # Load the variables used in this module. Check the params.pp file 
    require vmware::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_vmware":
        path    => "${puppet::params::debugdir}/variables/vmware",
        mode    => "${vmware::params::configfile_mode}",
        owner   => "${vmware::params::configfile_owner}",
        group   => "${vmware::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("vmware/variables_vmware.erb"),
    }

}
