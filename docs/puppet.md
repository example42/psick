# example42 control-repo: Puppet tasks

Run puppet agent in noop mode on all the known hosts:

    fab puppet.agent_noop

Run puppet agent in a specific node:

    fab puppet.agent:host=web01.example.test

Show the current version of deployed Puppet code on all  nodes:

    fab puppet.current_config

Generate a new module based on the format of the ```skeleton``` directory.

    fab puppet.module_generate


