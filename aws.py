from fabric.api import *

@task
def presetup():
  """Install locally the aws cli environment"""
  local( "bin/aws_presetup.sh" )

@task
def apply(role='aws'):
  """Run puppet apply locally using the specified role (default: aws)"""
  local( "export FACTER_role=" + str(role) + " && bin/papply_local.sh" )

@task
def status(region=''):
  """Show AWS resources on one or all regions"""
  local( "bin/aws_show_resources.sh " + str(region) )

