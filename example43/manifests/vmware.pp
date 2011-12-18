# Custom project vmware classes

class vmware::example43 inherits vmware {
}

class vmware::example43::client inherits vmware::client {
}

class vmware::example43::server inherits vmware::server {
#    File["vmware.conf"] {
#        content => template("example43/vmware/server/vmware.conf.erb"),
#    }
}

class vmware::example43::monitor inherits vmware::monitor {
}


