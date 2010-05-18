class mailscanner::netinstall  {

include mailscanner::params

# MailScanner prerequisites is done in a separated resource
    exec { "MailScannerPrerequisites":
        command     => "yum install -y ${mailscanner::params::prerequisites}",
        unless      => "rpm -qi ${mailscanner::params::prerequisites}",
        timeout     => 3600,
    }

    netinstall { mailscanner:
        url         => "${mailscanner::params::source_url}",
        extracted_dir   => "${mailscanner::params::extracted_dir}",
#        preextract_command => "${mailscanner::params::preextract_command}",
#        postextract_command => "${mailscanner::params::destination_dir}/${mailscanner::params::extracted_dir}/install.sh",
        destination_dir => "${mailscanner::params::destination_dir}",
        before      => Exec["MailScannerBuildAndInstall"],
        require     => Exec["MailScannerPrerequisites"],
    }


# MailScanner RPMS build and install is better done in a separated, more controllable, resource
    exec { "MailScannerBuildAndInstall":
        command     => "./install.sh",
        cwd         => "${mailscanner::params::destination_dir}/${mailscanner::params::extracted_dir}",
        unless      => "rpm -qi mailscanner",
        timeout     => 3600,
        require     => Netinstall["mailscanner"],
    }

}
