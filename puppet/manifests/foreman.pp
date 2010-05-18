class puppet::foreman inherits puppet::master {

    File["puppet.conf"] {
            content => template("puppet/foreman/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

}

class puppet::foreman::externalnodes inherits puppet::foreman {

    File["puppet.conf"] {
            content => template("puppet/foreman/externalnodes/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

}
