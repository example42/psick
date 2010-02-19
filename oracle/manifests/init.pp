class oracle {

        case $operatingsystem {
                redhat: { include oracle::redhat }
                centos: { include oracle::redhat }
                default: { }
        }

}

