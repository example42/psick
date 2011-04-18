# Class: postfix::mysql::redhat
#
# This class installs Postfix with Mysql backend on RedHat
# Some tweaks are necessary to use the CentosPlus version of postfix with mysql support
# This is a quick fix. You may need to change the repo file definition
# (check also postfix::mysql::centos to see what it has to be done on base repos)
#
class postfix::mysql::redhat {

    exec {
        "RemoveNormalPostfix":
        command => "rpm -e --nodeps postfix ; true",
        unless  => "postconf -m | grep mysql",
        before  => Package["postfix"],
    }

    file {
        "/etc/yum.repos.d/CentOS-Plus.repo":
        mode => 644, owner => root, group => root,
        before => Exec["RemoveNormalPostfix"],
        ensure => present,
        source => "puppet://$servername/repo/postfix/CentOS-Plus.repo"
    }

}
