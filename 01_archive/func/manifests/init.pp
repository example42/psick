class func {

    case $operatingsystem {
        centos: { include func::base }
        redhat: { include func::base }
        default: { warning("No support for func on $operatingsystem") }
    }

}

