class users::admin {
# Creates user: admin with wheel privileges
# Default password = 'example'  CHANGE IT
    user {
        "admin":
        ensure   => present,
        groups   => 'wheel',
# Default password = 'example'  CHANGE IT before uncommenting
#        password => '$1$xd/jf97n$ZAhAz.CIGJ0gUECBohz/..',
    }
}
