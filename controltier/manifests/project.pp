# Define: controltier::project
#
# Define to join/create a project 
#
# Usage:
# controltier::project { $project_name: } 
# controltier::project { production: } 
#
define controltier::project {

    # Load the variables used in this module. Check the params.pp file
    require controltier::params

    exec { "controltier_project_${name}":
        command => "su - ${controltier::params::user} -c 'ctl-project -a create -p ${name}' ",
        require => Exec["controltier_client_setup"] ,
        creates => "${controltier::params::root}/ctl/projects/${name}/etc/project.properties",
        cwd     => "${controltier::params::root}",
    }

}
