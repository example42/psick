# Customize Apache module here
#
class apache::example42 inherits apache {

    include users::params

    # If you use roles (and have a $role variable) you can set up custom stuff for each role that uses apache.
    # If you uncomment below remember to create a specific (also empty) apache::$my_project::$role class
    # if $role { include "apache::example42::${role}" }

}
