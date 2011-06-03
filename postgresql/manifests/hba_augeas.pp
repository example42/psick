# This define APPENDS a line entry to the pg_hba.conf file
# TODO: Manage order on where to place the line to work well
# with acls orders and default settings
#
define postgresql::hba ( $ensure='present', $type, $database, $user, $address=false, $method, $option=false ) {

    include postgresql::augeas

    case $type {
	'local': {
	    $changes = [ # warning: order matters !
		"set pg_hba.conf/01/type ${type}",
		"set pg_hba.conf/01/database ${database}",
		"set pg_hba.conf/01/user ${user}",
		"set pg_hba.conf/01/method ${method}",
	    ]

	    $xpath = "pg_hba.conf/*[type='${type}'][database='${database}'][user='${user}'][method='${method}']"
	}

	'host', 'hostssl', 'hostnossl': {
	    if ! $address {
		fail("\$address parameter is mandatory for non-local hosts.")
	    }

	    $changes = [ # warning: order matters !
		"set pg_hba.conf/01/type ${type}",
		"set pg_hba.conf/01/database ${database}",
		"set pg_hba.conf/01/user ${user}",
		"set pg_hba.conf/01/address ${address}",
		"set pg_hba.conf/01/method ${method}",
	    ]

	    $xpath = "pg_hba.conf/*[type='${type}'][database='${database}'][user='${user}'][address='${address}'][method='${method}']"
	}

	default: {
	    fail("Unknown type '${type}'.")
	}
    }

    if versioncmp($augeasversion, '0.7.3') < 0 {
	$lpath = "/usr/share/augeas/lenses/contrib/"
    } else {
	$lpath = undef
    }

    case $ensure {
	'present': {
	    augeas { "set pg_hba ${name}":
		context => "/files/var/lib/pgsql/data/",
		changes => $changes,
		onlyif  => "match ${xpath} size == 0",
		notify  => Service["postgresql"],
		require => [Package["postgresql84-server"], File["pg_hba.aug"]],
		load_path => $lpath,
	    }

	    if $option {
		augeas { "add option to pg_hba ${name}":
		    context => "/files/var/lib/pgsql/data/",
		    changes => "set ${xpath}/method/option ${option}",
		    onlyif  => "match ${xpath}/method/option size == 0",
		    notify  => Service["postgresql"],
		    require => [Augeas["set pg_hba ${name}"], File["pg_hba.aug"]],
		    load_path => $lpath,
		}
	    }
	}
	'absent': {
	    augeas { "remove pg_hba ${name}":
		context => "/files/var/lib/pgsql/data/",
		changes => "rm ${xpath}",
		onlyif  => "match ${xpath} size == 1",
		notify  => Service["postgresql"],
		require => [Package["postgresql84-server"], File["pg_hba.aug"]],
		load_path => $lpath,
	    }
	}
	default: {
	    fail("Unknown ensure '${ensure}'.")
	}
    }
}
