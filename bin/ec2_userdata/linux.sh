#!/bin/bash -xe
# Sample ec2_userdata script for installation of Puppet Enterprise agents
# on Linux instances on AWS
# Change URL of the Puppet Server (here: puppet.aws.psick.io)
# Default client certname is $instanceID.aws.psick.io, adapt as needed.

role=${1:-norole}
environment=${2:-production}
preshared_key='t0b3definED!'
instance_id=$(curl -s --insecure http://169.254.169.254/latest/meta-data/instance-id)
mkdir -p /etc/puppetlabs/puppet
echo --- > /etc/puppetlabs/puppet/csr_attributes.yaml
echo 'extension_requests:' >> /etc/puppetlabs/puppet/csr_attributes.yaml
echo "  pp_role: ${role}" >> /etc/puppetlabs/puppet/csr_attributes.yaml
echo "  pp_environment: ${environment}" >> /etc/puppetlabs/puppet/csr_attributes.yaml
echo "  pp_preshared_key: ${preshared_key}" >> /etc/puppetlabs/puppet/csr_attributes.yaml
chmod 640 /etc/puppetlabs/puppet/csr_attributes.yaml
curl -k https://puppet.aws.psick.io:8140/packages/current/install.bash | bash -s agent:certname=$instance_id.aws.psick.io

