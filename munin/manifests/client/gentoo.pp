class munin::client::gentoo inherits munin::client::package {
  Package['munin-node'] {
    name => 'munin',
    category => 'net-analyzer',
  }
    
    include munin::plugins::gentoo
}
