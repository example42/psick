# Quick implementation with database creation and default role grants
# Requires a db name ($name) and a role. To be adapted for specific cases
#
define postgresql::dbcreate ($role , $password='' , $conntype="host" , $address='127.0.0.1/32' , $auth_method="md5" , $auth_options="" , $usertype="nosuperuser") {
    exec { "role_$name":
        user    => "${postgresql::params::processuser}",
        unless  => "echo \\\\dg | psql | grep $name 2>/dev/null",
        command => "echo \"create role $name $usertype nocreatedb nocreaterole noinherit nologin ; create role $role nosuperuser nocreatedb nocreaterole noinherit login encrypted password '$password'; grant $name to $role; create database $name with owner=$role;\" | /usr/bin/psql",
        require => Service["postgresql"],
    }

    postgresql::hba { "hba_$name":
        ensure   => 'present',
        type     => $conntype,
        database => $name,
        user     => $role,
        address  => $address,
        method   => $auth_method,
        option   => $auth_options,
    }
}
