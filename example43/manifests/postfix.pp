# Custom project postfix classes

class postfix::example43 inherits postfix {
#    File["main.cf"] {
#        content => template("example43/postfix/main.cf"),
#    }
}

class postfix::example43::client inherits postfix::client {
}

class postfix::example43::server inherits postfix::server {
#    File["postfix.conf"] {
#        content => template("example43/postfix/server/postfix.conf.erb"),
#    }
}

class postfix::example43::monitor inherits postfix::monitor {
}

