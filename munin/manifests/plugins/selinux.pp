class munin::plugins::selinux inherits munin::plugins::base {
    munin::plugin::deploy { "selinuxenforced": }
    munin::plugin::deploy { "selinux_avcstats": }
}
