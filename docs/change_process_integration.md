- [Puppet change process. With integration branch](#puppet-change-process-with-integration-branch)
- [Change process](#change-process)
    - [1 - USER: Open a ticket [trivial skip] [express skip]](#1---user-open-a-ticket-trivial-skip-express-skip)
    - [2 - PUPPET TEAM: Prioritize and assign tickets [trivial skip] [express skip]](#2---puppet-team-prioritize-and-assign-tickets-trivial-skip-express-skip)
    - [3 - PUPPET DEVELOPER: Development](#3---puppet-developer-development)
    - [4 - PUPPET DEVELOPER: Testing [trivial skip] [express skip]](#4---puppet-developer-testing-trivial-skip-express-skip)
        - [Simplified Alternative using integration branch](#simplified-alternative-using-integration-branch)
        - [Simplified Alternative using web interface](#simplified-alternative-using-web-interface)
    - [5 - PUPPET DEVELOPER: Merge Request [trivial skip] [express skip]](#5---puppet-developer-merge-request-trivial-skip-express-skip)
    - [6 - PUPPET DEVELOPER: Production rollout](#6---puppet-developer-production-rollout)
- [Simplified Change process using web interface](#simplified-change-process-using-web-interface)

### Puppet change process. With integration branch

In this document we will review a possible process to follow to manage `Puppet` changes based on an `integration branch`, used as `origin` and controlled promotion to `production branch`.

It's based on `Gitlab CI pipelines` defined in the [gitlab/.gitlab-ci.yml-integration](../gitlab/.gitlab-ci.yml-integration) file.

It can be used as main ```.gitlab-ci.yml``` file on a setup where code stays in a (local) `GitLab` instance and the `Puppet server` is based on `Puppet Enterprise`, with automatic code deployment whenever a change is pushed to `GitLab server`.

This can be adapted to custom tools and needs, with variations in internal organisation and processes.

By `Puppet changes` we mean, any modification, addition or deletion in this `control-repo` which may involve changes on real server, once the change has been deployed to the `Puppet Server`.

### Change process

Each non trivial change on this `Git repository` should follow a workflow as the one outlined here. We will mark with the label **[trivial skip]** the steps than can be skipped for trivial changes.

An express path might be considered for very urgent changes, such as fixes for current outages or for very urgent user requests. We will mark with the label **[express skip]** the steps which might be skipped in such cases.

#### 1 - USER: Open a ticket [trivial skip] [express skip]

Normally every change should be tracked by a relevant ticket on the `Ticketing System` of choice. This should be done by the user requesting the change (only as exception operators should open tickets by themselves for requests arrived by email, voice or other means). Ticket title should be informative and not generic and in the description should be added details such as:

  - What has to be changed (content of a file, user password, package installation ...) and how
  - Where the change should occur (a specific server, all servers or a `role/datacenter/environment...`)
  - If the change should be applied at specific times or conditions (changing a file may involve a ```service restart```, is this supposed to be done only in maintenance windows?)
  - If the request is for fixing a malfunctioning system, any detail on the kind of failure and eventually suggested solutions


#### 2 - PUPPET TEAM: Prioritize and assign tickets [trivial skip] [express skip]

Ideally is not the user who decides who has to fix his problem, but the team of `Puppet admins`. Prioritization and assignment should be handled directly on the `Ticketing System`. Decisions on them can be done by the `team leader`, by the whole team in regular meetings (e.g. stand-ups) or autonomously by each member (a `Puppet operator` self assigns an open ticket and starts to work on it).

Using `Kanban boards` to map tickets to cards can help the process.

#### 3 - PUPPET DEVELOPER: Development

The assigned team member starts to work on the ticket, he should have a ready to use workstation where he can develop and test his `Puppet code`. Any change should be pushed to ```integration branch``` **only**. The `CI` process [semi]automatically takes care to promote the change to ```production branch```.

A good approach is to create a ```feature branch```, with the relevant `name` and relevant `ticket number`. Once the changes on the ```feature branch``` have been merged into ```integration```, and then up to ```production``` branches, and the relevant `ticket` closed, the ```feature branch``` should be removed.

Remember to always create a ```feature branch``` based on current status of ```integration branch```. First we have to checkout into ```integration branch```:

    git checkout integration

Then it's always recommended to `sync` the `local branch` to `origin` so that we are sure we are working on updated code:

    git pull origin integration

Then we can create a ```new branch``` with the name referring to the relevant ticket:

    git checkout -b feature_22

Finally we can start to edit our files and make our developments:

    vi ....


#### 4 - PUPPET DEVELOPER: Testing [trivial skip] [express skip]

We have at disposal several ways to test our `Puppet code`:

  - We can test our changes on our local development workstation, using the available [vagrant](vagrant.md) environments (this can be done before any commit)

  - We can test our changes on real servers, using our ```feature branch```

For this second approach, and in any case when we want to publish our changes, we have to commit and push our ```feature branch```. First add files to the stage, ready to be committed:

    git add <changed/file[s]>

Then, make a commit, in its description of our commit, always add the reference to the relevant ticket number, using the syntax: `#<number>`

    git commit -m "Description #22"   

Finally push our local changes to the central `Git server`:

    git push origin feature_22

Once we push to a ```feature branch``` on `GitLab` the same ```feature branch``` is automatically deployed as `Puppet environment` on the `Puppet Server`, so, in our example, we'll have a new `Puppet environment` called ```feature_22```.

In order to be able to use a custom environment on a node, we first need to be sure that this node belongs, on `Puppet Enterprise console`, to the node group `Agent-Specified environment`, if we use `Puppet Enterprise`.

We can then test our environment, either directly from the managed node, as `root`. The first attempt should be done in `noop mode` to see what changes would be applied (**NOTE:** If servers run in `noop mode` by default, we don't need to specify it):

    puppet agent -t --environment=feature_22 --noop

Then we can run `Puppet` in `apply mode`, using our environment. The ```--no-noop``` option is needed only if by default our node runs in `noop mode`:

    puppet agent -t --environment=feature_22 --no-noop


Whenever we push changes to a ```feature branch```, a set of basic syntax tests may be automatically triggered by our `CI` tool. We can check their status looking at the relevant `CI pipeline`.


##### Simplified Alternative using integration branch

For [trivial] or [express] cases we might decide to skip the creation of a ```feature branch``` and make our changes directly on the ```integration branch```.

In such a case the `git workflow` would be slightly simplified:

    git checkout integration
    git pull origin integration
    vi .... [Edit files and eventually test them locally via Vagrant]
    git add <changed/file[s]>
    git commit -m "Description #22"
    git push origin integration


##### Simplified Alternative using web interface

An even simpler and more direct approach is to use directly the web interface of `GitLab` (or any other online or local system used for ```git``` repos management) to edit the needed files.

  - Click on the file that has to be changed
  - Click on **Edit**
  - Make the desired changes from the web interface
  - Click on **Save** to commit your changes (a commit title and description can be added)

Such an approach should be followed only in these cases:

  - We have just to edit a single file
  - We are not proficient with ```git``` and its usage from the command line
  - Change is trivial or we are in an extreme hurry

**NOTE:**  such an approach prevents us from testing our code on `Vagrant`, but still allows us to test it on real servers, using the `environment` matching the `branch` we have worked on.


#### 5 - PUPPET DEVELOPER: Merge Request [trivial skip] [express skip]

Once we're satisfied with our change, we can submit, from `GitLab` (or similar) web interface, a `Merge Request` from our ```feature branch``` to the ```integration branch```.

We can accept the `Merge Request` immediately, and this automatically starts a `new pipeline` and deploys our changes to the `Puppet` ```integration environment```.

If all checks in `integration` pass (note some of them may be optional and could be configured to pass even in case of warnings/failures) then an automatic `Merge Request` is done from ```integration``` to ```testing branch```.

The `Merge Request` is automatically accepted and the change is promoted to `testing`, where another `CI pipeline` starts.

In this `pipeline` real `Puppet runs` are done on real servers (so called [canary nodes](https://www.quora.com/What-is-Canary-testing), if something has to go wrong, they are supposed to be the first ones to "notice").

At the end of this `pipeline`, if no blocking errors are found, an automatic `Merge Request` is done from ```testing``` to ```production branch```. In this case we have manually accept it, either clicking on the relevant button in the `pipeline`, or from the `Merge Requests` page, where we can eventually add comments or notes.

**NOTE:** If we have added the reference to a ticket (ie: #22) in our commit title, the same ticket is automatically closed when the commit is merged to production. In case we don't want this (because our commit actually didn't completely accomplished whatever was requested in the ticket), we'll have to manually re-open the ticket.


#### 6 - PUPPET DEVELOPER: Production rollout

Once our change is pushed to the ```production branch```, it's automatically deployed as ```production environment``` on our `Puppet Server` and from here, by default, in 30 minutes, is rolled all over our infrastructure.


### Simplified Change process using web interface

A simpler and more direct approach is to use directly the web interface of `GitLab` (or any other online or local system used for git repos management) to edit the needed files.

  - Open the relevant `Issue page` (or create the issue)
  - Click on **Create Merge request**

The `Merge Request`, even if with still no change has been made, triggers a `CI pipeline` and shows a page where is possible to change `milestones`, `assignee` and, especially, click on the ```newly created branch```.

From here we can:

  - Click on the branch link after **Request to merge** to show its commits history
  - Click on **Files**
  - Browse to the file we have to change
  - Click on **Edit**
  - Make the desired changes from the web interface
  - Click on **Commit changes** to commit your changes (a commit title and description can be added)

We can do the same online editing operation for all the files we have to change.

It's important to be sure to always ensure we are working on our newly created ```feature branch```, its name is always visible while browsing files:

Once we have finished to edit our files (note that each time we change one file online, a new commit is created and a `CI pipeline` triggered), we can go back to the `Merge Request` page, here we can:

  - Review the associated pipeline (**NOTE:** that the `Verify Deploy` step will always fail, see below for reasons, but the [Lint](https://en.wikipedia.org/wiki/Lint_(software)) and `Syntax checks` must be green)
  - Review all our changes
  - List our commits
  - Click on **Edit** to remove the "WIP: " prefix from the `Merge Request` title, this allows us to actually accept the `Merge request` (to the ```integration branch```)
  - Click on **Save changes**
  - Click on **Merge** (ensure that the "Remove source branch" box is checked) to accept the `Merge Request` to ```integration branch```.
  - The relevant issue is automatically closed.

From now on the next steps are similar to [Step 5](#5---puppet-developer-merge-request-trivial-skip-express-skip) (second part) and [Step 6](#6---puppet-developer-production-rollout) of the previously described Change process.

This web based approach should be followed only in these cases:

  - We have just to edit a few files and we don't have to test locally (with `Vagrant`) our changes
  - We are not proficient with ```git``` and its usage from the command line
  - Change is trivial or we are in an extreme hurry

**NOTE:** that such an approach prevents us from testing our code on `Vagrant`, but still allows us to test it on real servers, using the environment matching the branch we have worked on.  Note, however, that the branches automatically created with this procedure `have spaces in their name` and they are `not automatically deployed` to the `Puppet Server` as environments. In order to deploy a ```feature branch``` on the `Puppet Server` (so that we can test it on selected nodes), we need to give it a `name without spaces`.
