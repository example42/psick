# Some specific 

class oracle::debian {

    require oracle::params

    file { "/bin/awk":
        ensure => "/usr/bin/awk",
    }

    file { "/bin/rpm":
        ensure => "/usr/bin/rpm",
    }

    file { "/bin/basename":
        ensure => "/usr/bin/basename",
    }

    file { "/etc/rc.d":
        ensure => "/etc",
    }


}
