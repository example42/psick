# Class puppi::infos
# Creates default system-wide info run to be used by the puppi info command
# This class is going to be filled with further info and support for different OSes
# Currently is based on Linux OS
#
class puppi::infos {

    puppi::info { "network": 
        description => "Network settings and stats" ,
        run         => "ifconfig###route###cat /etc/resolv.conf",
    }

    puppi::info { "users":
        description => "Users and logins information" ,
        run         => "who -a###last###lastlog",
    }

    puppi::info { "perf":
        description => "System performances and resources utilization" ,
        run         => "uptime###free###vmstat 1 5",
    }

    puppi::info { "disks":
        description => "Disks and filesystem information" ,
        run         => "df -h###mount###fdisk -l",
    }

    puppi::info { "hardware":
        description => "Hardware information" ,
        run         => "lspci###cat /proc/cpuinfo",
    }

}
