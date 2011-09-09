#
# Class: jboss::install
#
# Installs jboss from zip
#
class jboss::install {

    # Load the variables used in this module. Check the params.pp file 
    require jboss::params

    require jboss::prerequisites

    exec { "Download_Jboss":
        command  => "curl -L ${jboss::params::source_url} -o ${jboss::params::download_dir}/${jboss::params::source_filename}",
        cwd      => "${jboss::params::download_dir}",
        creates  => "${jboss::params::download_dir}/${jboss::params::source_filename}",
        timeout  => 3600,
    }

    exec { "Extract_Jboss":
        command  => "unzip ${jboss::params::download_dir}/${jboss::params::source_filename}",
        cwd      => "${jboss::params::destination_dir}",
        creates  => "${jboss::params::destination_dir}/${jboss::params::extracted_dir}",
        timeout  => 3600,
        require  => Exec["Download_Jboss"],
    }

    file { "Jboss_basedir_link":
        path     => "${jboss::params::jboss_dir}",
        ensure   => "${jboss::params::destination_dir}/${jboss::params::extracted_dir}",
    }

}
