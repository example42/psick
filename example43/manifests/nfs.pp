# Custom project nfs classes

class nfs::example43 {
}

class nfs::example43::client inherits nfs::client {
}

class nfs::example43::server inherits nfs::server {
#    File["exports"] {
#        source => [ "puppet:///modules/example43/nfs/exports--$hostname" , 
#                    "puppet:///modules/example43/nfs/exports-$role" , 
#                    "puppet:///modules/example43/nfs/exports" ] ,
#    }
}

class nfs::example43::monitor inherits nfs::monitor {
}
