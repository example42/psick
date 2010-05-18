define adduser ( $uid='', $gid='', $shell='/bin/bash', $home='', $comment='', $password='', $groups='' ) {

    user {
        "$name":
# Temp fix for err: //Node[test.example42.com]/general/hardening::eal4/users::admins/Adduser[admin]/User[admin]/uid: change from 500 to  failed: Could not set uid on user[admin]: Execution of '/usr/sbin/usermod -u  admin' returned 4: usermod: uid 0 is not unique
# Uncomment and fix when necessary
#            uid      => $uid,
#            gid      => $gid,
            shell    => $shell,
            comment  => $comment,
            home     => $home,
            password => $password,
            groups   => $groups,
            ensure   => present,
       }
}
