# Custom project class. Use this to adapt the module to your project.
# Use puppet::example42::client and puppet::example42::server to client or server specific customization
# Place here only common customization you want on both roles
class puppet::example42 {

    # gemrc with proxy settings for seamleass gem usage
    file { "gemrc":
        path => "/etc/gemrc",
        content => template("puppet/example42/gemrc.erb"),
    }
}
