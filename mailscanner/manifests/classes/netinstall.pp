class mailscanner::netinstall  {
$mailscanner_extracted_dir = "MailScanner-4.79.11-1"
$mailscanner_source_filename = $operatingsystem ?{
        redhat  => "MailScanner-4.79.11-1.rpm.tar.gz",
        centos  => "MailScanner-4.79.11-1.rpm.tar.gz",
        fedora  => "MailScanner-4.79.11-1.rpm.tar.gz",
        suse    => "MailScanner-4.79.11-1.suse.tar.gz",
        solaris => "MailScanner-install-4.79.11-1.tar.gz",
        freebsd => "MailScanner-install-4.79.11-1.tar.gz",
}
$mailscanner_source_path = $operatingsystem ?{
        redhat  => "http://www.mailscanner.info/files/4/rpm",
        centos  => "http://www.mailscanner.info/files/4/rpm",
        fedora  => "http://www.mailscanner.info/files/4/rpm",
        suse    => "http://www.mailscanner.info/files/4/suse",
        solaris => "http://www.mailscanner.info/files/4/tar",
        freebsd => "http://www.mailscanner.info/files/4/tar",
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
                source_path     => $mailscanner_source_path,
                source_filename => $mailscanner_source_filename,
                extracted_dir   => $mailscanner_extracted_dir,
                preextract_command => $mailscanner_preextract_command,
                postextract_command => "./install.sh",
                destination_dir => $mailscanner_destination_dir
        }

}
