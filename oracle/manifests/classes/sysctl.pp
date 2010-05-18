class oracle::sysctl {

# Settings for 11g
    sysctl::conf { "kernel.sem": value => "250 32000 100 128" }
    sysctl::conf { "kernel.shmall": value => "2097152" }
    sysctl::conf { "kernel.shmmax": value => "536870912" }
    sysctl::conf { "kernel.shmmni": value => "4096" }
    sysctl::conf { "fs.file-max": value => "6815744" }
    sysctl::conf { "fs.aio-max-nr": value => "1048576" }
    sysctl::conf { "net.ipv4.ip_local_port_range": value => "9000 65500" }
    sysctl::conf { "net.core.rmem_default": value => "262144" }
    sysctl::conf { "net.core.rmem_max": value => "4194304" }
    sysctl::conf { "net.core.wmem_default": value => "262144" }
    sysctl::conf { "net.core.wmem_max": value => "1048576" }
}
