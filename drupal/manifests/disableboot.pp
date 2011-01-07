# Class: drupal::disableboot
#
# This class disables drupal startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include drupal::disableboot
#
class drupal::disableboot inherits drupal {
    Service["drupal"] {
        enable => "false",
    }
}
