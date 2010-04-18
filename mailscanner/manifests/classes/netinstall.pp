class mailscanner::netinstall  {

include mailscanner::params

# MailScanner prerequisites is done in a separated resource
        exec { "MailScannerPrerequisites":
                command         => "yum install -y $mailscanner_prerequisites",
                unless          => "rpm -qi $mailscanner_prerequisites",
                timeout         => 3600,
        }

        netinstall { mailscanner:
                url             => $mailscanner_source_url,
                extracted_dir   => $mailscanner_extracted_dir,
#                preextract_command => "$mailscanner_preextract_command",
#                postextract_command => "$mailscanner_destination_dir/$mailscanner_extracted_dir/install.sh",
                destination_dir => $mailscanner_destination_dir,
                before          => Exec["MailScannerBuildAndInstall"],
                require         => Exec["MailScannerPrerequisites"],
        }


# MailScanner RPMS build and install is better done in a separated, more controllable, resource
        exec { "MailScannerBuildAndInstall":
                command         => "./install.sh",
                cwd             => "$mailscanner_destination_dir/$mailscanner_extracted_dir",
                unless          => "rpm -qi mailscanner",
                timeout         => 3600,
                require         => Netinstall["mailscanner"],
        }

}
