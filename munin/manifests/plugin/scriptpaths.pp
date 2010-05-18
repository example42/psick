class munin::plugin::scriptpaths {
    case $operatingsystem {
        gentoo: { $script_path =  "/usr/libexec/munin/plugins" }
        debian: { $script_path =  "/usr/share/munin/plugins" }
        centos: { $script_path =  "/usr/share/munin/plugins" }
        openbsd: { $script_path =  "/opt/munin/lib/plugins/" }
        default: { $script_path =  "/usr/share/munin/plugins" }
    }
}
