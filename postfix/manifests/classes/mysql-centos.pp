# Class: postfix::mysql::centos
#
# This class installs Postfix with Mysql backend on Centos/RedHat
# Some tweaks are necessary to use the CentosPlus version of postfix with mysql support instead of the default one
#
class postfix::mysql::centos {

    exec {
        "RemoveNormalPostfix":
            command => "rpm -e --nodeps postfix ; true",
            unless  => "postconf -m | grep mysql",
            before  => Package["postfix"],
    }

    include repo::postfix

}

class postfix::mysql::centos-inline {
#Alternative approach that changes only the relevant lines on existing repo files

    exec {
        "RemoveNormalPostfix":
            command => "rpm -e --nodeps postfix ; true",
            unless  => "postconf -m | grep mysql",
            before  => Package["postfix"],
    }

    config { "ExcludePostfixBase":
        file      => "/etc/yum.repos.d/CentOS-Base.repo",
        parameter => "base/exclude",
        value     => "postfix",
        engine    => "augeas",
        before    => Package["postfix"],
    }

    config { "ExcludePostfixUpdate":
        file      => "/etc/yum.repos.d/CentOS-Base.repo",
        parameter => "updates/exclude",
        value     => "postfix",
        engine    => "augeas",
        before    => Package["postfix"],
    }

    config { "IncludePostfixCentosPlus":
        file      => "/etc/yum.repos.d/CentOS-Base.repo",
        parameter => "centosplus/includepkgs",
        value     => "postfix",
        engine    => "augeas",
        before    => Package["postfix"],
    }

    config { "EnableCentosPlus":
        file      => "/etc/yum.repos.d/CentOS-Base.repo",
        parameter => "centosplus/enabled",
        value     => "1",
        engine    => "augeas",
        before    => Package["postfix"],
    }

}
