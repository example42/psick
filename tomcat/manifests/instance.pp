# Define: tomcat::instance
#
# Original author: Marco Bonetti
# Adapted for Example42 by Alessandro Franceschi
# Tested only on Ubuntu
#
# Tomcat user instance
#
# Usage:
# With standard template:
# tomcat::instance    { "name": }
#
define tomcat::instance (
    $dirmode='',
    $filemode='',
    $owner='',
    $group='',
    $httpport='',
    $controlport='',
    $ajpport='',
    $magicword='',
    $backupsdir='',
    $rundir='',
    $logdir='',
    $inittemplate='',
    $serverxmltemplate='',
    $tomcatusersxmltemplate='',
    $webxmltemplate=''
) {

    require tomcat::params

    # Application name, required
    $instance_name = "$name"

    # Application directory mode
    $instance_dirmode = $dirmode ? {
        ''      => "755",
	default => $dirmode,
    }

    # Application file mode
    $instance_filemode = $filemode ? {
        ''      => "644",
	default => $filemode,
    }

    # Application owner
    $instance_owner = $owner ? {
        ''      => "$name",
	default => $owner,
    }

    # Application group
    $instance_group = $group ? {
        ''      => "$name",
	default => $group,
    }

    # HTTP port
    $instance_httpport = $httpport ? {
        ''      => "8080",
	default => $httpport,
    }

    # Control port
    $instance_controlport = $controlport ? {
        ''      => "8005",
	default => $controlport,
    }

    # AJP proxy port - Used in server.xml-default template
    # Note: YOU MUST explicitely define a template name in $serverxmltemplate to use one 
    # By default the script that creates an instance doesn't set the ajp port
    $instance_ajpport = $ajpport ? {
        ''      => "8009",
        default => $ajpport,
    }

    # Magic word
    $instance_magicword = $magicword ? {
        ''      => "SHUTDOWN",
	default => $magicword,
    }

    # Backups dir
    $instance_backupsdir = $backupsdir ? {
        ''      => "${tomcat::params::storedir}/${instance_name}/backups",
	default => $backupsdir,
    }

    # Run dir
    $instance_rundir = $rundir ? {
        ''      => "${tomcat::params::storedir}/${instance_name}/run",
	default => $rundir,
    }

    # Log dir
    $instance_logdir = $logdir ? {
        ''      => "${tomcat::params::storedir}/${instance_name}/logs",
	default => $logdir,
    }

    # Initd template file
    $instance_inittemplate = $inittemplate ? {
        ''      => "init.erb",
	default => $inittemplate,
    }

    # Startup script
    $instance_startup = "${tomcat::params::storedir}/${instance_name}/bin/startup.sh"

    # Shutdown script
    $instance_shutdown = "${tomcat::params::storedir}/${instance_name}/bin/shutdown.sh"

    # Create instance
    exec { "instance_tomcat_${instance_name}":
        command => "chown ${instance_owner}:${instance_group} ${tomcat::params::storedir} && su - ${instance_owner} -c '/usr/bin/tomcat6-instance-create -p ${instance_httpport} -c ${instance_controlport} -w ${instance_magicword} ${tomcat::params::storedir}/${instance_name}' && chown ${tomcat::params::storedir_owner}:${tomcat::params::storedir_group} ${tomcat::params::storedir}",
        creates => "${tomcat::params::storedir}/${instance_name}/webapps",
	require => Package["tomcat"],
    }

    # Create backups dir
    file { "tomcat_backupsdir-${instance_name}":
        path    => "${instance_backupsdir}",
        mode    => "${instance_dirmode}",
        owner   => "${instance_owner}",
        group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        ensure  => directory,
    }

    # Create run dir
    file { "tomcat_rundir-${instance_name}":
        path    => "${instance_rundir}",
        mode    => "${instance_dirmode}",
        owner   => "${instance_owner}",
        group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        ensure  => directory,
    }

    # Create log dir
    file { "tomcat_logdir-${instance_name}":
        path    => "${instance_logdir}",
        mode    => "${instance_dirmode}",
        owner   => "${instance_owner}",
        group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        ensure  => directory,
    }
    # Running service
    service {"tomcat-${instance_name}":
        name       => "${tomcat::params::servicename}-${instance_name}",
        ensure     => running,
        enable     => true,
        pattern    => "${instance_name}",
        hasrestart => true,
        hasstatus  => "${tomcat::params::hasstatus}",
        require    => Exec["instance_tomcat_${instance_name}"],
        subscribe  => File["instance_tomcat_initd_${instance_name}"],
    }

    # Create initd file
    file { "instance_tomcat_initd_${instance_name}":
        path    => "${tomcat::params::initdfile}-${instance_name}",
        mode    => "${tomcat::params::initdfile_mode}",
        owner   => "${tomcat::params::initdfile_owner}",
        group   => "${tomcat::params::initdfile_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
        content => template("tomcat/${instance_inittemplate}"),
    }

    # Ensure catalina.properties presence
    file { "instance_tomcat_catalina.properties_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/conf/catalina.properties",
        mode    => "${instance_filemode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
    }

    # Ensure context.xml presence
    file { "instance_tomcat_context.xml_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/conf/context.xml",
        mode    => "${instance_filemode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
    }

    # Ensure logging.properties presence
    file { "instance_tomcat_logging.properties_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/conf/logging.properties",
        mode    => "${instance_filemode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
    }

    # Ensure setenv.sh presence
    file { "instance_tomcat_setenv.sh_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/bin/setenv.sh",
        mode    => "${tomcat::params::initdfile_mode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
	source  => [
            "puppet:///tomcat/setenv.sh--$hostname",
            "puppet:///tomcat/setenv.sh-$role-$type",
            "puppet:///tomcat/setenv.sh-$role",
            "puppet:///tomcat/setenv.sh"
        ],
    }

    # Ensure server.xml presence
    file { "instance_tomcat_server.xml_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/conf/server.xml",
        mode    => "${instance_filemode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
	content => $serverxmltemplate ? {
	    ''      => undef,
	    default => template("$serverxmltemplate"),
	},
    }

    # Ensure tomcat-users.xml presence
    file { "instance_tomcat_tomcat-users.xml_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/conf/tomcat-users.xml",
        mode    => "${instance_filemode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
	content => $tomcatusersxmltemplate ? {
	    ''      => undef,
	    default => template("$tomcatusersxmltemplate"),
	},
    }

    # Ensure web.xml presence
    file { "instance_tomcat_web.xml_${instance_name}":
        path    => "${tomcat::params::storedir}/${instance_name}/conf/web.xml",
        mode    => "${instance_filemode}",
        owner   => "${instance_owner}",
	group   => "${instance_group}",
        require => Exec["instance_tomcat_${instance_name}"],
        notify  => Service["tomcat-${instance_name}"],
        ensure  => present,
	content => $webxmltemplate ? {
	    ''      => undef,
	    default => template("$webxmltemplate"),
	},
    }

    # Automatic monitoring
    monitor::process { "tomcat-${instance_name}":
        process  => "java",
        argument => "${instance_name}",
        service  => "tomcat-${instance_name}",
        pidfile  => "${instance_rundir}/tomcat-${instance_name}.pid",
        enable   => "true",
        tool     => "${monitor_tool}",
    }

    monitor::port { "tomcat_tcp_${instance_httpport}": 
        protocol => "tcp",
        port     => "${instance_httpport}",
        target   => "${fqdn}",
        enable   => "true",
        tool     => "${monitor_tool}",
    }

}

