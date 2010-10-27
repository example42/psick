define collectd::plugin (ensure = 'present') {

    include collectd::params

    file { "${collectd::params::configdir}/${name}.conf":
            content => template("collectd/plugins/${name}.conf"),
            notify  => Service['collectd'],
            require => File["collectd.d"],
            ensure  => $ensure,
    }

}
