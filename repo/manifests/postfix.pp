class repo::postfix inherits repo {

        File["/etc/yum.repos.d/CentOS-Base.repo"] {
                source => "puppet://$servername/postfix/repo/CentOS-Base.repo",
        }

}
