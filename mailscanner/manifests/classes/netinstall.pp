class mailscanner::netinstall  {
$mailscanner_extracted_dir = "MailScanner-4.79.11-1"
$mailscanner_source_url = $operatingsystem ?{
        redhat  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
        centos  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
        fedora  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
        suse    => "http://www.mailscanner.info/files/4/suse/MailScanner-4.79.11-1.suse.tar.gz",
        solaris => "http://www.mailscanner.info/files/4/tar/MailScanner-install-4.79.11-1.tar.gz",
        freebsd => "http://www.mailscanner.info/files/4/tar/MailScanner-install-4.79.11-1.tar.gz",
}
$mailscanner_destination_dir = $operatingsystem ?{
        default => "/usr/src/",
}
$mailscanner_preextract_command = $operatingsystem ?{
        redhat => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
        centos => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
        fedora => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
        default => undef,
}


        netinstall { mailscanner:
                url             => $mailscanner_source_url,
                extracted_dir   => $mailscanner_extracted_dir,
                preextract_command => "$mailscanner_preextract_command",
#                postextract_command => "$mailscanner_destination_dir/$mailscanner_extracted_dir/install.sh",
                destination_dir => $mailscanner_destination_dir,
                before          => Exec["MailScannerBuildAndInstall"],
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
