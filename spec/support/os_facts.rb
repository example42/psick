OS_FACTS =
  {
    :aio_agent_version => '4.99.0.202',
    :augeas => {
      :version => '1.8.0'
    },
    :disks => {
      :sda => {
        :model => 'VBOX HARDDISK',
        :size => '20.00 GiB',
        :size_bytes => 21474836480,
        :vendor => 'ATA'
      },
      :sr0 => {
        :model => 'CD-ROM',
        :size => '1.00 GiB',
        :size_bytes => 1073741312,
        :vendor => 'VBOX'
      }
    },
    :dmi => {
      :bios => {
        :release_date => '12/01/2006',
        :vendor => 'innotek GmbH',
        :version => 'VirtualBox'
      },
      :board => {
        :manufacturer => 'Oracle Corporation',
        :product => 'VirtualBox',
        :serial_number => '0'
      },
      :chassis => {
        :type => 'Other'
      },
      :manufacturer => 'innotek GmbH',
      :product => {
        :name => 'VirtualBox',
        :serial_number => '0',
        :uuid => '3300B560-11F8-4F55-AD68-1B6750B7E80B'
      }
    },
    :facterversion => '4.0.0',
    :filesystems => 'xfs',
    :identity => {
      :gid => '0',
      :group => 'root',
      :privileged => true,
      :uid => '0',
      :user => 'root'
    },
    :is_virtual => true,
    :kernel => 'Linux',
    :kernelmajversion => '3.10',
    :kernelrelease => '3.10.0-514.21.2.el7.x86_64',
    :kernelversion => '3.10.0',
    :load_averages => {
      :'15m' => '0.09',
      :'1m' => '1.26',
      :'5m' => '0.28'
    },
    :memory => {
      :swap => {
        :available => '2.00 GiB',
        :available_bytes => '2147479552',
        :capacity => '0%',
        :total => '2.00 GiB',
        :total_bytes => '2147479552',
        :used => '0 bytes',
        :used_bytes => '0'
      },
      :system => {
        :available => '4.99 GiB',
        :available_bytes => '5355151360',
        :capacity => '11.75%',
        :total => '5.65 GiB',
        :total_bytes => '6067830784',
        :used => '679.66 MiB',
        :used_bytes => '712679424'
      }
    },
    :networking => {
      :dhcp => '10.0.2.2',
      :domain => 'psick.io',
      :fqdn => 'puppet5.psick.io',
      :hostname => 'puppet5',
      :interfaces => {
        :enp0s3 => {
          :bindings => [
            {
              :address => '10.0.2.15',
              :netmask => '255.255.255.0',
              :network => '10.0.2.0'
            }
          ],
          :bindings6 => [
            {
              :address => 'fe80::a00:27ff:fed3:1dcc',
              :netmask => 'ffff:ffff:ffff:ffff::',
              :network => 'fe80::'
            }
          ],
          :dhcp => '10.0.2.2',
          :ip => '10.0.2.15',
          :ip6 => 'fe80::a00:27ff:fed3:1dcc',
          :mac => '08:00:27:d3:1d:cc',
          :mtu => '1500',
          :netmask => '255.255.255.0',
          :netmask6 => 'ffff:ffff:ffff:ffff::',
          :network => '10.0.2.0',
          :network6 => 'fe80::'
        },
        :lo => {
          :bindings => [
            {
              :address => '127.0.0.1',
              :netmask => '255.0.0.0',
              :network => '127.0.0.0'
            }
          ],
          :bindings6 => [
            {
              :address => '::1',
              :netmask => 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff',
              :network => '::1'
            }
          ],
          :ip => '127.0.0.1',
          :ip6 => '::1',
          :mtu => '65536',
          :netmask => '255.0.0.0',
          :netmask6 => 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff',
          :network => '127.0.0.0',
          :network6 => '::1'
        }
      },
      :ip => '10.0.2.15',
      :ip6 => 'fe80::a00:27ff:fed3:1dcc',
      :mac => '08:00:27:d3:1d:cc',
      :mtu => '1500',
      :netmask => '255.255.255.0',
      :netmask6 => 'ffff:ffff:ffff:ffff::',
      :network => '10.0.2.0',
      :network6 => 'fe80::',
      :primary => 'enp0s3'
    },
    :ostempdir => '/tmp',
    :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin',
    :processors => {
      :count => '4',
      :isa => 'x86_64',
      :models => [
        'Intel(R) Core(TM) i7-3635QM CPU @ 2.40GHz',
        'Intel(R) Core(TM) i7-3635QM CPU @ 2.40GHz',
        'Intel(R) Core(TM) i7-3635QM CPU @ 2.40GHz',
        'Intel(R) Core(TM) i7-3635QM CPU @ 2.40GHz'
      ],
      :physicalcount => '1'
    },
    :ruby => {
      :platform => 'x86_64-linux',
      :sitedir => '/opt/puppetlabs/puppet/lib/ruby/site_ruby/2.4.0',
      :version => '2.4.1'
    },
    :ssh => {
      :ecdsa => {
        :fingerprints => {
          :sha1 => 'SSHFP 3 1 af3961c404f7dc13abf3046291769e1ef3f21388',
          :sha256 => 'SSHFP 3 2 9fa15002279f1c66521fd3123cc4286dd448ff9746d230f801d294373af0d921'
        },
        :key => 'AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFi1OjBCBc+ElGXdkRt2qbia1IhTKb5MaVmRumCgRW1H9btp/+k8utqgqUNnBDtrhoiZ08DnoStBCnc5FNipRzk='
      },
      :ed25519 => {
        :fingerprints => {
          :sha1 => 'SSHFP 4 1 71e773885477cab6989a89da9279a4e60f1b5b92',
          :sha256 => 'SSHFP 4 2 6eadaa98869bf9d4c660f57871d221a2ac430fd226cf7b8de6ea4f07236c9684'
        },
        :key => 'AAAAC3NzaC1lZDI1NTE5AAAAINvn0rqB5eKY+KHAxFHQLC2zHiR+RNbCLKQGtj3fW0ik'
      },
      :rsa => {
        :fingerprints => {
          :sha1 => 'SSHFP 1 1 24ffa366964e71ba0ae076fa8461103c35a38ff9',
          :sha256 => 'SSHFP 1 2 aa0ecbe944c38717c070a98cfced2cce938e5e48e379bb17663936196f88d423'
        },
        :key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDdJbS8DmEsjI+ttGgl8/Rp+TACvKMTfGejqoT46mBXlEoZ554Wp5VHDx4GqJUi62O11MDleWuyXUdeMwlljWjXEGGsKm4VZpAcG3MANtAbEqhXmq1/4xaIXxpA1RtwJyPL2oQt90TD6bjArEui5xjzefw006/7JgtXu6i/INtdZCvOgx2sXkyFpuM8p7GcIfJsG6ndqeWD80Dgmkx2gJJTLL5Z9SbE8PRLqIp8Mp0oz+MheBzkMl5F9ev/hRfqw8udVqeeynA3B2HviwBTvqx4ZI8G77bNdSf2mGcaWQOK97SjSV4KZhVYDI9ZlbAxP1cBRzrsleIbZf5vn7Wq8jTD'
      }
    },
    :system_uptime => {
      :days => '0',
      :hours => '0',
      :seconds => '21',
      :uptime => '0:00 hours'
    },
    :timezone => 'CEST',
    :virtual => 'virtualbox'
  }
