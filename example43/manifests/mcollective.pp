# Custom project mcollective classes

class mcollective::example43 {
}

class mcollective::example43::client inherits mcollective::client {
}

class mcollective::example43::server inherits mcollective::server {
#    File["mcollective.conf"] {
#        content => template("example43/mcollective/server/mcollective.conf.erb"),
#    }
#    File["namespaceauth.conf"] {
#        content => template("example43/mcollective/server/namespaceauth.conf.erb"),
#    }
}

class mcollective::monitor::example43 inherits mcollective::monitor {
}

