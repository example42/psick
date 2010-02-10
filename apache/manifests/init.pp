import "defines/*.pp"
import "classes/*.pp"

class apache {

	include apache::base

        case $operatingsystem {
                debian: { include apache::debian }
                ubuntu: { include apache::debian }
                default: { }
        }

}
