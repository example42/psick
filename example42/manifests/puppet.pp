# Custom project puppet classes

class puppet::example42 {
}

class puppet::example42::client inherits puppet::client {
#    File["puppet.conf"] {
#        content => template("example42/puppet/client/puppet.conf.erb"),
#    }
}

class puppet::example42::server inherits puppet::server {
#    File["puppet.conf"] {
#        content => template("example42/puppet/server/puppet.conf.erb"),
#    }
#    File["namespaceauth.conf"] {
#        content => template("example42/puppet/server/namespaceauth.conf.erb"),
#    }
}

class puppet::example42::monitor inherits puppet::monitor {
}

