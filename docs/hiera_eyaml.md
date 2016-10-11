# Hiera Eyaml

Hiera-eyaml is an additional Hiera backend which can be used to encrypt single keys in Hiera yaml files.

We can install it using the relevant gem:

    gem install hiera-eyaml

On the Puppet server we need to do that also in Puppet environment:

    /opt/puppetlabs/server/apps/puppetserver/cli/apps/gem install hiera-eyaml

To configure it we need to specify the backend in ```hiera.yaml``` and some the location of the keys used to encrypt the data:

    ---
    :backends:
      - eyaml

    :eyaml:
      :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"
      :pkcs7_private_key: /etc/puppetlabs/code/keys/private_key.pkcs7.pem
      :pkcs7_public_key:  /etc/puppetlabs/code/keys/public_key.pkcs7.pem
      :extension: 'yaml'

Before starting to encrypt data a pair of public and private keys has to be created:

    eyaml createkeys

This creates in the ```keys``` directory (relative to the current working directory) the ```private_key.pkcs7.pem``` and ```public_key.pkcs7.pem``` files. The first one should never be shared and must be managed in a safe way, for this reason the keys (at least the private one) should not be added to the control-repo git repository.

Both of these file must be placed wherever Hiera files are evaluated: that means basically all the Puppet Servers. Since we use the same repository for different datacenters and environments, the Hiera eyaml keys should be manually copied, under the directory ```/etc/puppetlabs/code/keys```, on each new Puppet Server, both the Master of Masters and the Compile Masters.

They would be needed also in Vagrant environments, but to avoid the profileration of places where keys should be shared, it's better to avoid to encrypt data in Hiera files used by machines running in Vagrant, so for examples, in the ```"datacenter/%{::datacenter}"``` layer.

## Creating encrypted keys

We can generate the encrypted value of any Hiera key with the following command:

    eyaml encrypt -l 'mysql::root_password' -s 'V3ryS3cr3T!'

This will print on stdout both the plain encrypted string and a block of configuration that we can directly copy in our yaml files as follows:

    ---
    mysql::root_password: > ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMII  [...]

Note that the value is in the format ENC[PKCS7,Encrypted_Value].

Since we have the password stored in plain text in our bash history, we should clean it using the following command:

    history | grep encrypt
    572  eyaml encrypt -l 'mysql::root_password' -s 'V3ryS3cr3T!'
    history -d 572

Alternatively we can directly edit Hiera yaml files  with the following command:

    eyaml edit hieradata/common.eyaml

Our editor of preference will open the file and decrypt the encrypted values eventually present so that we can edit our secrets in clear text and save the file again (of course, we can do this only on a machine where we have access to the private key).

To add a new encrypted key to a file we can open it with ```eyaml edit``` and add a key with a syntax like this:

    ---
    mysql::root_password: DEC::PKCS7[my_password]!

The string ```my_password``` (our password in clear text) will be encrypted once the file is saved.

To show the decrypted content of an eyaml file, we can use the following command:

    eyaml decrypt -f hieradata/common.eyaml

Since hiera-eyaml manages both clear text and encrypted values, we can use it as our only backend if we want to work only on yaml files, the configuration entry ```:extension: 'yaml'``` we have added to hiera.yaml instructs Hiera Eyaml to use files with ```.yaml``` extension, instead of the default ```.eyaml``` one.

