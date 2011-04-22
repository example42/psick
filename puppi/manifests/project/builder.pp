# Define puppi::project::builder
#
# This is a shortcut define to build a puppi project for the deploy of we applications
# based on different sources: a war file, a tar file, a source dir, a list of files or a nexus maven repository
# It uses different existing "core" defines (puppi::project, puppi:deploy (many) , puppi::rollback (many) 
# to build a full featured template project for automatic deployments.
# If you need to customize it, either change the template defined here or build up your own custom ones.
#
# Variables:
# $source - The full URL of the main file to retrieve. Format should be in URI standard (http:// file:// ssh:// svn:// rsync://)
# $source_type - The type of file that is retrived. Accepted values: tarball, zip, list, war, dir, maven-metadata  
# $deploy_root - The destination directory where the retrieve file(s) have to be deployed
# $init_source (Optional) - The full URL to be used to retrieve, for the first time, the project files.
#                           They are copied to the $deploy_root
#                           Format should be in URI standard (http:// file:// ssh:// svn://)
# $magicfix (Optional) - A string that is used as prefix or suffix according to the context and the scripts used in the
#                        deploy procedure
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
# $disable_services (Optional) - The names (space separated) of the services you might want to stop
#                                during deploy. By default is blank. Example: "apache puppet monit"
# $firewall_src_ip (Optional) - The IP address of a loadbalancer you might want to block during deploy
# $firewall_dst_port (Optional) - The local port to block from the loadbalancer during deploy (Default all)
# $report_email (Optional) - The (space separated) email(s) to notify of deploy/rollback operations
# $backup (Optional) - If and how backups of files are made. Default: "full". Possible values:
#                      "full" - Make full backup of the deploy_root before making the deploy
#                      "diff" - Backup only the files that are going to be deployed. Note that in order to make reliable rollbacks of versions
#                               older that the latest you've to individually rollback every intermediate deploy
#                      "false" - Don not make backups. This disables the option to make rollbacks
# $backup_rsync_options (Optional) - The extra options to pass to rsync for backup operations. Use this, for example, to exclude 
#                                    directories that you don't want to archive.
#                                    IE: "--exclude .snapshot --exclude cache --exclude www/cache"
# $run_checks (Optional) - If you want to run local puppi checks before and after the deploy procedure. Default: "true"
#
define puppi::project::builder (
    $source,
    $source_type,
    $deploy_root,
    $init_source="",
    $user="root",
    $magicfix="",
    $predeploy_customcommand="",
    $predeploy_user="",
    $predeploy_priority="39",
    $postdeploy_customcommand="",
    $postdeploy_user="",
    $postdeploy_priority="41",
    $disable_services="",
    $firewall_src_ip="",
    $firewall_dst_port="0",
    $report_email="",
    $backup="full",
    $backup_rsync_options="--exclude .snapshot",
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

    $real_source_type = $source_type ? {
        "dir"            => "dir",
        "tarball"        => "tarball",
        "zip"            => "zip",
        "maven-metadata" => "maven-metadata",
        "maven"          => "maven-metadata",
        "war"            => "war",
        "list"           => "list",
    }

    $source_filename = urlfilename($source)

# Create Project
    puppi::project { $name: enable => $enable }


# Populate Project scripts for initialize
if ($init_source != "") {
    puppi::initialize {
        "${name}-Deploy_Files":
             priority => "40" , command => "get_file.sh" , arguments => "-s $init_source -d $deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable ;
    }
}
 
# Common Defines
    puppi::deploy {
        "${name}-Retrieve_SourceFile":
             priority => "20" , command => "get_file.sh" , arguments => "-s $source -t $real_source_type" ,
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Deploy":
             priority => "40" , command => "deploy.sh" , arguments => "$deploy_root" ,
             user => "$user" , project => "$name" , enable => $enable;
    }


# MANAGE Custom predeploy operations according to $source_type
if ($real_source_type == "tarball") {
    puppi::deploy {
        "${name}-PreDeploy_Tar":
             priority => "25" , command => "predeploy.sh" , 
             arguments => $magicfix ? { '' => "", default => "-m $magicfix" , },
             user => "$root" , project => "$name" , enable => $enable;
    }
}

if ($real_source_type == "zip") {
    puppi::deploy {
        "${name}-PreDeploy_Zip":
             priority => "25" , command => "predeploy.sh" , 
             arguments => $magicfix ? { '' => "", default => "-m $magicfix" , },
             user => "$root" , project => "$name" , enable => $enable;
    }
}

if ($real_source_type == "list") {
    puppi::deploy {
        "${name}-Extract_File_Metadata":
             priority => "22" , command => "get_metadata.sh" ,
             arguments => $magicfix ? { '' => "", default => "-m $magicfix" , },
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Clean_File_List":
             priority => "24" , command => "clean_filelist.sh" ,
             arguments => $magicfix ? { '' => "", default => "$magicfix" , },
             user => "root" , project => "$name" , enable => $enable ;
        "${name}-Retrieve_Files":
             priority => "25" , command => "get_filesfromlist.sh" , arguments => "$source_baseurl" ,
             user => "root" , project => "$name" , enable => $enable ;
    }
}

if ($real_source_type == "dir") {
}

if ($real_source_type == "war") {
    puppi::deploy {
        "${name}-PreDeploy_War":
             priority => "25" , command => "predeploy.sh" ,
             arguments => $magicfix ? { '' => "", default => "-m $magicfix" , },
             user => "$root" , project => "$name" , enable => $enable;
        "${name}-Remove_existing_WAR":
             priority => "35" , command => "delete.sh" , arguments => "$deploy_root/$source_filename" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Check_undeploy":
             priority => "37" , command => "checkwardir.sh" , arguments => "-a $deploy_root/$source_filename" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Check_deploy":
             priority => "43" , command => "checkwardir.sh" , arguments => "-p $deploy_root/$source_filename" ,
             user => "$user" , project => "$name" , enable => $enable;
    }

    puppi::rollback {
        "${name}-Remove_existing_WAR":
             priority => "30" , command => "delete.sh" , arguments => "$deploy_root/$source_filename" ,
             user => "root" , project => "$name" , enable => $enable;
        "${name}-Check_undeploy":
             priority => "37" , command => "checkwardir.sh" , arguments => "-a $deploy_root/$source_filename" ,
             user => "$user" , project => "$name" , enable => $enable;
        "${name}-Check_deploy":
             priority => "43" , command => "checkwardir.sh" , arguments => "-p $deploy_root/$source_filename" ,
             user => "$user" , project => "$name" , enable => $enable;
    }
}


# Make backups before deploying files
if ($backup == "full") or ($backup == "diff") {
    puppi::deploy {
        "${name}-Backup_existing_Files":
             priority => "30" , command => "archive.sh" , arguments => "-b $deploy_root -m $backup -o '$backup_rsync_options'" ,
             user => "root" , project => "$name" , enable => $enable;
    }

    puppi::rollback {
        "${name}-Recover_Files_To_Deploy":
             priority => "40" , command => "archive.sh" , arguments => "-r $deploy_root -m $backup -o '$backup_rsync_options'" ,
             user => "$user" , project => "$name" , enable => $enable;
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
