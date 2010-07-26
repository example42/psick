# Class: puppet::foreman
#
# Installs Foreman and configures Puppet for Foreman support
#
# Usage for Foreman without external nodes support
# include puppet::foreman 
#
# Usage for Foreman WITH external nodes support
# include puppet::foreman::externalnodes 
#
# Compatibility: RedHat/Centos
#
class puppet::foreman inherits puppet::master {

    include foreman

    File["puppet.conf"] {
        content => template("puppet/foreman/puppet.conf.erb"),
        notify  => Service["puppetmaster"],
    }

}

