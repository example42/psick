from fabric.api import *

@task
def build_role(puppetrole='docker_test', image='ubuntu-14.04'):
  """Build a Docker image of the specified role and OS (data in hieradata/role/$puppetrole.yaml)"""
  local('cd docker ; ./dockerize_role.sh ' + str(puppetrole) + ' ' + str(image) )
@task
def build_role_multios(puppetrole):
  """Build multi OS Docker images of the specified role (data in hieradata/role/$puppetrole.yaml)"""
  local( 'cd docker ; ./dockerize_role_all_os.sh ' + str(puppetrole) )

@task
def test_role(puppetrole='log', image='ubuntu-14.04'):
  """Test a role on the specified OS on Docker"""
  local('docker/test.sh ' + str(puppetrole) + ' ' + str(image) )

@task
def build_multios():
  """Build multi OS Docker images based on the data in hieradata/role/docker_multios_build.yaml"""
  local( 'cd docker ; ./generate_all.sh' )

@task
def purge_images():
  """Remove ALL local docker images (CAUTION)"""
  local('docker rmi $(docker images -q)')

@task
def purge_containers():
  """Remove ALL local docker containers (CAUTION)"""
  local('docker rm $(docker ps -a -q)')

