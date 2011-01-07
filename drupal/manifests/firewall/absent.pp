# Class: drupal::firewall::absent
#
# Remove drupal firewall elements
#
class drupal::firewall::absent {

    include drupal::params

    firewall { "drupal_${drupal::params::protocol}_${drupal::params::port}":
        source      => "${drupal::params::firewall_source_real}",
        destination => "${drupal::params::firewall_destination_real}",
        protocol    => "${drupal::params::protocol}",
        port        => "${drupal::params::port}",
        action      => "allow",
        direction   => "input",
        enable      => "false",
    }

}
