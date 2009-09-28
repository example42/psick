# Define your infrastructure logic according to your needs

# Here an example for a general layout
# CHANGE EXAMPLE VARIABLES!
# Move or redefine variables accounding to a single inheritance tree (Ex: yournode inherits prod inherits basenode)
# Here zoneironments are generally related to different networks / host position

node basenode {
        $my_project = "example42"

	$my_puppet_server = "kick.lab42.it"
        $my_timezone = "Europe/Rome"
        $my_ntp_server = "time.example42.com"
        $my_domain = "example42.com"
        $my_dns_servers = ["10.42.10.10","213.215.150.198"]

        $my_extrarepo = "epel"

        $my_dhcp_range = "10.42.10.100 10.42.10.199"

	$my_update = "no"   # Auto Update packages (yes|no)
	$my_root_email = "roots@example42.com" # Noc Email
        $my_syslog_servers = ["syslog.example42.com"]
}

# Example Development / Staging / Production Infrastructure

node devel inherits basenode {
        $my_zone = "devel"
        $my_local_network = "10.42.42.0/24"
	$my_network = "10.42.42.0"
	$my_netmask = "255.255.255.0"
        $my_default_gateway = "10.42.42.1"
        $my_dhcp_range = "10.42.42.100 10.42.42.199"
}

node test inherits basenode {
	$my_network = "10.42.42.1"
	$my_netmask = "255.255.255.0"
        $my_local_network = "10.42.91.0/24"
        $my_default_gateway = "10.42.91.1"
        $my_zone = "test"
}

node management inherits basenode {
	$my_network = "10.42.100.0"
	$my_netmask = "255.255.255.0"
        $my_local_network = "10.42.100.0/24"
        $my_default_gateway = "10.42.100.1"
        $my_zone = "management"
}

node frontend inherits basenode {
	$my_network = "10.42.101.0"
	$my_netmask = "255.255.255.0"
        $my_local_network = "10.42.101.0/24"
        $my_default_gateway = "10.42.101.1"
	$my_update = "yes" # Overrides previosly defined settings
        $my_zone = "frontend"
}

node backend inherits basenode {
	$my_network = "10.42.102.0"
	$my_netmask = "255.255.255.0"
        $my_local_network = "10.42.102.0/24"
        $my_default_gateway = "10.42.102.1"
        $my_zone = "backend"
}


# Example Office Infrastructure

node intranet inherits basenode {
        $my_local_network = "10.42.0.0/24"
        $my_zone = "intranet"
}

node remotebranch inherits basenode {
        $my_local_network = "10.42.10.0/24"
        $my_zone = "remotebranch"
}

node dmz inherits basenode {
        $my_local_network = "10.42.1.0/24"
        $my_zone = "dmz"
}

