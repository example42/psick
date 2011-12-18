# Custom project vagrant classes

class vagrant::example43 inherits vagrant {
}

class vagrant::example43::client inherits vagrant::client {
}

class vagrant::example43::server inherits vagrant::server {
#    File["vagrant.conf"] {
#        content => template("example43/vagrant/server/vagrant.conf.erb"),
#    }
}

class vagrant::example43::monitor inherits vagrant::monitor {
}

