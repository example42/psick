# Class: foreman::package
#
# Installs the Foreman from package
#
class foreman::package {

    require puppet::params
    require foreman::params

    case $operatingsystem {
        ubuntu,debian: { include foreman::package::debian }
        centos,redhat: { include foreman::package::redhat }
    }

}
