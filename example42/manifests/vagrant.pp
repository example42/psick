# Custom project vagrant classes

class vagrant::example42 inherits vagrant {
}

class vagrant::example42::client inherits vagrant::client {
}

class vagrant::example42::server inherits vagrant::server {
#    File["vagrant.conf"] {
#        content => template("example42/vagrant/server/vagrant.conf.erb"),
#    }
}

class vagrant::example42::monitor inherits vagrant::monitor {
}

