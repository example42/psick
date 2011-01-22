#
# Class bind::redhat
#
# This class provides Bind's default zones
#
class bind::redhat {

    file {
        "named.root":
        path    => "${bind::params::datadir}/named.root",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/named.root" ,
    }

    file {
        "named.zero":
        path    => "${bind::params::datadir}/named.zero",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/named.zero" ,
    }

    file {
        "named.local":
        path    => "${bind::params::datadir}/named.local",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/named.local" ,
    }

    file {
        "named.ip6.local":
        path    => "${bind::params::datadir}/named.ip6.local",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/named.ip6.local" ,
    }

    file {
        "named.broadcast":
        path    => "${bind::params::datadir}/named.broadcast",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/named.broadcast" ,
    }

    file {
        "localdomain.zone":
        path    => "${bind::params::datadir}/localdomain.zone",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/localdomain.zone" ,
    }

    file {
        "localhost.zone":
        path    => "${bind::params::datadir}/localhost.zone",
        mode    => "644" , owner => "root" , group => "root" ,
        require => Package["bind"] , notify  => Service["bind"] ,
        source  => "${bind::params::general_base_source}/bind/default/redhat/localhost.zone" ,
    }

}
