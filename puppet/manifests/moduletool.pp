# Class: puppet::moduletool
#
# Installs Puppet Module Tool
#
class puppet::moduletool {
    
    package {
        puppet-module:
        provider => "gem",
        ensure => present,
    }
}

