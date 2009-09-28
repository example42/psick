class users::example42 {

        user {
                "example42":
                        comment  => "Example 42 default user",
                        password => '$1$xd/jf97n$ZAhAz.CIGJ0gUECBohz/..',
                        ensure   => present,
       }

#       adduser {
#                "example42":
#               password => '$1$xd/jf97n$ZAhAz.CIGJ0gUECBohz/..',
#               uid      => '',
#               gid      => '',
#       }

# Uncomment below to remove example42 user
        # deluser {
        # "example42":
        # }
}

