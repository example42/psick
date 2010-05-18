class psad {

    case $operatingsystem {
        debian: {
            include psad::base 
            include psad::debian
        }
        ubuntu: { include psad::base }
        default: { warning("No support for psad on $operatingsystem") }
    }

}

