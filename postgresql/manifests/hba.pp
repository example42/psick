# This define APPENDS a line entry to the pg_hba.conf file
#
define postgresql::hba ( $ensure='present', $order="50", $type, $database, $user, $address=false, $method, $option="" ) {

    include postgresql::params
    include concat::setup
    include postgresql::hbaconcat

    concat::fragment{ "hba_fragment_$name":
        target  => "${postgresql::params::configfilehba}",
        content => $type ? { 
            "local" => "${type}	${database}	${user}	${method}	${option}\n",
            default => "${type}	${database}	${user}	${address}	${method}	${option}\n",
        },
        order   => $order,
        ensure  => $ensure,
        notify  => Service["postgresql"],
    }

}
