class users {

}

class users::admins {
	# Customize and define here admin users
	# Default password = 'example'  CHANGE IT
	user {
                "admin":
		password => '$1$xd/jf97n$ZAhAz.CIGJ0gUECBohz/..',
		groups   => 'wheel',
	}
	
}

