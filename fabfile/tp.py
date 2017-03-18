from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def clone_data(module,source='UNDEFINED'):
  """[local] Add a new app name data directory under modules/tinydata, based on the specified source"""
  if source == "UNDEFINED":
    sourceoptions = ""
  else:
    sourceoptions = " -n " + str(source)
  local( "cd " + main_dir + "/modules/tinydata/ ; bin/moduledata_clone.sh -m " + str(module) + str(sourceoptions ) )

@task
def install(app=''):
  """[local] Install locally any tinydata knows app via tp"""
  local( main_dir + "/bin/tp_install.sh " + str(app) )


@task
def remote_test(options=''):
  """[remote] WIP Run tp tests on remote node"""
  run( "/etc/tp/test/* "  )


