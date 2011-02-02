# Class: tomcat::firewall
#
# Manages tomcat firewalling using custom Firewall wrapper
# By default it opens tomcat's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class tomcat::firewall {

    include tomcat::params

    firewall { "tomcat_${tomcat::params::protocol}_${tomcat::params::port}":
        source      => "${tomcat::params::firewall_source_real}",
        destination => "${tomcat::params::firewall_destination_real}",
        protocol    => "${tomcat::params::protocol}",
        port        => "${tomcat::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${tomcat::params::firewall_enable}",
    }

}
