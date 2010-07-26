# Class: puppet::foreman::externalnodes.pp
#
# Installs Foreman and configures Puppet for Foreman support as External Node classifier
#
# Usage for Foreman WITH external nodes support
# include puppet::foreman::externalnodes
#
class puppet::foreman::externalnodes inherits puppet::foreman {

    include foreman

    File["puppet.conf"] {
            content => template("puppet/foreman/externalnodes/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

}

