class oracle::limits {

    file { "limits.conf":
        mode    => 644, owner => root, group => root,
        content => template("oracle/limits.conf"),
        path    => "/etc/security/limits.conf",
    }

    config { "limits.pam":
        file      => "/etc/pam.d/login",
        line      => "session    required    pam_limits.so",
        pattern   => "session   required    pam_limits.so",
        engine    => "line",
    }

}
