class munin::plugins::dom0 inherits munin::plugins::physical {
    munin::plugin::deploy { "xen": config => "user root"}
    munin::plugin::deploy { "xen-cpu": config => "user root"}
    munin::plugin::deploy { "xen_memory": config => "user root"}
    munin::plugin::deploy { "xen_mem": config => "user root"}
    munin::plugin::deploy { "xen_vm": config => "user root"}
    munin::plugin::deploy { "xen_vbd": config => "user root"}
    munin::plugin::deploy { "xen_traffic_all": config => "user root"}
}
