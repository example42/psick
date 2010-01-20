define collectd::conf($value) {

		config  {
			"collectd.conf-$name":
				file => $operatingsystem ? {
                          		debian  => "/etc/collectd/collectd.conf",
	                                default => "/etc/collectd.conf",
				},
				line => "$name $value",
				pattern => $name,
				engine => "line",
		}

}
