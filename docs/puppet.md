# example42 control-repo: Puppet tasks

This control-repo provides several tools that help Puppeteers in their daily work.

### Remote puppet commands via Fabric

Various Fabric tasks are available to executing on remote hosts. You will need access to them, possibly via ssh keys.

Install Puppet 4 on the remote host(s). Use any Fabric method to define hosts to work on.

    fab puppet.install -H host1,host2

Run puppet agent in noop mode on all the known hosts:

    fab puppet.agent_noop

Run puppet agent in a specific node:

    fab puppet.agent:host=web01.example.test

Show the current version of deployed Puppet code on all nodes:

    fab puppet.current_config

Setup on the remote node all the prequisites to run this control-repo in apply mode:

    fab puppet.remote_setup
    # bin/puppet_setup.sh is executed on the remote node
 
Deploy this control-repo from upstream source:

    fab puppet.deploy_controlrepo
    # bin/puppet_deploy_controlrepo.sh is executed on the remote node

Run puppet apply with or without noop on all the known hosts (expected control-repo in production environment):

    fab puppet.apply
    fab puppet.apply_noop

Run in apply mode the local code on a remote node (code is rsynced and then compiled on the remote node.

    fab puppet.sync_and_apply 

### Local Puppet activities 

The following activities can be done locally during development, publishing and deployment of Puppet code.

Check the syntax of all .pp .yaml .epp .erb files in your control-repo:

    fab puppet.check_syntax

Generate a new module based on the format of the ```skeleton``` directory.

    fab puppet.module_generate

Publish the local version of a module in modules/ dir to Forge and GitHub (puppet-blacksmith setup and access to remote git repo required):

     fab puppet.module_publish:tinydata

### Facter tasks (WIP)

Set external facts 

    fab facter.set_external_facts
   
    fab facter.set_trusted_facts
