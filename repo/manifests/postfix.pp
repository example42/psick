class repo::postfix inherits repo {

    File["/etc/yum.repos.d/CentOS-Base.repo"] {
        source => "puppet://$servername/repo/postfix/CentOS-Base.repo",
    }

}
