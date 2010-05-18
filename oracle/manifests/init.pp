import "classes/*.pp"
# import "defines/*.pp"

class oracle {

    include oracle::packages
    include oracle::user
    include oracle::limits
    include oracle::sysctl

    # Include OS specific subclasses, where necessary
    case $operatingsystem {
        debian: { include oracle::debian }
        ubuntu: { include oracle::debian }
        default: { }
    }

}

