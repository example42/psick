#
# Class: vsftpd::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class vsftpd::debug {

    # Load the variables used in this module. Check the params.pp file 
    require vsftpd::params
    include puppet::params

    file { "puppet_debug_variables_vsftpd":
        path    => "${puppet::params::debugdir}/variables/vsftpd",
        mode    => "${vsftpd::params::configfile_mode}",
        owner   => "${vsftpd::params::configfile_owner}",
        group   => "${vsftpd::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("vsftpd/variables_vsftpd.erb"),
    }

}
