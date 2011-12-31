# Custom project samba classes

class samba::example42 inherits samba {
#    File["samba.conf"] {
#        source => [ "puppet:///modules/example42/samba/smb.conf--$hostname" ,
#                    "puppet:///modules/example42/samba/smb.conf-$role" ,
#                    "puppet:///modules/example42/samba/smb.conf" ] ,
#    }
}

class samba::example42::client inherits samba::client {
}

class samba::example42::server inherits samba::server {
}

class samba::example42::monitor inherits samba::monitor {
}

