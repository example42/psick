# Define puppi::project::maven
#
# This is a shortcut define to build a puppi project for Tomcat deployments
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for Tomcat deployments.
# If you need to customize it, either change the template defined here or build up yourn custom ones.
#
define puppi::project::maven (
    $source,
    $user,
    $deploy_root,
    $document_root='',
    $config_root='',
    $report_email,
    $init_script='',
    $suffix='',
    $firewall_src_ip="",
    $firewall_dst_port="0",
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
        "${name}-Get_Maven_Metadata_File":
             priority => "20" , command => "get_file.sh" , arguments => "$source/maven-metadata.xml maven-metadata" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Extract_Maven_Metadata":
             priority => "22" , command => "get_metadata.sh" ,
             arguments => $suffix ? {
                 ''      => "",
                 default => "-m $suffix" ,
             },
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Get_Maven_Files_WAR":
             priority => "25" , command => "get_maven_files.sh" , arguments => "$source warfile" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_WAR":
             priority => "30" , command => "archive.sh" , arguments => "-b $deploy_root -t war" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_Maven_WAR":
             priority => "40" , command => "deploy.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Run_POST-Checks":
             priority => "80" , command => "check_project.sh" , arguments => "$name" ,
             user => "root" , project => "$name" , enable => $enable ;
    }


    puppi::rollback {
        "${name}-Recover_WAR":
             priority => "30" , command => "archive.sh" , arguments => "-r $deploy_root -t war" ,
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
             priority => "26" , command => "get_maven_files.sh" , arguments => "$source configfile" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_ConfigDir":
             priority => "37" , command => "archive.sh" , arguments => "-b $config_root -t config" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_Maven_ConfigDir":
             priority => "47" , command => "deploy_tar.sh" , arguments => "$config_root configfile" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Recover_ConfigDir":
             priority => "37" , command => "archive.sh" , arguments => "-r $config_root -t config" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Docroot tar is managed only if $document_root is set
if ($document_root != "") {
    puppi::deploy {
        "${name}-Get_Maven_Files_SRC":
             priority => "27" , command => "get_maven_files.sh" , arguments => "$source srcfile" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Backup_existing_DocumentRoot":
             priority => "35" , command => "archive.sh" , arguments => "-b $document_root -t docroot" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Deploy_Maven_DocumentRoot":
             priority => "45" , command => "deploy_tar.sh" , arguments => "$document_root srcfile" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Recover_DocumentRoot":
             priority => "35" , command => "archive.sh" , arguments => "-r $document_root -t docroot" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}


# Exclusion from Load Balancer is managed only if $firewall_src_ip is set
if ($firewall_src_ip != "") {
    puppi::deploy {
        "${name}-Load_Balancer_Block":
             priority => "29" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "55" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
             user => "root" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Load_Balancer_Block":
             priority => "29" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port on" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Load_Balancer_Unblock":
             priority => "55" , command => "firewall.sh" , arguments => "$firewall_src_ip $firewall_dst_port off" ,
             user => "root" , project => "$name" , enable => $enable;
    }
}

# Application service restart only if $init_script is provided
if ($init_script != "") {
    puppi::deploy {
        "${name}-Service_restart":
             priority => "55" , command => "service.sh" , arguments => "$service $init_script" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
    puppi::rollback {
        "${name}-Service_restart":
             priority => "55" , command => "service.sh" , arguments => "$service $init_script" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
}


}
