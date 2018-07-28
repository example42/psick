- [Hiera Eyaml](#hiera-eyaml)
    - [Creating encrypted Hiera values](#creating-encrypted-hiera-values)

## Hiera Eyaml

[Hiera-eyaml](https://github.com/voxpupuli/hiera-eyaml) is a `Hiera` backend which can be used to encrypt single keys in `Hiera` `.yaml` files.

It has become de facto standard to manage `passwords`, `secrets` and `confidential data` in `Puppet`.

It's now included by default in `Hiera 5`, (shipped with `Puppet` version > 4.9), in earlier versions in can be installed as a gem:

    gem install hiera-eyaml

On the `Puppet Server` we need to do that also in `Puppet` environment:

    puppetserver gem install hiera-eyaml

To configure it we need to specify the backend in ```hiera.yaml``` and the location of the keys used to encrypt the data. Syntax for `Hiera` < 5 is something like:

    ---
    :backends:
      - eyaml

    :eyaml:
      :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"
      :pkcs7_private_key: /etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
      :pkcs7_public_key:  /etc/puppetlabs/puppet/keys/public_key.pkcs7.pem
      :extension: 'yaml'

Syntax for `Hiera` version 5 is like:

    ---
    version: 5
    defaults:
      datadir: hieradata
      data_hash: yaml_data
    hierarchy:
      - name: "Eyaml hierarchy"
        lookup_key: eyaml_lookup_key # eyaml backend
        paths:
          - "nodes/%{trusted.certname}.yaml"
          - "common.yaml"
        options:
            pkcs7_private_key: "/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem"
            pkcs7_public_key: "/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem"

The gem provides the ```eyaml``` command, which can be used to perform any `Hiera` ```eyaml``` related operation.

Before starting to encrypt data a pair of `public and private keys` has to be created:

    eyaml createkeys

This creates in the `keys` directory (relative to the current working directory) the ```private_key.pkcs7.pem``` and ```public_key.pkcs7.pem``` files. The first one should never be shared and must be managed in a safe way, for this reason the keys (at least the private one) should not be added to the `control-repo` `Git repository` and must be readable by the user running the `Puppet Server` (```/etc/puppetlabs/puppet/keys``` is a sane path, but could be anything).

Both of these files must be placed wherever `Hiera files` are evaluated: that means basically all the `Puppet Servers` but also, eventually, on `developers workstations`, if `Puppet code` is tested locally via `Vagrant`.

To avoid the need to share `private keys` to all developers, we recommend, anyway, to avoid to encrypt data in `Hiera files` used by machines running in `Vagrant`.

So for example, if we have a `Hiera layer` which represent a machine environment or tier, and for `Vagrant` nodes we use the `devel tier`, we can override eventually encrypted data in a general ```common.yaml``` with clear text entries in a `Vagrant` specific layer (like ```"tier/devel.yaml"```). Just know that we need the `private key` when encrypted data is looked for, if we manage to have no encrypted data for servers running under `Vagrant`, `Hiera` ```eyaml``` works flawlessly even if the public and private keys are not stored locally.


### Creating encrypted Hiera values

We can generate the encrypted value of any `Hiera` key with the following command:

    eyaml encrypt -l 'mysql::root_password' -s 'V3ryS3cr3T!'

This will print on stdout both the plain and encrypted string and a block of configuration that we can directly copy in our `.yaml` files as follows:

    ---
    mysql::root_password: > ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMII  [...]

**NOTE:** the value is in the format ```ENC[PKCS7,Encrypted_Value]```.

Since we have the password stored in plain text in our ```bash history```, we should clean it using the following command:

    history | grep encrypt
    572  eyaml encrypt -l 'mysql::root_password' -s 'V3ryS3cr3T!'
    history -d 572

Alternatively we can directly edit `Hiera` `.yaml` files with the following command:

    eyaml edit hieradata/common.eyaml

Our editor of preference will open the file and decrypt the encrypted values eventually present so that we can edit our secrets in clear text and save the file again (of course, we can do this only on a machine where we have access to the private key).

To add a new encrypted key to a file we can open it with ```eyaml edit filename.eyaml``` and add a key with a syntax like this:

    ---
    mysql::root_password: DEC::PKCS7[my_password]!

The string ```my_password``` (our password in clear text) will be encrypted once the file is saved.

To show the decrypted content of an `.eyaml` file, we can use the following command:

    eyaml decrypt -f hieradata/common.eyaml

Since `hiera-eyaml` manages both `clear text` and `encrypted` values, we can use it as our only backend if we want to work only on `.yaml` files, so it's pointless to use both `yaml` and `eyaml` backends.
