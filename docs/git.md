- [Git](#git)
    - [Git essential reference](#git-essential-reference)
    - [Git minimal guide](#git-minimal-guide)
    - [Git workflows](#git-workflows)
    - [Git tools provided in the control-repo](#git-tools-provided-in-the-control-repo)

## Git

This `control-repo` is stored in a [Git](https://git-scm.com) version control system.

Whoever has to work on it should have basic `Git` knowledge.

Here we are going to review `Git essentials` and outline possible `workflows` for `Puppet code` `development`, `testing` and `deployment` process.



### Git essential reference

Here is a very brief overview of `Git essentials`. There are many online resources where to learn more about it, here is a brief list:

  - [Git - The simple guide](http://rogerdudler.github.io/git-guide/) - A very basic introduction to `Git`. Used as starting point for this topic

  - [Pro Git](https://book.git-scm.com/book/en/v2) - A free and rather complete book about `Git`

  - [A visual Git Reference](http://marklodato.github.io/visual-git-guide/index-en.html) - `Git` main concepts visualised and explained

  - [GitHub Help](https://help.github.com) - Useful info about `Git` and `GitHub`

  - [Try Git](https://try.github.io) - A site where is possible to practice with `Git`

  - [Git Reference](http://gitref.org) - An online reference


### Git minimal guide

Once [installed](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) `Git` provides a `CLI command` which has several actions. Let's see the most used ones.

Create a new repository in the current directory:

    git init

Checkout a repository: create a local copy from a remote server.

To clone via HTTPS (username and passwords are needed for private repos):

    git clone https://github.com/example42/control-repo

To clone via SSH:

    git clone git@github.com:example42/control-repo.git

Any `Git repository` consists of three "trees":

  - The **Working Directory** holds the actual files we are working on
  - The **Index** also known as `staging area` containing files ready to be committed
  - The **HEAD** which points to the last commit on the `Git repository`

Once we start to `modify`, `add` or `delete` files in our `Git repository`, we have to add them to the `Index` before being able to commit them.

To add a specific file to the `Index`:

    git add <filename>

To add all the changed or new files from the current `Working directory` to the `Index`:

    git add .

To add all the changed, new and deleted files from the current `Working directory` to the `Index`:

    git add --all .

To visualize the status of our files (the ones added to the `Index` and ready to be committed, or the ones created or changed, which are only in the `Working Directory` and not yet on the `Index`, write:

    git status

When we are confident that the files added to the `Index` are complete, we can commit our changes.

To create a commit with the changes in `Index` and the given title:

    git commit -m "Commit message"

To create a commit and open our editor to add a title (on first line of the text we edit) and eventually a description of the commit (on the following lines):

    git commit

Now the files are committed to the ```HEAD``` or our local working copy, but not in our remote repository yet.

To send those changes to our remote repository, we can run:

    git push origin <branch>

**NOTE:** Usually the main branch of a `Git repository` is called **master**, but in `Puppet` `control-repos` this is instead called,  **production** to make it match `Puppet's` `default environment`.

Worth noting is that we might not be able to push directly to the ```production branch```: it's relatively common to work on a ```development branch``` and then, after a proper `CI pipeline` where relevant tests are done, promote the change to the ```production branch```.

We will review some sample `development workflows`.

Branches can be considered different versions of the repository, changes made in a branch can be merge into another. They are typically used to develop features isolated from each other which, once completed and tested, are merged back into the `master branch` (`production`, in case of a `Puppet` `control-repo`).

To create a new branch named "development" and switch to it:

    git checkout -b development

To switch back to production branch:

    git checkout production

To merge another branch into our `active branch` (e.g. to realign our ```development branch``` to the content of the ```production branch```), first we move into our ```development branch```:

    git checkout development

Then we merge eventual additional contents of ```production branch``` into the ```development branch```:

    git merge production

If the same files have been modified in both the branches, a conflict may be present and automatic (`fast-forward`) merging could not be possible. In these cases, we are responsible to merge those conflicts manually by editing the files shown by ```git```. The involved commands could be as follows.

We move into our development branch:

    git checkout development

We merge production into development and we see conflict errors:

    git merge production

To show the conflicting files:

    git status

We need to edit the file, where we will see in `patch format` (the same we see when using the ```diff command```) the different changes on the file. We need to remove the diff placeholders (Lines like === or >>>) and edit the code in the expected way:

    vi <file>

To add the file to the `Index`:

    git add <file>

To review and commit our conflict resolution:

    git commit

In case we did something wrong that we want to revert, we can use the following commands, according to the circumstance (read [this tutorial](https://www.atlassian.com/git/tutorials/undoing-changes) for more details).

To replaces the changes on the given file in our `Working Tree` with the last content in ```HEAD``` (Changes already added to the `Index`, as well as new files, will be kept):

    git checkout -- <filename>

To drop all our local changes and revert back to the latest local commits:

    git reset --hard

To undo the changes done in the given commits:

    git revert <git_commit_id>


Other useful commands often used when working with `Git`:

    git log                  # Show git commits history
    git log --name-status    # Show commits history and the changed files in each commit
    git log --pretty=oneline # Shot commit history using one line per commit

    git pull # Update the local repository with the newest commit from remote origin

    git diff                        # Show the differences between Working Directory and Index
    git diff HEAD                   # Show the differences between Working Directory and HEAD
    git diff production development # Show the differences between production and development branches

`Git` can be configured using the ```git config``` command or by editing the ```~/.gitconfig``` file.

Some configurations examples:

    git config color.ui true             # To enable colorful output
    git config format.pretty oneline     # Show log on just one line per commit
    git config user.name 'My Name'       # To configure the username to show on our commits
    git config user.email 'my@email.com' # To configure the email to show on our commits


### Git workflows

`Git` is a very versatile tool which allows distributed development also for very complex projects.

We can follow [different workflows](https://www.atlassian.com/git/tutorials/comparing-workflows) for our code, which defines the steps and procedures to follow to promote code changes from `local development` to `public development`.

These are some popular workflows, with a brief comment, we should follow one that better fits our needs (and skills):

-  [GitFlow](http://nvie.com/posts/a-successful-git-branching-model/) A very popular, but somehow complex, workflow, involving `different branches` for `features`, `releases` and `hotfixes`.

- [GitHub Flow](https://guides.github.com/introduction/flow/) - A much simpler workflow based on master to which `Pull Requests` are made from ```feature branches```

- [GitLab Flow](https://docs.gitlab.com/ee/workflow/gitlab_flow.html) - A workflow similar to `GitHub flow` with some variations.


### Git tools provided in the control-repo

This `control-repo` provides some commands related to `Git`.

To install useful `git hooks` for `Puppet files` checking (by default downloaded from [https://github.com/drwahl/puppet-git-hooks](https://github.com/drwahl/puppet-git-hooks)) use one of these, alternative, commands:

    fab git.install_hooks    # If using Fabric
    # or
    bin/git_install_hooks.sh # Direct bash command

It's possible to specify the `git repo` URL to use (hooks are looked in the ```commit_hooks``` directory, so that directory should exist in our repo):

    fab git.install_hooks:url=https://github.com/my/puppet-git-hooks
    # or
    bin/git_install_hooks https://github.com/my/puppet-git-hooks

We can customize the kind of checks to do by editing the file:

```${control_repo_dir}/.git/hooks/commit_hooks/config.cfg```

in particular we might prefer to set ```CHECK_PUPPET_LINT='permissive'``` to avoid commit block on ```Puppet lint``` errors which are syntactically correct but may have code style problems (so mostly aesthetic).

**NOTE:** that existing `git hooks` are **not** overwritten by this task.

When working on our `control-repo`, besides it's own `Git repository`, we may have, in the ```modules/``` directory external modules with their own `Git repositories`. To quickly check the ```git status``` of the main `control-repo` and of the other eventual modules, run:

    fab git.status
