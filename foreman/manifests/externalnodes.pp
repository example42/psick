class foreman::externalnodes {
    include foreman::params

  file{"/etc/puppet/node.rb":
    source => "${foreman::params::foreman_source}/external_node.rb",
    mode   => 555,
    owner  => "puppet", group => "puppet",
  }

}
