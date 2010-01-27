define collectd::plugin( $collectd_server='127.0.0.1' , collectd_port='25826' , collectd_forward='false' ) {

	$collectd_configdir = $operatingsystem ? { 'debian' => "/etc/collectd", default => "/etc" }

	include collectd

        file {
                "${collectd_configdir}/collectd.d/${name}.conf":
                        content => template("collectd/plugins/${name}.conf"),
                        notify => Service['collectd'],
                        require => File["collectd.d"],
			ensure  => present,
        }
}
