# Define virtualbox::vm
#
# Define creation and status of a virtual machine.
#
# Usage:
# virtualbox::vm    { "web02": startup => "yes" }
#
define virtualbox::vm ($startup="yes") {

    require virtualbox::params

# Quick and dirty that works only with example42 common module
    config { "virtualbox_vm_$name":
        file      => "/etc/rc.local",
        line      => "vboxheadless -s $name &",
        pattern   => "^$name ",
        engine    => "line",
    }

# Waiting for sane alternatives...
#    file { "virtualbox_vm_$name":
#        path      => "${virtualbox::params::autostartdir}",
#        content   => $startup ? {
#            yes     => "vboxheadless -s $name &",
#            default => "# vboxheadless -s $name &",
#        },
#        mode      => "755",
#    }

}

