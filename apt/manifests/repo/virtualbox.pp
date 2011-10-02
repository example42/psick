class apt::repo::virtualbox {

    require common

    apt::repository { "virtualbox":
        url        => "http://download.virtualbox.org/virtualbox/debian",
        distro     => ${common::osname},
        repository => "contrib",
        key        => "98AB5139",
        key_url    => "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc",
    }

}

