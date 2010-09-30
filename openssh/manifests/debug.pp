#
# Class: openssh::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class openssh::debug {

    # Load the variables used in this module. Check the params.pp file 
    require openssh::params
    include puppet::params

    file { "puppet_debug_variables_openssh":
        path    => "${puppet::params::debugdir}/variables/openssh",
        mode    => "${openssh::params::configfile_mode}",
        owner   => "${openssh::params::configfile_owner}",
        group   => "${openssh::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("openssh/variables_openssh.erb"),
    }

}
