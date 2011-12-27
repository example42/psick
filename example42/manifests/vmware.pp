# Custom project vmware classes

class vmware::example42 inherits vmware {
}

class vmware::example42::client inherits vmware::client {
}

class vmware::example42::server inherits vmware::server {
#    File["vmware.conf"] {
#        content => template("example42/vmware/server/vmware.conf.erb"),
#    }
}

class vmware::example42::monitor inherits vmware::monitor {
}


