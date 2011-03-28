# Define puppi::project::mysql
#
# This is a shortcut define to build a puppi project for the management of mysql queries
#
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for automatic deployments.
# If you need to customize it, either change the template defined here or build up your own custom ones.
#
# Variables:
# $source - The full URL of the main file to retrieve. Format should be in URI standard (http:// file:// ssh:// svn:// rsync://)
# $init_source (Optional) - The full URL to be used to retrieve, for the first time, the project files.
#                           Format should be in URI standard (http:// file:// ssh:// svn://)
# $mysql_user - The mysql user used to run the queries
# $mysql_host - The hostname of the mysql server
# $mysql_database - The mysql database to work on
# $mysql_password - The password for the defined user
# $predeploy_customcommand (Optional) -  Full path with arguments of an eventual custom command to execute before the deploy.
#                             The command/script is executed as root, if you need to launch commands as a separated user
#                             manage that inside your custom script
# $predeploy_user (Optional) - The user to be used to execute the $predeploy_customcommand. By default is the same of $user
# $predeploy_priority (Optional) - The priority (execution sequence number) that defines the execution order ot the predeploy command.
#                                  Default: 39 (immediately before the copy of files on the deploy root)
# $postdeploy_customcommand (Optional) - Full path with arguments of an eventual custom command to execute after the deploy.
#                             The command/script is executed as root, if you need to launch commands as a separated user
#                             manage that inside your custom script
# $postdeploy_user (Optional) - The user to be used to execute the $postdeploy_customcommand. By default is the same of $user
# $postdeploy_priority (Optional) - The priority (execution sequence number) that defines the execution order ot the postdeploy command.
#                                  Default: 41 (immediately after the copy of files on the deploy root)
# $disable_services (Optional) - The names (space separated) of the services you might want to stop
#                                during deploy. By default is blank. Example: "apache puppet monit"
# $report_email (Optional) - The (space separated) email(s) to notify of deploy/rollback operations
# $backup (Optional) - If and how backups of existing databases are made. Default: "yes"
# $run_checks (Optional) - If you want to run local puppi checks before and after the deploy procedure. Default: "true"
#
define puppi::project::mysql (
    $source,
    $init_source="",
    $mysql_user="root",
    $mysql_host="localhost",
    $mysql_database,
    $mysql_password="",
    $predeploy_customcommand="",
    $predeploy_user="",
    $predeploy_priority="39",
    $postdeploy_customcommand="",
    $postdeploy_user="",
    $postdeploy_priority="41",
    $disable_services="",
    $report_email="",
    $backup="yes",
    $run_checks="true",
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    # Set default values
    $predeploy_real_user = $predeploy_user ? {
        ''      => $user,
	default => $predeploy_user,
    }

    $postdeploy_real_user = $postdeploy_user ? {
        ''      => $user,
	default => $postdeploy_user,
    }

    $real_source_type = "mysql"

    $source_filename = urlfilename($source)

# Create Project
    puppi::project { $name: enable => $enable }


# Populate Project scripts for initialize
if ($init_source != "") {
    puppi::initialize {
        "${name}-Deploy_Files":
             priority => "40" , command => "get_file.sh" , arguments => "-s $init_source -t $real_source_type" ,
             user => "root" , project => "$name" , enable => $enable ;
    }
}
 
# Common Defines
    puppi::deploy {
        "${name}-Retrieve_SourceFile":
             priority => "20" , command => "get_file.sh" , arguments => "-s $source -t $real_source_type" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Run_SQL":
             priority => "40" , command => "database.sh" , arguments => "-t mysql -a run -u $mysql_user -p '$mysql_password' -d $mysql_database -h $mysql_host" ,
             user => "root" , project => "$name" , enable => $enable;
    }


if ($backup == "yes") {
    puppi::deploy {
        "${name}-Backup_Database":
             priority => "30" , command => "database.sh" , arguments => "-t mysql -a dump -u $mysql_user -p '$mysql_password' -d $mysql_database -h $mysql_host" ,
             user => "root" , project => "$name" , enable => $enable ;
    }
    puppi::rollback {
        "${name}-Recover_Database":
             priority => "40" , command => "database.sh" , arguments => "-t mysql -a restore -u $mysql_user -p '$mysql_password' -d $mysql_database -h $mysql_host" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}


# Run PRE and POST automatic checks
if ($run_checks == "true") {
    puppi::deploy {
        "${name}-Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }
    puppi::rollback {
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }
}


# Run predeploy custom script, if defined
if ($predeploy_customcommand != "") {
    puppi::deploy {
        "${name}-Run_Custom_PreDeploy_Script":
             priority => "$predeploy_priority" , command => "execute.sh" , arguments => "$predeploy_customcommand" ,
             user => "$predeploy_real_user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Run_Custom_PreDeploy_Script":
             priority => "$predeploy_priority" , command => "execute.sh" , arguments => "$predeploy_customcommand" ,
             user => "$predeploy_real_user" , project => "$name" , enable => $enable;
    }
}


# Run postdeploy custom script, if defined
if ($postdeploy_customcommand != "") {
    puppi::deploy {
        "${name}-Run_Custom_PostDeploy_Script":
             priority => "$postdeploy_priority" , command => "execute.sh" , arguments => "$postdeploy_customcommand" ,
             user => "$postdeploy_real_user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Run_Custom_PostDeploy_Script":
             priority => "$postdeploy_priority" , command => "execute.sh" , arguments => "$postdeploy_customcommand" ,
             user => "$postdeploy_real_user" , project => "$name" , enable => $enable;
    }
}


# Disable services during deploy
if ($disable_services != "") {
    puppi::deploy {
        "${name}-Disable_extra_services":
             priority => "36" , command => "service.sh" , arguments => "stop $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Enable_extra_services":
             priority => "44" , command => "service.sh" , arguments => "start $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Disable_extra_services":
             priority => "36" , command => "service.sh" , arguments => "stop $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Enable_extra_services":
             priority => "44" , command => "service.sh" , arguments => "start $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}


# Reporting
if ($report_email != "") {
    puppi::report {
        "${name}-Mail_Notification":
             priority => "20" , command => "report_mail.sh" , arguments => "$report_email" ,
             user => "root" , project => "$name" , enable => $enable ;
    }
}

}
