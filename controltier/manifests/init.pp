# Class: controltier
#
# Manages controltier.
# Include it to install and run controltier with default settings
#
# Usage:
# include controltier
#
class controltier {

# Fix for not autoload
#    import "client/*.pp"
#    import "server/*.pp"

    # Load the variables used in this module. Check the params.pp file
    require controltier::params

    if "${controltier::params::server}" == "$fqdn" { include controltier::server }
    else { include controltier::client }

}
