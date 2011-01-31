# Define puppi::project::war
#
# This is a shortcut define to build a puppi project for a single WAR deployment with autoloading
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for automatic WAR deployments.
# If you need to customize it, either change the template defined here or build up your own custom ones.
#
# Variables:
# $source - The full URL to be used to retrive the WAR file. Should be in URI format
#               Accepted uris are: http(s):// ssh:// file:// svn://  
# $init_source (Optional) - The full URL to be used to retrieve, for the first time, the project files.
#                           They are copied to the $deploy_root
#                           Format should be in URI standard (http:// file:// ssh:// svn://)
# $deploy_root - The destination directory where the WAR has to be deployed
# $user (Optional) - The user to be used for deploy operations 
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
# $init_script (Optional) - The name (ex: tomcat) of the init script of your AS
#                           If you define it, the AS is stopped and then started during deploy
# $disable_services (Optional) - The names (space separated) of the services you might want to stop
#                                during deploy. By default is blank. Example: "puppet monit"
# $firewall_src_ip (Optional) - The IP address of a loadbalancer you might want to block during deploy
# $firewall_dst_port (Optional) - The local port to block from the loadbalancer during deploy (Default all)
# $report_email (Optional) - The (space separated) email(s) to notify of deploy/rollback operations
# $backup_rsync_options (Optional) - The extra options to pass to rsync for backup operations. Use this, for example, to exclude 
#                                    directories that you don't want to archive.
#                                    IE: "--exclude .snapshot --exclude cache --exclude www/cache"
#
define puppi::project::war (
    $source,
    $init_source='',
    $deploy_root,
    $user="root",
    $predeploy_customcommand="",
    $predeploy_user="",
    $predeploy_priority="39",
    $postdeploy_customcommand="",
    $postdeploy_user="",
    $postdeploy_priority="41",
    $init_script="",
    $disable_services="",
    $firewall_src_ip="",
    $firewall_dst_port="0",
    $report_email="",
    $backup_rsync_options="--exclude .snapshot",
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    # Set user values
    $predeploy_real_user = $predeploy_user ? {
        ''      => $user,
	default => $predeploy_user,
    }

    $postdeploy_real_user = $postdeploy_user ? {
        ''      => $user,
	default => $postdeploy_user,
    }

    # Unless explicitely defined, we assume that the WAR file to use for initialization is the same to use for deploys
    $init_real_source = $init_source ? {
        ''      => $source,
        default => $init_source,
    }

    # We need the war filename
    $war_file = urlfilename($source)

    # Create Project
    puppi::project { $name: enable => $enable }

    # Populate Project scripts for initialize
    puppi::initialize {
        "${name}-Deploy_Files":
             priority => "40" , command => "get_file.sh" , arguments => "-s $init_real_source -d $deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
 
    # Populate Project scripts for deploy
    puppi::deploy {
        "${name}-Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Retrieve_WAR":
             priority => "20" , command => "get_file.sh" , arguments => "-s $source" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_WAR":
             priority => "30" , command => "archive.sh" , arguments => "-b $deploy_root -t war -s move -o '$backup_rsync_options'" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_WAR":
             priority => "40" , command => "deploy.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

    puppi::rollback {
        "${name}-Remove_existing_WAR":
             priority => "30" , command => "delete.sh" , arguments => "$deploy_root/$war_file" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Recover_latest_WAR":
             priority => "40" , command => "archive.sh" , arguments => "-r $deploy_root -t war -o '$backup_rsync_options'" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

# Run predeploy custom script, if defined
if ($predeploy_customcommand != "") {
    puppi::deploy {
        "${name}-Run_Custom_PreDeploy_Script":
             priority => "$predeploy_priority" , command => "execute.sh" , arguments => "$predeploy_customcommand" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Run_Custom_PreDeploy_Script":
             priority => "$predeploy_priority" , command => "execute.sh" , arguments => "$predeploy_customcommand" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Run postdeploy custom script, if defined
if ($postdeploy_customcommand != "") {
    puppi::deploy {
        "${name}-Run_Custom_PostDeploy_Script":
             priority => "$postdeploy_priority" , command => "execute.sh" , arguments => "$postdeploy_customcommand" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Run_Custom_PostDeploy_Script":
             priority => "$postdeploy_priority" , command => "execute.sh" , arguments => "$postdeploy_customcommand" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Application service restart only if $init_script is provided
if ($init_script != "") {
    puppi::deploy {
        "${name}-Check_undeploy":
             priority => "37" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file absent" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Service_stop":
             priority => "38" , command => "service.sh" , arguments => "stop $init_script" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Service_start":
             priority => "42" , command => "service.sh" , arguments => "start $init_script" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Check_deploy":
             priority => "43" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file present" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Check_undeploy":
             priority => "37" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file absent" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Service_stop":
             priority => "38" , command => "service.sh" , arguments => "stop $init_script" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Service_start":
             priority => "42" , command => "service.sh" , arguments => "start $init_script" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Check_deploy":
             priority => "43" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file present" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
}

# Disable services that might start the AS during deploy
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

# Exclusion from Load Balancer is managed only if $firewall_src_ip is set
if ($firewall_src_ip != "") {
    puppi::deploy {
        "${name}-Load_Balancer_Block":
             priority => "35" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "45" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Load_Balancer_Block":
             priority => "35" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "45" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
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

