# Define monitor::mount
#
# You can use this define to manage monitored mounts.
# It automatcally monitors the mount point you specify AND IT MOUNTS it using
# Puppet's native mount define.
# So, generically, you just have to use monitor::mount instead of mount to manage your mountpoints
# The possible atguments are the same of the native mount define plus the usual $tool that
# specifies what monitor tools you can use.
# If you want to check the mount point only, without actually mounting it via the mount define,
# set only_check=true
#
define monitor::mount (
    $name,
    $device,
    $fstype,
    $options='',
    $pass='0',
    $remounts=true,
    $ensure='mounted',
    $atboot='true',
    $only_check=false,
    $create_dir=false,
    $owner='root',
    $group='root',
    $mode='755',
    $enable=true,
    $tool=$monitor_tool
    ) {

    $escapedname=regsubst($name,'/','_','G')

    $computed_ensure = $enable ? {
        false   => "absent",
        "false" => "absent",
        "no"    => "absent",
        true    => "present",
        "true"  => "present",
        "yes"   => "present",
    }

    # The mount is actually done (if $only_check != true )
    if ( $only_check != true ) {
        mount { "$name":
            name    => "$name",
            device  => "$device",
            fstype  => "$fstype",
            options => "$options",
            pass    => "$pass",
            remounts => $remounts,
            ensure  => "$ensure",
            atboot  => true,
        }
    }

    if ( $create_dir == true ) and ( $only_check != true ) {
        file { "$name":
            path    => "$name",
            owner   => "$owner",
            group   => "$group",
            mode    => "$mode",
            ensure  => directory,
            before  => Mount["$name"],
        }
    }

    if ($tool =~ /nagios/) {
        nagios::service { "Mount_$escapedname":
            ensure      => $computed_ensure,
            check_command => "check_nrpe!check_mount!${name}!${fstype}",
        }
    }

    if ($tool =~ /puppi/) {
        puppi::check { "Mount_$escapedname":
            enable   => $enable,
            hostwide => "yes",
            command  => "check_mount -m ${name} -t ${fstype}" ,
        }
    }

}

