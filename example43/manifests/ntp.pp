class ntp::example43 inherits ntp {
#    File["ntp.conf"] {
#        content => template('example43/ntp/ntp.conf.erb'),
#    }
}

class ntp::example43::monitor {

}

