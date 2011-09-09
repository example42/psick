#
# Define: jboss::instance
#
# This defines creates a Jboss instance.
# It has been tested for installations based on source zip.
# Given the huge amount of possible configurations settings that might be defined
# you can provide, where needed, the puppet:///modules location from where to 
# source static files for conf, deploy and deployers directories in your instance.
# The files present in the directories you define on the puppetmaster are copied 
# in the relevant subdir of your instance directory (existing files, not defined in 
# the source directory are preserved).
#
# Parameters:
# user => The user with which the instance will be running 
#         Default: jboss. You can have multiple instances using the same user but 
#         only one has the createuser parameters set to true.
# userid => The userid to force for your user. Default in unset (OS will decide)
# group  => The group with which the instance will be running 
#           Default: jboss. You can have multiple instances using the same group but
#           only one has the createuser parameters set to true.
# userid => The groupid to force for your group. Default in unset (OS will decide)
# createuser => If the define will try to create the user. Default: true
#               Set this to false if the user is already created by other puppet classes
#               or other jboss::instance(s).
# template => The base Jboss template to use as model for your instance.
#             Default: default. Possible values are: all, minimal, standard, default
#             According to what you find, in a fresh installation, in $jboss_dir/server/
# bindaddr => The address where to bind the Jboss instance. Default: 127.0.0.1
# port     => The port where the Jboss instance will listen to. Default: 8080
#             Note (obvious): Do not place multiple instances with the same port on the same IP
#                             Consider that Jboss opens by default other ports besides this one
# run_conf => Source ( as in puppet:///modules/${run_conf} ) from where to get a custom run.conf dedicated
#             to this instance. Default is unset, and Jboss default run.conf is used
#             A sample file is in files/run.conf ( set run_conf => "jboss/run.conf" to use it )
# conf_dir => The source from where you retrieve custom files to be placed in the instance conf dir
#             If defined whatever is placed in source  => "puppet:///modules/${conf_dir}/" will 
#             be recursively synced in the $instance_dir/conf/ directory (existing files are NOT purged).
#             Default is unset (no sync attempt will be made).
# deploy_dir => The source from where you retrieve custom files to be placed in the instance deploy dir
#             If defined whatever is placed in source  => "puppet:///modules/${deploy_dir}/" will 
#             be recursively synced in the $instance_dir/deploy/ directory (existing files are NOT purged).
#             Default is unset (no sync attempt will be made).
# deployers_dir => The source from where you retrieve custom files to be placed in the instance deployers dir
#             If defined whatever is placed in source  => "puppet:///modules/${deployers_dir}/" will 
#             be recursively synced in the $instance_dir/deployers/ directory (existing files are NOT purged).
#             Default is unset (no sync attempt will be made). 
# init_template => You may need to change the initscript of the Jboss instance.
#                  The content of /etc/init.d/jboss-$name is: content => template("$init_template"),
#                  Use this variable to define a different Puppet template source.
#                  Default is: "jboss/jboss.init.erb" (Use it as reference for customization).
# enable => If the instance is actually created and enabled. Default: true
#           If you set this to false since the beginning nothing is done.
#           If you set this to false once it had been already created existing files are kept, but service
#           is stopped and monitoring and puppi extensions are disabled.
#
# Examples:
# Minimal Example based on default settings:
#    jboss::instance { "myapp": }
#
# More elaborated examples:
#    jboss::instance { "myapp":
#        user      => "myapp",   # Default is jboss
#        userid    => "450",     # Default is unset
#        group     => "myapp",   # Default is jboss
#        groupid   => "450",     # Default is unset
#        createuser => true      # Default is true
#        template  => "all",     # Default is default
#        bindaddr  => "0.0.0.0", # Default is 127.0.0.1
#        port      => "80",      # Default is 8080
#        run_conf  => "site/jboss/myapp/run.conf", # Default is unset
#        conf_dir       => "site/jboss/myapp/conf",      # Default is unset
#        deploy_dir     => "site/jboss/myapp/deploy",    # Default is unset
#        deployers_dir  => "site/jboss/myapp/deployers", # Default is unset
#    }
#
define jboss::instance (
    user="jboss",
    userid="",
    group="jboss",
    groupid="",
    createuser=true,
    template="default",
    bindaddr="127.0.0.1",
    port="8080",
    run_conf="",
    conf_dir="",
    deploy_dir="",    
    deployers_dir="",
    init_template="jboss/jboss.init.erb",
    enable=true  
    ) {

    # Load the variables used in this module. Check the params.pp file 
    require jboss::params

    require jboss::prerequisites

    $instance_dir="${jboss::params::destination_dir}/${jboss::params::extracted_dir}/server/${name}"

    if ($enable == true) {
        # Create custom Instance files
        exec { "Clone_Jboss_Instance_$name":
            command  => "cp -a ${template} ${name}",
            cwd      => "${jboss::params::destination_dir}/${jboss::params::extracted_dir}/server/",
            creates  => "${jboss::params::destination_dir}/${jboss::params::extracted_dir}/server/${name}",
            timeout  => 3600,
            require  => Exec["Extract_Jboss"],
        }

        exec { "Set_Jboss_Instance_Permissions_$name":
            command  => "chown -R ${user}:${group} ${instance_dir} && touch ${instance_dir}/.permissions_set",
            cwd      => "${jboss::params::destination_dir}",
            creates  => "${instance_dir}/.permissions_set",
            timeout  => 3600,
            require  => [ Exec["Clone_Jboss_Instance_$name"] , User["${user}"] , Group["$group"] ]
        }
    }

    # Manage Instance service
    service { "jboss-$name":
        ensure     => $enable ? {
            true  => running,
            false => stopped,
        },
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
        require    => "${jboss::params::use_package}" ? {
            yes     => Class["jboss::package"],
            default => Class["jboss::install"],
        },
    }

    if ($enable == true) {
        file { "Jboss_initscript_$name":
            path    => "/etc/init.d/jboss-$name",
            mode    => "755",
            owner   => "root",
            group   => "root",
            before  => Service["jboss-$name"],
            notify  => Service["jboss-$name"],
            content => template("$init_template"),
        }
    }

    # Manage Instance user
    if ($enable == true) and ($createuser == true) {
        @user { "$user":
            uid        => $userid ? {
                ''      => undef,
                default => "${userid}",
            },
            ensure     => present,
            password   => '!',
            managehome => false,
            comment    => "JBoss user",
            shell      => "/bin/bash",
            home       => "${jboss::params::jboss_dir}",
        }
        @group { "$group":
            gid        => $groupid ? {
                ''      => undef,
                default => "${groupid}",
            },
            ensure     => present,
            require    => User["$user"],
        }

        realize User["$user"]
        realize Group["$group"]
    }

    # Manage custom run.conf , if defined
    if ($run_conf != "") and ($enable == true) {
        file { "jboss_run_conf_${name}":
            path    => "${instance_dir}/run.conf",
            owner   => "${user}",
            group   => "${group}",
            require => Exec["Set_Jboss_Instance_Permissions_$name"],
            notify  => Service["jboss-${name}"],
            source  => "puppet:///modules/${run_conf}",
        }
    }

    # Manage conf dir, if defined
    if ($conf_dir != "") and ($enable == true) {
        file { "jboss_confdir_${name}":
            path    => "${instance_dir}/conf/",
            owner   => "${user}",
            group   => "${group}",
            require => Exec["Set_Jboss_Instance_Permissions_$name"],
            notify  => Service["jboss-${name}"],
            recurse => true,
            ignore  => ".svn",
            source  => "puppet:///modules/${conf_dir}/",
        }
    }

    # Manage deploy dir, if defined
    if ($deploy_dir != "") and ($enable == true) {
        file { "jboss_deploydir_${name}":
            path    => "${instance_dir}/deploy/",
            owner   => "${user}",
            group   => "${group}",
            require => Exec["Set_Jboss_Instance_Permissions_$name"],
            notify  => Service["jboss-${name}"],
            recurse => true,
            ignore  => ".svn",
            source  => "puppet:///modules/${deploy_dir}/",
        }
    }

    # Manage deployers dir, if defined
    if ($deployers_dir != "") and ($enable == true) {
        file { "jboss_deployersdir_${name}":
            path    => "${instance_dir}/deployers/",
            owner   => "${user}",
            group   => "${group}",
            require => Exec["Set_Jboss_Instance_Permissions_$name"],
            notify  => Service["jboss-${name}"],
            recurse => true,
            ignore  => ".svn",
            source  => "puppet:///modules/${deployers_dir}/",
        }
    }

    # Automatic monitoring, if enabled
    if $monitor == "yes" { 
        monitor::port { "jboss_${jboss::params::protocol}_${port}": 
            protocol => "${jboss::params::protocol}",
            port     => "${port}",
            target   => "${bindaddr}",
            enable   => "${enable}",
            tool     => "${monitor_tool}",
        }
    }

    # Puppi addons, if puppi is enabled
    if ($puppi == "yes") and ($enable == true) {
        puppi::info::module { "jboss-${name}":
            servicename => "jboss-${name}",
            processname => "${jboss::params::processname}",
            configdir   => [ "${jboss::params::jboss_dir}/bin" , "${jboss::params::jboss_dir}/server/${name}/conf" ],
            datadir     => [ "${instance_dir}/deploy" , "${instance_dir}/deployers" ],
            logdir      => "${jboss::params::jboss_dir}/server/${name}/log",
            protocol    => "${jboss::params::protocol}",
            port        => "${port}",
            description => "What Puppet knows about jboss instance $name" ,
            # run         => "jboss -V###",
        }
        puppi::log { "jboss-${name}":
            description => "Logs of jboss instance ${name}" ,  
            log      => [ "${instance_dir}/log/server.log" , "${instance_dir}/log/boot.log" ],
        }
    }

}
