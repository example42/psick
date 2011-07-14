class apt::repo::puppetlabs {

    apt::repository { "puppetlabs":
        url        => "http://apt.puppetlabs.com/ubuntu",
        distro     => "${lsbdistcodename}",
        repository => "main",
        # key        => "1054B7A24BD6EC30",
        key        => "4BD6EC30",
    }

}

