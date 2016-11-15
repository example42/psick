from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def add_app(module,source='UNDEFINED'):
  """[local] WIP Create a standard new structure for a data directory under modules/tinydata module"""
  if source == "UNDEFINED":
    sourceoptions = ""
  else:
    sourceoptions = " -n " + str(source)
  local( main_dir + "/modules/tinydata/bin/moduledata_clone.sh -m " + str(module) + str(sourceoptions ) )


@task
def remote_test(options=''):
  """[remote] WIP Run tp tests on remote node"""
  run( "/etc/tp/test/* "  )


