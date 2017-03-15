from fabric.api import *
import os
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

try:
  default_region = os.environ["AWS_REGION"]
except:
  default_region = ''

@task
def setup():
  """[local] Install locally the aws cli environment"""
  local( main_dir + "/bin/aws_setup.sh" )

@task
def apply(role='aws',options=''):
  """[local] Run puppet apply locally using the specified role (default: aws)"""
  local( "export FACTER_role=" + str(role) + " && " + main_dir + "/bin/papply_local.sh " + str(options) )

@task
def status(region=default_region):
  """[local] Show AWS resources on one or all regions"""
  local( main_dir + "/bin/aws_status.sh " + str(region) )

