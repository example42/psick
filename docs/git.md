# example42 control-repo: git tasks

Here follows a list of useful Fabric tasks for git.

Install useful git hooks for Puppet files checking. By default downloaded from (https://github.com/drwahl/puppet-git-hooks)[https://github.com/drwahl/puppet-git-hooks]:

    fab git.install_hooks

It's possible to specify the git repo url to use (hooks are looked for in the ```commit_hooks``` directory):

    fab git.install_hooks:url=https://github.com/my/puppet-git-hooks

Note that existing git hooks are not overwritten by this task.

To quickly check the git status of the main control-repo and of the other eventual modules, run:

    fab git.status


