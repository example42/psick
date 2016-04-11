# Default ram (can be overriden per node)
default_ram = '1024'

# Default number of cpu  (can be overriden per node)
default_cpu = '1'

Vagrant.configure("2") do |config|
  config.cache.auto_detect = true

  # See https://github.com/mitchellh/vagrant/issues/1673
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  {
    :Centos7_PuppetServer => {
      :box              => 'puppetlabs/centos-7.0-64-puppet',
      :provision_puppet => false,
      :provision_shell  => true,
      :breed            => 'puppetlabs',
      :ram              => '4096',
      :cpu              => '2',
      :facts            => {
        :role => 'puppet',
      }
    },
    :Ubuntu1404_PuppetServer => {
      :box              => 'puppetlabs/ubuntu-14.04-64-puppet',
      :provision_puppet => false,
      :provision_shell  => true,
      :breed            => 'puppetlabs-apt',
      :ram              => '4096',
      :cpu              => '2',
      :facts            => {
        :role => 'puppet',
      }
    },
    :Centos7 => {
      :box              => 'puppetlabs/centos-7.0-64-puppet',
      :breed            => 'puppetlabs',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Centos7_P3 => {
      :box              => 'webhippie/centos-7',
      :breed            => 'redhat7',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Centos7_PE => {
      :box              => 'puppetlabs/centos-7.0-64-puppet-enterprise',
      :breed            => 'puppetlabs',
      :provision_puppet => true,
      :provision_shell  => true,
    },
    :Centos6 => {
      :box              => 'puppetlabs/centos-6.6-64-puppet',
      :breed            => 'puppetlabs-centos6',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Ubuntu1404 => {
      :box              => 'puppetlabs/ubuntu-14.04-64-puppet',
      :breed            => 'puppetlabs-apt',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Ubuntu1204 => {
      :box              => 'puppetlabs/ubuntu-12.04-64-puppet',
      :breed            => 'puppetlabs-ubuntu1204',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Debian8_P3 => {
      :box              => 'oar-team/debian8',
      :breed            => 'debian8',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Debian7 => {
      :box              => 'puppetlabs/debian-7.8-64-puppet',
      :breed            => 'puppetlabs-apt',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Debian6 => {
      :box              => 'puppetlabs/debian-6.0.10-64-puppet',
      :breed            => 'puppetlabs-apt',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :OpenSuse12_3 => {
      :box              => 'opensuse-12.3-64',
      :box_url          => 'http://sourceforge.net/projects/opensusevagrant/files/12.3/opensuse-12.3-64.box/download',
      :breed            => 'opensuse12',
      :provision_puppet => false,
      :provision_shell  => true,
    },
  }.each do |name,cfg|

    config.vm.define name do |local|
      memory = cfg[:ram] ? cfg[:ram] : default_ram ;
      cpu = cfg[:cpu] ? cfg[:cpu] : default_cpu ;
      local.vm.provider "virtualbox" do |v|
        v.customize [ 'modifyvm', :id, '--memory', memory.to_s ]
        v.customize [ 'modifyvm', :id, '--cpus', cpu.to_s ]
      end
      local.vm.synced_folder ".", "/vagrant"
      local.vm.box = cfg[:box]
      local.vm.box_url = cfg[:box_url] if cfg[:box_url]
#      local.vm.boot_mode = :gui
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.downcase.gsub(/_/, '-').concat(".example42.dev")
      local.vm.provision "shell", path: 'bin/vagrant-setup.sh', args: cfg[:breed]

# TODO Fix
      $facter_script = <<EOF
facts_dir=$(puppet config print pluginfactdest)
mkdir -p $facts_dir
echo "role=puppet" > $facts_dir/facts.txt
EOF

      if cfg[:facts]
        local.vm.provision "shell", inline: $facter_script
      end


      if cfg[:provision_shell]
        local.vm.provision "shell", path: 'bin/papply_vagrant.sh'
      end

      if cfg[:provision_puppet]
        local.vm.provision :puppet do |puppet|
          puppet.hiera_config_path = 'hiera.yaml'
          puppet.working_directory = '/vagrant/hieradata'
          puppet.manifests_path = "manifests"
          puppet.module_path = [ 'site' , 'modules' ]
          puppet.manifest_file = "site.pp"
          puppet.options = [
           '--verbose',
           '--report',
           '--show_diff',
           '--pluginsync',
           '--summarize',
#        '--profile',
#        '--evaltrace',
#        '--trace',
#        '--debug',
#         '--parser future',
           '--environmentpath /vagrant',
          ]
        end
      end
    end
  end
end
