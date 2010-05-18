class munin::plugins::linux inherits munin::plugins::base {
    munin::plugin {
        [ df_abs, forks, df_inode, irqstats, entropy, open_inodes ]:
            ensure => present;
        acpi:
            ensure => $acpi_available;
    }

    include munin::plugins::interfaces
}
