class apt::repo::virtualbox {

    apt::repository { "virtualbox":
        url        => "http://download.virtualbox.org/virtualbox/debian",
        distro     => "${lsbdistcodename}",
        repository => "contrib",
        key_url    => "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc",
    }

}

