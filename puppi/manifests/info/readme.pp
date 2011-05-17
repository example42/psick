# Define puppi::info::readme
#
# This is a puppi info plugin that provides a Readme text which can be
# used to show local info on the managed server and eventually run custom commands.
# 
#    puppi::info::readme { "myapp":
#        description => "Guidelines for myapp setup",
#        readme => "myapp/readme.txt" ,
#        run         => "myapp -V",
#    }
#
define puppi::info::readme (
    $description="",
    $readme="",
    $autoreadme="no",
    $run="",
    $templatefile="puppi/info/readme.erb" ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    file { "${puppi::params::infodir}/${name}":
        mode    => "750",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => Class["puppi"],
        content => template("$templatefile"),
        tag     => 'puppi_info',
    }

    file { "${puppi::params::readmedir}/${name}":
        mode    => "644",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => File["puppi_readmedir"],
        source  => $readme ? {
            ''  => [ "${puppi::params::general_base_source}/puppi/${my_project}/info/readme/readme" , 
                     "${puppi::params::general_base_source}/puppi/info/readme/readme" ],
            default => "${readme}" ,
        },
        tag     => 'puppi_info',
    }

  if $autoreadme == "yes" {
    file { "${puppi::params::readmedir}/${name}-custom":
        mode    => "644",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => File["puppi_readmedir"],
        source  => [ "${puppi::params::general_base_source}/puppi/${my_project}/info/readme/readme--${hostname}" ,
                     "${puppi::params::general_base_source}/puppi/${my_project}/info/readme/readme-${role}" ,
                     "${puppi::params::general_base_source}/puppi/${my_project}/info/readme/readme-default" ,
                     "${puppi::params::general_base_source}/puppi/info/readme/readme--${hostname}" ,
                     "${puppi::params::general_base_source}/puppi/info/readme/readme-${role}" ,
                     "${puppi::params::general_base_source}/puppi/info/readme/readme-default" ],
        tag     => 'puppi_info',
    }
  }

}
