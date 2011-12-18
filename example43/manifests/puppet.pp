# Custom project puppet classes

class puppet::example43 {
}

class puppet::example43::client inherits puppet::client {
#    File["puppet.conf"] {
#        content => template("example43/puppet/client/puppet.conf.erb"),
#    }
}

class puppet::example43::server inherits puppet::server {
#    File["puppet.conf"] {
#        content => template("example43/puppet/server/puppet.conf.erb"),
#    }
#    File["namespaceauth.conf"] {
#        content => template("example43/puppet/server/namespaceauth.conf.erb"),
#    }
}

class puppet::monitor::example43 inherits puppet::monitor {
}

