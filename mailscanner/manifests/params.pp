class mailscanner::params  {

$conf = $operatingsystem ?{
    default  => "/etc/MailScanner/MailScanner.conf",
}

$extracted_dir = "MailScanner-4.79.11-1"

$source_url = $operatingsystem ?{
    redhat  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
    centos  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
    fedora  => "http://www.mailscanner.info/files/4/rpm/MailScanner-4.79.11-1.rpm.tar.gz",
    suse    => "http://www.mailscanner.info/files/4/suse/MailScanner-4.79.11-1.suse.tar.gz",
    solaris => "http://www.mailscanner.info/files/4/tar/MailScanner-install-4.79.11-1.tar.gz",
    freebsd => "http://www.mailscanner.info/files/4/tar/MailScanner-install-4.79.11-1.tar.gz",
    default => undef,
}

$destination_dir = $operatingsystem ?{
    default => "/usr/src/",
}

$preextract_command = $operatingsystem ?{
    redhat => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
    centos => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
    fedora => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
    default => undef,
}

$prerequisites = $operatingsystem ?{
    redhat => "wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
    centos => "wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
    fedora => "wget tar gzip rpm-build binutils glibc-devel gcc make perl-DBD-SQLite",
    default => undef,
}

$custom_functions_dir = $operatingsystem ?{
    debian  => "/usr/share/MailScanner/MailScanner/CustomFunctions",
    ubuntu  => "/usr/share/MailScanner/MailScanner/CustomFunctions",
    default => "/usr/lib/MailScanner/MailScanner/CustomFunctions",
}


# MailWatch parameters

$mailwatch_extracted_dir = "mailwatch-1.0.5"

$mailwatch_source_url = "http://downloads.sourceforge.net/project/mailwatch/mailwatch/1.0.5/mailwatch-1.0.5.tar.gz?use_mirror=surfnet"

$mailwatch_destination_dir = $operatingsystem ?{
    default => "/usr/src/",
}

$mailwatch_webdir = $operatingsystem ?{
    debian  => "/var/www/mailscanner",
    ubuntu  => "/var/www/mailscanner",
    suse    => "/srv/www/mailscanner",
    default => "/var/www/html/mailscanner",
}

$mailwatchconf = "$mailwatch_webdir/conf.php"

}
