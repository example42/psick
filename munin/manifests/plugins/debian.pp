class munin::plugins::debian inherits munin::plugins::base {
    munin::plugin { apt_all: ensure => present; }
}

