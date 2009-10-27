# General Nodes default settings.
# Definition of generic classes, that include the modules that have to be added to each host:
# minimal : Minimal settings, enough to run Puppet
# general : General usage baseline. 
# hardened : Hardened settings on a minimal or general base. 


class minimal {
# This class includes only what is necessary to run Puppet

# NETWORKING
# Network configuration. Customize and uncomment to manage IP configs via Puppet 
#	include network
# Management of file /etc/hosts 
	include hosts
# DNS resolver
# Requires: $my_dns_servers
	include resolver

	
# PUPPET CLIENT SETTINGS 
# Some alternatives (TO DO):
# Default puppet service startup
	include puppet
# No puppet daemon. Run puppetd via cron.
# 	include puppet::cron
# Runs puppet service with slow connection rates. 
# 	include puppet::slow
# Puppet daemon with puppetrun enabled
#	include puppet::run



# PACKAGE MANAGEMENT
# Package management can be done with "repo" OR "yum" class
# Both provide ready to use public repos for Centos 5
# Customization is needed if you use different distros or repo sources

# repo class uses simple static repo files in case you prefer to
# (you may enhance with templating). Defaults use public repositories.
# Include base repo or alternatively the epel OR rpmforce extra repos
#	include repo
#	include repo::epel
#	include repo::rpmforge
# 	include repo::rpmforge

# As ALTERNATIVE you can use the imported yum class (Copyright (C) 2007 admin@immerda.ch)
# It uses the yumrepo type (somehow more enginereed but more flexible)
# Default settings include various public repos (some are not enabled by default)
#	 include yum

}

