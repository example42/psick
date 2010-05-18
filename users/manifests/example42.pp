class users::example42 {
# Adds a local "example42" user, With password "example42".
       user {
        "example42":
            comment  => "Example 42 default user",
            password => '$1$xd/jf97n$ZAhAz.CIGJ0gUECBohz/..',
            ensure   => present,
       }

# Uncomment below to remove example42 user
#       user {
#        "example42":
#            ensure   => absent,
#       }

}
