# Define puppi::project::xsl
#
# This is a shortcut define to build a puppi project for the generation of xls based on a single list file
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for automatic WAR deployments.
# If you need to customize it, either change the template defined here or build up your own custom ones.
#
# Variables:
# $source_list - The full URL to be used to retrieve the files list. Format can be: http://... file://... ssh:// 
# $files_prefix - The prefix to remove form the list entries in order to determine the files path on the deploy_root
#                 We suggest to place in the files list just the deploy_root relative paths of the files, and in this 
#                 case the $files_prefix is null
# $source_baseurl - The full URL, in URI standard format, to prepend to the entries in the files list in order to 
#                   retrieve the relative files.
# $user - The usen to be used for deploy operations 
# $deploy_root - The destination directory where the files have to be deployed
# $init_script (Optional) - The full path (ex: /etc/init.d/apache2) of the init script of the webserver
#                           If you define it, the webserver is stopped and then started during deploy
# $disable_services (Optional) - The names (space separated) of the services you might want to stop
#                                during deploy. By default is blank. Example: "puppet monit"
# $firewall_src_ip (Optional) - The IP address of a loadbalancer you might want to block during deploy
# $firewall_dst_port (Optional) - The local port to block from the loadbalancer during deploy (Default all)
# $report_email (Optional) - The (space separated) email(s) to notify of deploy/rollback operations
#
define puppi::project::xsl (
    $source_list,
    $source_baseurl,
    $files_prefix="",
    $user,
    $deploy_root,
    $init_script="",
    $disable_services="",
    $firewall_src_ip="",
    $firewall_dst_port="0",
    $report_email="",
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    # Create Project
    puppi::project { $name: enable => $enable }
 
    # Populate Project scripts for deploy

    puppi::deploy {
        "${name}-Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Retrieve_File_List":
             priority => "20" , command => "get_file.sh" , arguments => "$source_list list" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Retrieve_Xsl_Files":
             priority => "25" , command => "get_filesfromlist.sh" , arguments => "$source_baseurl $files_prefix" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Deploy_Files":
             priority => "40" , command => "deploy_files.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Process_Xsl_Files":
             priority => "45" , command => "process_xsl.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

    puppi::rollback {
        "${name}-Process_Xsl_Files":
             priority => "45" , command => "process_pbit_xsl.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }

# Application service restart only if $init_script is provided
if ($init_script != "") {
    puppi::deploy {
        "${name}-Service_stop":
             priority => "47" , command => "service.sh" , arguments => "$init_script stop" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Service_start":
             priority => "48" , command => "service.sh" , arguments => "$init_script start" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Service_stop":
             priority => "47" , command => "service.sh" , arguments => "$init_script stop" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Service_start":
             priority => "48" , command => "service.sh" , arguments => "$init_script start" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Disable services that might start the AS during deploy
if ($disable_services != "") {
    puppi::deploy {
        "${name}-Disable_extra_services":
             priority => "46" , command => "service_extra.sh" , arguments => "stop $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Enable_extra_services":
             priority => "49" , command => "service_extra.sh" , arguments => "start $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Disable_extra_services":
             priority => "46" , command => "service_extra.sh" , arguments => "stop $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Enable_extra_services":
             priority => "49" , command => "service_extra.sh" , arguments => "start $disable_services" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}


# Exclusion from Load Balancer is managed only if $firewall_src_ip is set
if ($firewall_src_ip != "") {
    puppi::deploy {
        "${name}-Load_Balancer_Block":
             priority => "46" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "49" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Load_Balancer_Block":
             priority => "46" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "49" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
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
