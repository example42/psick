#
# Class: nagios::cleanup
#
# This is a service class that can be used to clean up and purge store-configured resources that you want to remove 
# It is automatically loaded and should normally be blank
#
class nagios::cleanup {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params

    # Used to remove hostgroups wrong naming
#     nagios::hostgroup { test-puppet: ensure => absent }

}
