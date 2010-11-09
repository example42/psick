# Define puppi::project::maven
#
# This is a shortcut define to build a puppi project for Tomcat deployments
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for Tomcat deployments.
# If you need to customize it, either change the template defined here or build up yourn custom ones.
#
define puppi::project::maven (
    $source_url,
    $user,
    $deploy_root,
    $document_root,
    $config_root,
    $report_email,
    $init_script,
    $suffix='',
    $loadbalancer_ip='',
    $service='restart',
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    # Create Project
    puppi::project { $name: enable => $enable }
 
    # Populate Project scripts for deploy

    puppi::deploy {
        "Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" , user => "root" , project => "$name" , enable => $enable;
        "Get_Maven_Info":
             priority => "20" , command => "get_maven_info.sh" , arguments => "$source_url $suffix" , user => "root" , project => "$name" , enable => $enable;
        "Get_Maven_Files":
             priority => "25" , command => "get_maven_files.sh" , arguments => "$source_url" , user => "root" , project => "$name" , enable => $enable ;
        "Backup_existing_WAR":
             priority => "30" , command => "archive.sh" , arguments => "$deploy_root war" , user => "root" , project => "$name" , enable => $enable;
        "Backup_existing_DocumentRoot":
             priority => "35" , command => "archive.sh" , arguments => "$document_root docroot" , user => "root" , project => "$name" , enable => $enable;
        "Deploy_Maven_WAR":
             priority => "40" , command => "deploy_file.sh" , arguments => "$deploy_root warfile" , user => "$user" , project => "$name" , enable => $enable;
        "Deploy_Maven_DocumentRoot":
             priority => "45" , command => "deploy_tar.sh" , arguments => "$document_root srcfile" , user => "$user" , project => "$name" , enable => $enable;
        "Service_restart":
             priority => "55" , command => "service.sh" , arguments => "$init_script $service" , user => "$user" , project => "$name" , enable => $enable;
        "Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" , user => "root" , project => "$name" , enable => $enable ;
    }


    puppi::rollback {
        "Recover_WAR":
             priority => "30" , command => "recover.sh" , arguments => "$deploy_root war" , user => "$user" , project => "$name" , enable => $enable;
        "Recover_DocumentRoot":
             priority => "35" , command => "recover.sh" , arguments => "$document_root docroot" , user => "$user" , project => "$name" , enable => $enable;
        "Service_restart":
             priority => "55" , command => "service.sh" , arguments => "$init_script $service" , user => "$user" , project => "$name" , enable => $enable;
        "Run_POST-Checks":
             priority => "50" , command => "check_project.sh" , arguments => "$name" , user => "root" , project => "$name" , enable => $enable ;
    }


    puppi::report {
        "Mail_Notification":
             priority => "20" , command => "report_mail.sh" , arguments => "$report_email" , user => "root" , project => "$name" , enable => $enable ;
    }


# Config tar is managed only if $configdir is set
if ($configdir != "") {
    puppi::deploy {
        "Backup_existing_ConfigDir":
             priority => "37" , command => "archive.sh" , arguments => "$config_root config" , user => "root" , project => "$name" , enable => $enable;
        "Deploy_Maven_ConfigDir":
             priority => "47" , command => "deploy_tar.sh" , arguments => "$config_root configfile" , user => "$user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "Recover_ConfigDir":
             priority => "37" , command => "recover.sh" , arguments => "$config_root config" , user => "$user" , project => "$name" , enable => $enable;
    }
}

# Exclusion from Load Balancer is managed only if $loadbalancer_ip is set
if ($loadbalancer_ip != "") {
    puppi::deploy {
        "Load_Balancer_Block":
             priority => "54" , command => "firewall.sh" , arguments => "$load_balancer_ip on" , user => "root" , project => "$name" , enable => $enable;
        "Load_Balancer_Unblock":
             priority => "56" , command => "firewall.sh" , arguments => "$load_balancer_ip off" , user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "Load_Balancer_Block":
             priority => "54" , command => "firewall.sh" , arguments => "$load_balancer_ip on" , user => "root" , project => "$name" , enable => $enable;
        "Load_Balancer_Unblock":
             priority => "56" , command => "firewall.sh" , arguments => "$load_balancer_ip off" , user => "root" , project => "$name" , enable => $enable;
    }
}


}
