## Puppet external facts

There are 3 ways to add our **own facts** in `Puppet`:

- Writing our **custom facts**, in `Ruby language` and adding them to the ```lib/facter``` directory of a module. [Details here](https://puppet.com/docs/facter/latest/custom_facts.html)

- Adding **trusted facts** in ```csr_attributes.yaml``` as described in [this document](trusted_facts.md)

- Adding **external facts**, written in `plain text` or as `executables` in **any language**. Details below:

External facts are placed in these directories:

    On Linux/*nix:
    /opt/puppetlabs/facter/facts.d/
    /etc/puppetlabs/facter/facts.d/
    /etc/facter/facts.d/

    On Windows:
    C:\ProgramData\PuppetLabs\facter\facts.d\

They are simple files that can have different formats:

- Simple `*.txt` files. Facts names and their values are in [.ini file format](https://en.wikipedia.org/wiki/INI_file):

        role=webserver
        env=prod
        zone=berlin

- `Yaml` files, with `.yaml` extension:

        ---
        role: webserver
        env: prod
        zone: berlin

- `Json` files, with `.json` extension:

        {
          "role": "webserver",
          "env": "prod",
          "zone": "berlin",
        }

- Any `command` in any language. On Linux/*nix the file, with whatever extension, just has to be `executable`. On `Windows` it must have `.com`, `.exe`, `.bat`, `.cmd`, `.ps1` extension. The `command` should just output the `fact` **name(s)** and its/their **values**:

        #!/bin/bash
        echo "role=webserver"
        echo "env=prod"
        echo "zone=berlin"

The files we create on client in the ```facts.d``` directory can provide one or more facts values, and they can have any name. Typically, for data files that provide just one fact, the file name is the name of the fact:

    cat /etc/puppetlabs/facter/facts.d/role.txt
    role=webserver

`External facts` can be deployed during provisioning of the server or can be placed in the ```facts.d``` directory of a module (they are ```pluginsynced``` automatically to the client at the beginning of each `Puppet run`).

`External facts` are a very easy way to set custom facts on nodes, just consider the following points:

- They can be potentially changed on the client just by editing the relevant fact. We may prefer to use [trusted facts](trusted_facts.md) when we want their values to be immutable.

- If we use the ```pluginsync``` functionality to distribute them **note** that they are copied as is, from `Puppet Server` to clients, so we don't have a way to distribute different facts to different clients. For this reason we'll probably find ourselves adding facts to the clients that just contain data (`.txt`, `.yaml`, `.json`) in some alternative way (typically during the node's provisioning) and use [pluginsync](https://puppet.com/docs/puppet/5.3/plugins_in_modules.html#technical-details-of-pluginsync) only for the ones that **compute the result** in some way (as executables ones do).
