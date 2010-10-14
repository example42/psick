#
# Class: mcollective
#
# Manages mcollective.
# Include it to install and run mcollective
# It defines package, service, main configuration file.
#
# Usage:
# include mcollective
#
class mcollective {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective::params

    # Autoloads server class. This is done by default.
    # To install a mcollective client without the server components 
    # Set $mcollective_client to "yes" and $mcollective_server to "no"
    if ( $mcollective_server != "no") { include mcollective::server }

    # Include debug class is debugging is enabled ($debug=yes)
    # Autoloads client class if $mcollective_client is "yes"
    if ( $mcollective_client == "yes") { include mcollective::client }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include mcollective::debug }

}
