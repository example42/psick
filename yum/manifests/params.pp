class yum::params  {

    require common
# Manage Automatic Updates method
    $update = $yum_update ? {
        "cron"     => "cron",
        "updatesd" => "updatesd",
        default    => "off",
    }

# We Need EPEL for many modules: let's enable it by default
    $extrarepo = $yum_extrarepo ? {
        ""      => "epel",
        default => $yum_extrarepo,
    }

# If existing /etc/yum.repos.d/ contents are purged (so that Puppet entirely controls it) or left as is
    $clean_repos = $yum_clean_repos ? {
         ""       => false,
         "yes"    => true,
         true     => true,
         "true"   => true,
    }

# Name of yum priority package
    $packagename_yumpriority = $common::osver ? {
        5 => "yum-priorities",
        6 => "yum-plugin-priorities",
        default => "yum-plugin-priorities",
    }

}
