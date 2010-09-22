class exim::example42 inherits exim {
    File["exim.conf"] {
        content => template("exim/example42/exim.conf.erb-$operatingsystem"),
    } 
}

