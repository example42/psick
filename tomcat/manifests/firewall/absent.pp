# Class: tomcat::firewall::absent
#
# Remove tomcat firewall elements
#
class tomcat::firewall::absent {

    include tomcat::params

    firewall { "tomcat_${tomcat::params::protocol}_${tomcat::params::port}":
        source      => "${tomcat::params::firewall_source_real}",
        destination => "${tomcat::params::firewall_destination_real}",
        protocol    => "${tomcat::params::protocol}",
        port        => "${tomcat::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
