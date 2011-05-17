#
# Class: vagrant::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class vagrant::debug {

    # Load the variables used in this module. Check the params.pp file 
    require vagrant::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_vagrant":
        path    => "${puppet::params::debugdir}/variables/vagrant",
        mode    => "${vagrant::params::configfile_mode}",
        owner   => "${vagrant::params::configfile_owner}",
        group   => "${vagrant::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("vagrant/variables_vagrant.erb"),
    }

}
