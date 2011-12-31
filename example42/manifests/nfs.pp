# Custom project nfs classes

class nfs::example42 {
}

class nfs::example42::client inherits nfs::client {
}

class nfs::example42::server inherits nfs::server {
#    File["exports"] {
#        source => [ "puppet:///modules/example42/nfs/exports--$hostname" , 
#                    "puppet:///modules/example42/nfs/exports-$role" , 
#                    "puppet:///modules/example42/nfs/exports" ] ,
#    }
}

class nfs::example42::monitor inherits nfs::monitor {
}
