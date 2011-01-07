# Class: drupal::firewall
#
# Manages drupal firewalling using custom Firewall wrapper
# By default it opens drupal's default port(s) to anybody
# It's automatically included if $firewall=yes
#
# Usage:
# Automatically included if $firewall=yes 
#
class drupal::firewall {

    include drupal::params

    firewall { "drupal_${drupal::params::protocol}_${drupal::params::port}":
        source      => "${drupal::params::firewall_source_real}",
        destination => "${drupal::params::firewall_destination_real}",
        protocol    => "${drupal::params::protocol}",
        port        => "${drupal::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "${drupal::params::firewall_enable}",
    }

}
