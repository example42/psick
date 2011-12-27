Puppet module: iptables

# Written by Alessandro Franceschi / Lab42 #
# http://www.Example42.com

Licence: Apache2

DESCRIPTION:
This module manages iptables.
In order to have functionality and flexibility some design decisions have been enforced:
- Rules are based on a iptables-save format file. 
- On RedHat/Centos systems it has been followed the standard iptables service approach
- On Debian/Ubuntu the same approach is achived via the iptables-persistent package
- Custom firewall solutions and builders are ignored or disabled (Shorewall, Ufw...) 

The rules configuration can be made in two ways:
- Providing custom static files
- Buldind up rules files with concat (this is the default choice and allows
  dynamic automatic firewalling rules with Example42 firewall extension)

The default firewalling layout follows this approach:
- Default policy is ACCEPT (to permit reachability in case of errors)
- Last rule of every chain is a DENY as defined by $iptables_block_policy
- Intermediate rules are generally ACCEPTs 
- Localhost and established traffic is ALLOWED

All the variables used in this module are defined in the iptables::params class

Customizations for different projects and logic on how to populate configuration
files should be placed in the $my_project classes.

MODULE'S SPECIFIC USER VARIABLES:
$iptables_config # Define how you want to manage the iptables file:
             # "file" - To provide it as a normal static file
             # "concat" - To build it up using different fragments (default)
             #            Note that this is required if you want to use the
             #            Example42 auto firewalling features
             #            Note also that all the following variables are used
             #            only in concat mode
$iptables_block_policy # Define what to do with packets not expressively accepted:
                       # "drop" (Default) - DROP them silently
                       # "reject" - REJECT them with ICMP unreachable
                       # "accept" - ACCEPT them (Beware, if you do this you have no firewall :-)
$iptables_icmp_policy # Define what to to with ICMP packets
                     # "drop" - DROP them all
                     # "safe" - ALLOW all ICMP types except echo & reply (Ping) 
                     # "accept" (Default) - ACCEPT them all
$iptables_output_policy # Define what to to with outbound packets
                     # "drop" - DROP them (except for established and localhost traffic)
                     # "accept" (Default) - ACCEPT them 
$iptables_log # Define what you what to log (all|dropped|none)
$iptables_log_level # Define the level of logging (numeric or see syslog.conf(5))
$iptables_safe_ssh # Define if you want to force the precence of a rule that allows access to 
                   # SSH port (tcp/22). Default "yes". Note that ssh::firewall class opens
                   # it by itself, so this is not needed if you use Example42 modules with 
                   # firewall extended class support.
$iptables_broadcast_policy # Define what to do with INPUT broadcast packets
                           # "drop" - Treat them with the $iptables_block_policy 
                           # "accept" (Default) - Expressely ACCEPT them
$iptables_multicast_policy # Define what to do with INPUT multicast packets
                           # "drop" - Treat them with the $iptables_block_policy
                           # "accept" (Default) - Expressely ACCEPT them

USAGE:
# Standard Classes 
include iptables              # Install and run iptables 

include iptables::disable     # Disable iptables service.
include iptables::debug       # Used for debugging purposes (not resource hungry)
                         # Automatically included if $debug=yes
                         # Requires Example42's puppet::params and puppet::debug

# Module specific defines
iptables::rule # Inserts and iptables rule (works only if you use concat mode)

EXAMPLES:
include iptables # Just including the iptables class sets up a local firewall that:
                 # - Allows SSH access
                 # - Allows ping and all ICMP packets
                 # - Allows localhost and established traffic
                 # - Allows outbound traffic
                 # - Allows multicast and broadcast traffic
                 # - Block everything else

include iptables::disable # Disables the firewall


EXAMPLE42 GENERAL VARIABLES:
Example42 modules collection uses some general variables that can influence the
behaviour of this module. You can happily live without considering or setting them,
but they can be useful to get many useful features out of the box.
$my_project - If set, permits you to alter and customize the module behaviour
  and files's deploy logic in custom project classes than can be placed in a separated module.   
$base_source - Lets you define an alternative source for static files:
  - $base_source not set -> Files are looked in puppet://$servername/ (the PuppetMaster)
  - $base_source set -> Files are in $base_source ( Ex: puppet://$servername/$my_module ) 
  Note that the module automatically manages the different paths for Puppet pre 0.25
$debug - If set to yes writes in /var/lib/puppet/debug/ useful debugging info

DEPENDENCIES:
Standard classes generally don't need external modules.
Extended classes need the relevant external modules and the Example42 "common" module.
iptables::conf generic infile configuration define needs the Example42 "common" module


OPERATING SYSTEMS SUPPORT (Planned, Development, Testing, Production):
RedHat/Centos 5 : Testing
RedHat/Centos 6 : Testing
Debian 5        : Testing
Debian 6        : Planned
Ubuntu 8.04     : Testing
Ubuntu 10.04    : Testing
SLES 10         : Planned
SLES 11         : Planned
