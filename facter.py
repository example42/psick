from fabric.api import *

@task
def set_external_facts(role='',env=''):
  """[remote] Set the given external facts in /etc/puppetlabs/facter/facts.d"""
  sudo( '[ -d ' + facts_dir + ' ] || mkdir -p ' + facts_dir )
  sudo( 'echo "role=' + role + '\n" > ' + facts_dir + '/role.txt ' )
  sudo( 'echo "env=' + env + '\n" > ' + facts_dir + '/env.txt ' )

@task
def set_trusted_facts(facts={}):
  """[remote] Set the given trusted facts in /etc/puppetlabs/puppet/csr_attributes.yaml"""
  text << "---"
  text << '  extension_requests:'
  for key,value in facts.iteritems():
      text << '   ' + key + ': ' + value
  sudo( 'echo ' + text + ' > /etc/puppetlabs/puppet/csr_attributes.yaml' )
