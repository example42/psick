# Class profile::dns::dnsclient
# This class uses ghoneycutt/dnsclient
# To configre DNS via Hiera:
# dnsclient::nameservers:
#   - 8.8.8.8
#   - 8.8.4.4
# dnsclient::options:
#   - rotate
#   - 'timeout:1'
# dnsclient::search:
#   - my.domain
# dnsclient::domain:
#   - my.domain
# Note that all nameservers, options, search amd sortlist all require an array
# as argument
class profile::dns::dnsclient {
  include ::dnsclient
}
