# Define cacti::conf
#
# General cacti main configuration file's inline modification define
# Use with caution, it doesn't fit well with Apache's conf logic based on containers
# Use just for ALREADY DEFINED general settings in main httpd.conf
#
# Usage:
# cacti::conf    { "database_username":  value => "On" }

define cacti::conf ($value) {

        config { "cacti_conf_$name":
                file      => $operatingsystem ?{
                                ubuntu  => "/etc/cacti/debian.php",
                                debian  => "/etc/cacti/debian.php",
                                centos  => "/etc/cacti/db.php",
                                redhat  => "/etc/cacti/db.php",
                                suse    => "/usr/share/cacti/include/config.php",
                             },
                line      => "'$name' = '$value' # $comment",
                pattern   => "$name ",
                engine    => "replaceline",
                require   => Package["cacti"],
		source    => "cacti::conf",
        }

}
