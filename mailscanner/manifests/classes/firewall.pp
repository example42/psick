# Class: mailscanner::firewall
#
# Manages mailscanner firewalling using custom Firewall wrapper
# By default it opens mailscanner's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include mailscanner::firewall
#
class mailscanner::firewall {

}
