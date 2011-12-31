class ntp::example42 inherits ntp {
#    File["ntp.conf"] {
#        content => template('example42/ntp/ntp.conf.erb'),
#    }
}

class ntp::example42::monitor {

}

