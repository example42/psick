# Custom project postfix classes

class postfix::example42 inherits postfix {
#    File["main.cf"] {
#        content => template("example42/postfix/main.cf"),
#    }
}

class postfix::example42::client inherits postfix::client {
}

class postfix::example42::server inherits postfix::server {
#    File["postfix.conf"] {
#        content => template("example42/postfix/server/postfix.conf.erb"),
#    }
}

class postfix::example42::monitor inherits postfix::monitor {
}

