class sysctl::example42 inherits sysctl {

        File["/etc/sysctl.conf"] {
                        source => [
                                "puppet://$servername/project_example42/sysctl/sysctl.conf-$hostname",
                                "puppet://$servername/project_example42/sysctl/sysctl.conf"
                        ],
        }
}

