# Custom project samba classes

class samba::example43 inherits samba {
#    File["samba.conf"] {
#        source => [ "puppet:///modules/example43/samba/smb.conf--$hostname" ,
#                    "puppet:///modules/example43/samba/smb.conf-$role" ,
#                    "puppet:///modules/example43/samba/smb.conf" ] ,
#    }
}

class samba::example43::client inherits samba::client {
}

class samba::example43::server inherits samba::server {
}

class samba::example43::monitor inherits samba::monitor {
}

