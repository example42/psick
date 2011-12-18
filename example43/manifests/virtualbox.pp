# Custom project virtualbox classes

class virtualbox::example43 inherits virtualbox {
}

class virtualbox::example43::client inherits virtualbox::client {
}

class virtualbox::example43::server inherits virtualbox::server {
#    File["virtualbox.conf"] {
#        content => template("example43/virtualbox/server/virtualbox.conf.erb"),
#    }
}

class virtualbox::example43::monitor inherits virtualbox::monitor {
}


