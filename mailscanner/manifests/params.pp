class mailscanner::params  {

$mailscanner_extracted_dir = "MailScanner-4.79.11-1"

$mailscanner_source_url = $operatingsystem ?{
        redhat  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
        centos  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
        fedora  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
        suse    => "http://www.mailscanner.info/files/4/suse/MailScanner-4.79.11-1.suse.tar.gz",
        solaris => "http://www.mailscanner.info/files/4/tar/MailScanner-install-4.79.11-1.tar.gz",
        freebsd => "http://www.mailscanner.info/files/4/tar/MailScanner-install-4.79.11-1.tar.gz",
        default => undef,
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

$mailscanner_prerequisites = $operatingsystem ?{
        redhat => "wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
        centos => "wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
        fedora => "wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
        default => undef,
}

$mailscanner_custom_functions_dir = $operatingsystem ?{
        debian  => "/usr/share/MailScanner/MailScanner/CustomFunctions",
        ubuntu  => "/usr/share/MailScanner/MailScanner/CustomFunctions",
        default => "/usr/lib/MailScanner/MailScanner/CustomFunctions",
}

}
