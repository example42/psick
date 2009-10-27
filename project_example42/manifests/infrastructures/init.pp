# Here you find some example Puppet infrastructures templates.

# There can be many approaches:
# - Nodes are defined in an inheritance tree (basenode -> my_zones -> node),
# with different custom "zones" used to group nodes according to custom needs. 
# - Nodes don't inherit a basenode or another node, they include/define all the variables and 
#   resources they need. They can include custom classes that define settings
#   according to the preferred logic, eventually based on facts
# - Every single node defines / includes what it needs (suitable only for small infrastructures) 

# The files included in infrastructures/ are different examples, based on the above logics.

# This file is necessary in EVERY CASES (it defines Puppet's default basenode)
# basenode.pp

# An example of Development / Staging / Production Infrastructure  

# CHANGE EXAMPLE VARIABLES!
# Move or redefine variables accounding to a single inheritance tree (Ex: yournode inherits prod inherits basenode)
# Here zones are generally related to different networks / host position

# Example Development / Staging / Production Infrastructure

node devel inherits basenode {
        $my_zone = "devel"
        $my_dns_servers = ["10.42.42.1","192.168.0.3"]
        $my_local_network = "10.42.42.0/24"
        $my_default_gateway = "10.42.42.1"
        $my_dhcp_range = "10.42.42.100 10.42.42.199"
}

node test inherits basenode {
	$my_network = "10.42.0.0"
	$my_netmask = "255.255.255.0"
        $my_local_network = "10.42.0.0/24"
        $my_default_gateway = "10.42.0.1"
        $my_zone = "test"
}

node prod inherits basenode {
	$my_network = "10.42.10.0"
	$my_netmask = "255.255.255.0"
        $my_local_network = "10.42.10.0/24"
        $my_default_gateway = "10.42.10.1"
        $my_zone = "prod"
}


# Example of a 2 layer production with management network
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

