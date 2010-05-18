class rootmail {

    file {    
             "/root/.forward":
            mode => 600, owner => root, group => root,
            ensure => present,
            content => "$root_email",
    }
}

