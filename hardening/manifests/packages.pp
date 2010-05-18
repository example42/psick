class hardening::packages {

# This class runs (once) a script for a (radical) packages cleanup after a base installation
# In order to avoid hassles with other classes or administrative operations, this has been preferred to explicit puppet packages management

$package_list_path = "/root/puppet_removedpackages"
$packages_removed_flag = "/var/lock/puppet_removedpackages"

    exec {
        "hardening_packageremove":
            command => "sh $package_list_path ; touch $packages_removed_flag",
            onlyif => "test ! -f $packages_removed_flag",
            require => File["$package_list_path"],
    }

    file {
        "$package_list_path":
        mode => 644, owner => root, group => root,
        ensure => present,
        path   => "$package_list_path",
        source => "puppet://$servername/hardening/package_remove_list",
    }

    notice ("Delete $packages_removed_flag to re exec packages removal script")

}

