#
# Class: openldap::extra
#
# Extra tools for openldap users management
#
# Usage:
# Autoincluded by openldap class if $openldap_extra=yes (default)
# You should check the ldap_params.erb template for customizing the default
# settings defined there. You can overrid the template location in
# the $my_project::extra class.
#
# The scripts provided:
# useradd.sh - Add a new user to ldap directory
# userdel.sh - Deletes a user from the ldap directory
# userdump.sh - Dumps user's data from the main ldap server
# chpass.sh - Change user's password
# chgrp.sh - Change user's group
# chdescription.sh - Change user's description
# usersynccheck.sh - Show user's data present on differente multimaster servers
#
class openldap::extra {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params

    file { "openldap_scriptsdir":
        path    => "${openldap::params::extra_dir}",
        ensure  => directory,
        require => Package["openldap"],
    }

    file { "openldap_paramsfile":
        path    => "${openldap::params::extra_dir}/ldap_params",
        mode    => "440",
        owner   => "${openldap::params::extra_user}",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/ldap_params.erb"),
    }

    file { "openldap_useradd.sh":
        path    => "${openldap::params::extra_dir}/useradd.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/useradd.sh.erb"),
    }

    file { "openldap_userdel.sh":
        path    => "${openldap::params::extra_dir}/userdel.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/userdel.sh.erb"),
    }

    file { "openldap_userdump.sh":
        path    => "${openldap::params::extra_dir}/userdump.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/userdump.sh.erb"),
    }

    file { "openldap_chpass.sh":
        path    => "${openldap::params::extra_dir}/chpass.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/chpass.sh.erb"),
    }

    file { "openldap_chgroup.sh":
        path    => "${openldap::params::extra_dir}/chgroup.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/chgroup.sh.erb"),
    }

    file { "openldap_chdescription.sh":
        path    => "${openldap::params::extra_dir}/chdescription.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/chdescription.sh.erb"),
    }

    file { "openldap_usersynccheck.sh":
        path    => "${openldap::params::extra_dir}/usersynccheck.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/usersynccheck.sh.erb"),
    }

    file { "openldap_initldap.sh":
        path    => "${openldap::params::extra_dir}/initldap.sh",
        mode    => "755",
        owner   => "root",
        group   => "${openldap::params::extra_user}",
        ensure  => present,
        require => File["openldap_scriptsdir"],
        content => template("openldap/extra/initldap.sh.erb"),
    }

}
