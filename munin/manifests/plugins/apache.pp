class munin::plugins::apache inherits munin::plugins::base {
    munin::plugin{ "apache_accesses": }
    munin::plugin{ "apache_processes": }
    munin::plugin{ "apache_volume": }
    munin::plugin::deploy { "apache_activity": }
}
