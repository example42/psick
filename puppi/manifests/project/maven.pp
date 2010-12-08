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
    $document_root='',
    $config_root='',
    $report_email,
    $init_script='',
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
        "${name}-Run_PRE-Checks":
             priority => "10" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Get_Maven_Info":
             priority => "20" , command => "get_maven_info.sh" , arguments => "$source_url $suffix" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Get_Maven_Files_WAR":
             priority => "25" , command => "get_maven_files.sh" , arguments => "$source_url warfile" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_WAR":
             priority => "30" , command => "archive.sh" , arguments => "$deploy_root war" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_Maven_WAR":
             priority => "40" , command => "deploy_file.sh" , arguments => "$deploy_root warfile" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }


    puppi::rollback {
        "${name}-Recover_WAR":
             priority => "30" , command => "recover.sh" , arguments => "$deploy_root war" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "50" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }


    puppi::report {
        "${name}-Mail_Notification":
             priority => "20" , command => "report_mail.sh" , arguments => "$report_email" ,
             user => "root" , project => "$name" , enable => $enable ;
    }


# Config tar is managed only if $config_root is set
if ($config_root != "") {
    puppi::deploy {
        "${name}-Get_Maven_Files_Config":
             priority => "26" , command => "get_maven_files.sh" , arguments => "$source_url configfile" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_ConfigDir":
             priority => "37" , command => "archive.sh" , arguments => "$config_root config" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_Maven_ConfigDir":
             priority => "47" , command => "deploy_tar.sh" , arguments => "$config_root configfile" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Recover_ConfigDir":
             priority => "37" , command => "recover.sh" , arguments => "$config_root config" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Docroot tar is managed only if $document_root is set
if ($document_root != "") {
    puppi::deploy {
        "${name}-Get_Maven_Files_SRC":
             priority => "27" , command => "get_maven_files.sh" , arguments => "$source_url srcfile" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_DocumentRoot":
             priority => "35" , command => "archive.sh" , arguments => "$document_root docroot" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_Maven_DocumentRoot":
             priority => "45" , command => "deploy_tar.sh" , arguments => "$document_root srcfile" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Recover_DocumentRoot":
             priority => "35" , command => "recover.sh" , arguments => "$document_root docroot" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}


# Exclusion from Load Balancer is managed only if $loadbalancer_ip is set
if ($loadbalancer_ip != "") {
    puppi::deploy {
        "${name}-Load_Balancer_Block":
             priority => "54" , command => "firewall.sh" , arguments => "$loadbalancer_ip on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "56" , command => "firewall.sh" , arguments => "$loadbalancer_ip off" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Load_Balancer_Block":
             priority => "54" , command => "firewall.sh" , arguments => "$loadbalancer_ip on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "56" , command => "firewall.sh" , arguments => "$loadbalancer_ip off" , 
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Application service restart only if $init_script is provided
if ($init_script != "") {
    puppi::deploy {
        "${name}-Service_restart":
             priority => "55" , command => "service.sh" , arguments => "$init_script $service" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Service_restart":
             priority => "55" , command => "service.sh" , arguments => "$init_script $service" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
}


}
