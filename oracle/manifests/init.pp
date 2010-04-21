import "classes/*.pp"
# import "defines/*.pp"

class oracle {

	include oracle::packages
	include oracle::user
	include oracle::limits
	include oracle::sysctl

}

