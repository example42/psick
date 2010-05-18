class munin::plugins::gentoo inherits munin::plugins::base {
    munin::plugin::deploy { "gentoo_lastupdated": config => "user portage\nenv.logfile /var/log/emerge.log\nenv.tail    /usr/bin/tail\nenv.grep    /bin/grep"}
}
