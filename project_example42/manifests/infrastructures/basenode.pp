# Here's defined the baseline node (note that this is a Puppet default). 
# It can be empty if wanted.
# Here we use it to define general variables: they can be overriden by
# nodes that inherit basenode 

node basenode {
# Example42 approach permits to manage different projects (puppet nodes configurations) by the same puppetmaster:
# Different Puppet environments can map to different project modules.
        $my_project = "example42"

        $my_puppet_server = "puppet.example42.com"
        $my_dns_servers = ["10.42.42.1","10.42.10.1"]
        $my_domain = "example42.com"
        $my_smtp_server = "mail.example42.com"

# Local root mail is forwarded to $my_root_email - CHANGE IT!
        $my_root_email = "roots@example42.com"

# Syslog servers. Can be an array.
        $my_syslog_servers = ["10.42.42.15"]


        $my_timezone = "Europe/Rome"
        $my_ntp_server = "ntp.example42.com"

        $my_update = "no"   # Auto Update packages (yes|no)

# Munin central server
	$munin_allow = "10.42.42.9"

# Collectd Central server (here we use unicast networking)
# Define the server IP (not the hostname)
	$collectd_server = "10.42.42.9"

}

