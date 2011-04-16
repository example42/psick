# Class puppi::checks
# Creates default system-wide checks to be used by the puppi check command
# This class is going to be filled with further check and support for different OSes
# Currently is based on Linux OS
#
class puppi::checks {

    puppi::check { "NTP_Sync":
        command  => "check_ntp -H ${puppi::params::ntp_server}" ,
        priority => "10" ,
        hostwide => "yes" ,
    }

    puppi::check { "Disks_Usage":
        command  => "check_disk -w 20% -c 10% -A" ,
        priority => "10" ,
        hostwide => "yes" ,
    }

    puppi::check { "System_Load":
        command  => "check_load -w 15,10,5 -c 30,25,20" ,
        priority => "10" ,
        hostwide => "yes" ,
    }

    puppi::check { "Zombie_Procs":
        command  => "check_procs -w 5 -c 10 -s Z" ,
        priority => "10" ,
        hostwide => "yes" ,
    }


}
