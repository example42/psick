class postgresql::hbaconcat {

    include postgresql::params

    include concat::setup

    concat { "${postgresql::params::configfilehba}":
        mode  => "600",
        owner => "${postgresql::params::configfile_owner}",
        group => "${postgresql::params::configfile_group}",
    }


    # The File Header. With Puppet comment
    concat::fragment{ "postgresqt_hba_header":
        target  => "${postgresql::params::configfilehba}",
        content => "# File Managed by Puppet\n",
        order   => 01,
        notify  => Service["postgresql"],
    }

    # The File Footer. With default acls
    concat::fragment{ "postgresqt_hba_footer":
        target  => "${postgresql::params::configfilehba}",
        content => template("postgresql/concat_hba_footer.erb"),
        order   => 90,
        notify  => Service["postgresql"],
    }

}
