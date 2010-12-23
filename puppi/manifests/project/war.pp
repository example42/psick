# Define puppi::project::war
#
# This is a shortcut define to build a puppi project for a single WAR deployment with autoloading
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for automatic WAR deployments.
# If you need to customize it, either change the template defined here or build up your own custom ones.
#
# Variables:
# $source_url - The full URL to be used to retrive the WAR file. Should be in URI format
#               Accepted uris are: http(s):// ssh:// file:// svn://  
# $war_file - The name of the WAR file (even if it's already defined ath the end of $source_url)
# $user - The usen to be used for deploy operations 
# $deploy_root - The destination directory where the WAR has to be deployed
# $init_script (Optional) - The full path (ex: /etc/init.d/tomcat) of the init script of your AS
#                           If you define it, the AS is stopped and then started during deploy
# $disable_services (Optional) - The names (space separated) of the services you might want to stop
#                                during deploy. By default is blank. Example: "puppet monit"
# $firewall_src_ip (Optional) - The IP address of a loadbalancer you might want to block during deploy
# $firewall_dst_port (Optional) - The local port to block from the loadbalancer during deploy (Default all)
# $report_email (Optional) - The (space separated) email(s) to notify of deploy/rollback operations
#
define puppi::project::war (
    $source_url,
    $war_file,
    $user,
    $deploy_root,
    $init_script="",
    $disable_services="",
    $firewall_src_ip="",
    $firewall_dst_port="0",
    $report_email="",
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    # Create Project
    puppi::project { $name: enable => $enable }
 
    # Populate Project scripts for deploy

    puppi::deploy {
        "${name}-Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Retrieve_WAR":
             priority => "20" , command => "get_file.sh" , arguments => "$source_url" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Move_existing_WAR":
             priority => "30" , command => "archive.sh" , arguments => "-b $deploy_root -t war -s move" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_WAR":
             priority => "40" , command => "deploy.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "50" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

    puppi::rollback {
        "${name}-Remove_existing_WAR":
             priority => "30" , command => "delete.sh" , arguments => "$deploy_root/$war_file" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Recover_latest_WAR":
             priority => "40" , command => "archive.sh" , arguments => "-r $deploy_root -t war" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "50" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

# Application service restart only if $init_script is provided
if ($init_script != "") {
    puppi::deploy {
        "${name}-Check_undeploy":
             priority => "33" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file absent" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Service_stop":
             priority => "35" , command => "service.sh" , arguments => "$init_script stop" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Service_start":
             priority => "43" , command => "service.sh" , arguments => "$init_script start" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Check_deploy":
             priority => "45" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file present" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Check_undeploy":
             priority => "33" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file absent" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Service_stop":
             priority => "35" , command => "service.sh" , arguments => "$init_script stop" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Service_start":
             priority => "43" , command => "service.sh" , arguments => "$init_script start" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Check_deploy":
             priority => "45" , command => "checkwardir.sh" , arguments => "$deploy_root/$war_file present" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
}

# Disable services that might start the AS during deploy
if ($disable_services != "") {
    puppi::deploy {
        "${name}-Disable_extra_services":
             priority => "34" , command => "service_extra.sh" , arguments => "stop $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Enable_extra_services":
             priority => "46" , command => "service_extra.sh" , arguments => "start $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Disable_extra_services":
             priority => "34" , command => "service_extra.sh" , arguments => "stop $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Enable_extra_services":
             priority => "46" , command => "service_extra.sh" , arguments => "start $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}


# Exclusion from Load Balancer is managed only if $firewall_src_ip is set
if ($firewall_src_ip != "") {
    puppi::deploy {
        "${name}-Load_Balancer_Block":
             priority => "25" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "45" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Load_Balancer_Block":
             priority => "25" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
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

