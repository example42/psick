class foreman::package::debian {

    exec { foreman_deb_get :
        cwd     => "${foreman::params::workdir}",
        command => "wget ${foreman::params::deb_url}",
        creates => "${foreman::params::workdir}/${foreman::params::deb_filename}",
        timeout => 3600,
        before  => Exec["foreman_deb_install"],
    }

    exec { foreman_deb_install :
        cwd     => "${foreman::params::workdir}",
        command => "dpkg -i ${foreman::params::deb_filename}",
        timeout => 3600,
        creates => "/var/lib/dpkg/info/foreman.list",
    }
}
