class example42::role::ci {
    $role="ci"

    include example42::role::general
    include tomcat

    class {"jenkins":
        install => 'puppi',
        monitor => true,
    }
}
