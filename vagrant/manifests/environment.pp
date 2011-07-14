define vagrant::environment  (
    $user
) {
    require vagrant
    require vagrant::params

    file { "${vagrant::params::basedir}/${name}":
        ensure  => directory,
        owner   => "${user}",
        require => File["${vagrant::params::basedir}"],
    }

    concat { "${vagrant::params::basedir}/${name}/Vagrantfile":
        mode    => "644",
        owner   => "${user}",
        require => File["${vagrant::params::basedir}/${name}"],
    }

    concat::fragment{ "Vagrantfile_HEADER":
        target  => "${vagrant::params::basedir}/${name}/Vagrantfile",
        content => template("vagrant/concat/Vagrantfile_HEADER.erb"),
        order   => "1",
    }

    concat::fragment{ "Vagrantfile_FOOTER":
        target  => "${vagrant::params::basedir}/${name}/Vagrantfile",
        content => template("vagrant/concat/Vagrantfile_FOOTER.erb"),
        order   => "99",
    } 

}
