from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def setup():
  """Install locally the aws cli environment"""
  local( main_dir + "/bin/aws_setup.sh" )

@task
def apply(role='aws'):
  """Run puppet apply locally using the specified role (default: aws)"""
  local( "export FACTER_role=" + str(role) + " && " + main_dir + "/bin/papply_local.sh" )

@task
def status(region=''):
  """Show AWS resources on one or all regions"""
  local( main_dir + "/bin/aws_status.sh " + str(region) )

