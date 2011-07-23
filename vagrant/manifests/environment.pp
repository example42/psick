define vagrant::environment  (
    $user,
    $puppet_manifest_file='vagrant/puppet/site.pp',
    $puppet_server=$puppet_server
) {
    require vagrant
    require vagrant::params

    file { "${vagrant::params::basedir}/${name}":
        ensure  => directory,
        owner   => "${user}",
        require => File["${vagrant::params::basedir}"],
    }

    file { "${vagrant::params::basedir}/${name}/manifests":
        ensure  => directory,
        owner   => "${user}",
        require => File["${vagrant::params::basedir}/${name}"],
    }

    file { "${vagrant::params::basedir}/${name}/manifests/site.pp":
        ensure  => present,
        owner   => "${user}",
        content => template("$puppet_manifest_file"),
        require => File["${vagrant::params::basedir}/${name}/manifests"],
    }

    file { "${vagrant::params::basedir}/${name}/manifests/puppet.conf.erb":
        ensure  => present,
        owner   => "${user}",
        content => template("vagrant/puppet/puppet.conf.erb"),
        require => File["${vagrant::params::basedir}/${name}/manifests"],
    }


    concat { "${vagrant::params::basedir}/${name}/Vagrantfile":
        mode    => "644",
        owner   => "${user}",
        require => File["${vagrant::params::basedir}/${name}"],
    }

    concat::fragment{ "Vagrantfile_HEADER_${name}":
        target  => "${vagrant::params::basedir}/${name}/Vagrantfile",
        content => template("vagrant/concat/Vagrantfile_HEADER.erb"),
        order   => "1",
    }

    concat::fragment{ "Vagrantfile_FOOTER_${name}":
        target  => "${vagrant::params::basedir}/${name}/Vagrantfile",
        content => template("vagrant/concat/Vagrantfile_FOOTER.erb"),
        order   => "99",
    } 

}
