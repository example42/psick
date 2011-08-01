# Class: postgresql::params
#
# Sets internal variables and defaults for postgresql module
# This class is loaded in all the classes that use the values set here 
#
class postgresql::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET



## EXTRA MODULE INTERNAL VARIABLES
    $initdbcommand = $operatingsystem ? {
        default => "service postgresql initdb",
    }

    $configfilehba = $operatingsystem ? {
        ubuntu  => "/etc/postgresql/8.4/main/pg_hba.conf",
        default => "/var/lib/pgsql/data/pg_hba.conf",
    }

## MODULE INTERNAL VARIABLES

    # Default port can be overridden by User postgresql_port variable
    $port = $postgresql_port ? { 
         ''      => "5432",
         default => "${postgresql_port}",
    }
    $protocol = "tcp"

    $packagename = $operatingsystem ? {
        centos  => "postgresql84-server",
        redhat  => "postgresql84-server",
        ubuntu  => "postgresql-8.4",
        default => "postgresql",
    }

    $servicename = $operatingsystem ? {
        ubuntu  => "postgresql-8.4",
        default => "postgresql",
    }

    $processname = $operatingsystem ? {
        default => "postgres",
    }

    $processuser = $operatingsystem ? {
        default => "postgres",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        ubuntu => "/etc/postgresql/8.4/main/postgresql.conf",
        default => "/var/lib/pgsql/data/postgresql.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "600",
    }

    $configfile_owner = $operatingsystem ? {
        default => "postgres",
    }

    $configfile_group = $operatingsystem ? {
        default => "postgres",
    }

    $configdir = $operatingsystem ? {
        ubuntu  => "/etc/postgresql/8.4/main/",
        default => "/var/lib/pgsql/data/",
    }

    $initconfigfile = $operatingsystem ? {
        ubuntu  => undef,
        default => "/etc/sysconfig/pgsql",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        ubuntu  => "/var/run/postgresql/8.4-main.pid",
        default => "/var/lib/pgsql/data/postmaster.pid",
    }

    # Used by puppi class
    $datadir = $operatingsystem ? {
        ubuntu  => "/var/lib/postgresql/8.4/main/",
        default => "/var/lib/pgsql",
    }

    # Base logs directory
    $logdir = $operatingsystem ? {
        ubuntu  => "/var/log/postgresql",
        default => "/var/lib/pgsql/data/pg_log",
    }

    # Log file(s) - Can be an array
    $logfile = $operatingsystem ? {
        ubuntu  => "/var/log/postgresql/postgresql-8.4-main.log",
        default => "/var/lib/pgsql/data/pg_log/postgresql*.log",
    }
  
## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) postgresql::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $postgresql_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $postgresql_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$postgresql_monitor_target",
    }

    # If postgresql port monitoring is enabled 
    $monitor_port_enable = $postgresql_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $postgresql_monitor_port,
    }

    # If postgresql process monitoring is enabled 
    $monitor_process_enable = $postgresql_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $postgresql_monitor_process,
    }

}
