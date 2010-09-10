# Class: autofs::firewall
#
# Manages autofs firewalling using custom Firewall wrapper
# By default it opens autofs's default port(s) to anybody
# It's automatically included if $firewall=yes
# Note that it uses fact's based $ipaddress as destination IP
# You may need to change it for natted or multihomed hosts
#
# Usage:
# include autofs::firewall
#
class autofs::firewall {

}
