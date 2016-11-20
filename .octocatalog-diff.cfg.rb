settings[:hiera_config] = 'hiera.yaml'

settings[:enc] = 'bin/enc_cat.sh'

# settings[:puppet_binary] = '/opt/puppetlabs/puppet/bin/puppet'

settings[:puppetdb_url] = 'https://puppetdb:8081'
#settings[:puppetdb_ssl_ca] = '/etc/puppetlabs/puppetdb/ssl/ca.pem'
#settings[:puppetdb_ssl_client_cert] = File.read('/etc/puppetlabs/puppet/ssl/..')
