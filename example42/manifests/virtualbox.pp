# Custom project virtualbox classes

class virtualbox::example42 inherits virtualbox {
}

class virtualbox::example42::client inherits virtualbox::client {
}

class virtualbox::example42::server inherits virtualbox::server {
#    File["virtualbox.conf"] {
#        content => template("example42/virtualbox/server/virtualbox.conf.erb"),
#    }
}

class virtualbox::example42::monitor inherits virtualbox::monitor {
}


