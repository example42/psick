#
# Class: mysql::password
#
# Set mysql password
#
class mysql::password {

    # Load the variables used in this module. Check the params.pp file 
    require mysql::params

    file { "/root/.my.cnf":
        ensure  => 'file',
        path    => '/root/.my.cnf',
        mode    => 400,
        owner   => 'root',
        group   => 'root',
        content => template('mysql/root.my.cnf.erb'),
        replace => 'false',
        require => Exec['mysql_root_password'],
    }

    exec { "mysql_root_password":
        subscribe   => Package['mysql'],
        require     => Service['mysql'],
        path        => "/bin:/sbin:/usr/bin:/usr/sbin",
        refreshonly => true,
        command     => "mysqladmin -uroot password '${mysql::params::root_password}'";
    }

}
