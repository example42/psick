class puppet::dashboard inherits puppet::master {

        File["puppet.conf"] {
                        content => template("puppet/dashboard/puppet.conf.erb"),
                        notify  => Service["puppetmaster"],
        }

}

class puppet::dashboard::externalnodes inherits puppet::dashboard {

        File["puppet.conf"] {
                        content => template("puppet/dashboard/externalnodes/puppet.conf.erb"),
                        notify  => Service["puppetmaster"],
        }

}

