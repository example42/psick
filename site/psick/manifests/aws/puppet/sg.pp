# Setup security groups
class psick::aws::puppet::sg (
  String $ensure                    = 'present',

  String $region                    = $::psick::aws::region,
  String $default_vpc_name          = $::psick::aws::default_vpc_name,
  Boolean $create_defaults          = $::psick::aws::create_defaults,
  String $default_cidr_block_prefix = $::psick::aws::default_cidr_block_prefix,
  Hash   $ec2_securitygroups        = { },
) {

  # Default resources, if enabled
  if $create_defaults {
    $default_ec2_securitygroups = {
      'public-ssh' => {
        description  => 'Public access to SSH TCP 22',
        ingress      => [{
          'cidr'      => "${default_cidr_block_prefix}.0.0/16",
          'from_port' => '0',
          'to_port'   => '0',
          'protocol'  => '-1',
        },{
          'cidr'      => '0.0.0.0/0',
          'from_port' => '22',
          'protocol'  => 'tcp',
          'to_port'   => '22',
        },{
          'cidr'      => '0.0.0.0/0',
          'from_port' => '1194',
          'protocol'  => 'tcp',
          'to_port'   => '1194',
        }],
        tags         => {
          'Name' => "${default_vpc_name}-public-ssh",
        },
      },
      'public-http' => {
        description  => 'Public access to HTTP TCP 80 and 443',
        ingress      => [{
          'cidr'      => '0.0.0.0/0',
          'from_port' => '80',
          'protocol'  => 'tcp',
          'to_port'   => '80',
        },{
          'cidr'      => '0.0.0.0/0',
          'from_port' => '443',
          'protocol'  => 'tcp',
          'to_port'   => '443',
        }],
        tags         => {
          'Name' => "${default_vpc_name}-public-http",
        },
      },
      'private-mysql' => {
        description  => 'Private access access to MYSQL 3306',
        ingress      => [{
          'cidr'      => "${default_cidr_block_prefix}.0.0/16",
          'from_port' => '3306',
          'protocol'  => 'tcp',
          'to_port'   => '3306',
        }],
        tags         => {
          'Name' => "${default_vpc_name}-private-mysql",
        },
      },
      'private-ci' => {
        description  => 'Access to CI from internal nodes',
        ingress      => [{
          'cidr'      => "${default_cidr_block_prefix}.0.0/16",
          'from_port' => '8080',
          'protocol'  => 'tcp',
          'to_port'   => '8080',
        }],
        tags         => {
          'Name' => "${default_vpc_name}-private-ci",
        },
      },
      'private-ssh' => {
        description  => 'Access to SSH from internal nodes',
        ingress      => [{
          'cidr'      => "${default_cidr_block_prefix}.0.0/16",
          'from_port' => '0',
          'to_port'   => '0',
          'protocol'  => '-1',
        },{
          'cidr'      => "${default_cidr_block_prefix}.0.0/16",
          'from_port' => '22',
          'protocol'  => 'tcp',
          'to_port'   => '22',
        }],
        tags         => {
          'Name' => "${default_vpc_name}-private-ssh",
        },
      },
    }
  } else {
    $default_ec2_securitygroups = {}
  }
  $all_ec2_securitygroups = $ec2_securitygroups+$default_ec2_securitygroups

  # VPC
  $ec2_securitygroups_defaults = {
    ensure                  => $ensure,
    region                  => $region,
    vpc                     => $default_vpc_name,
  }
  if $all_ec2_securitygroups != { } {
    create_resources('ec2_securitygroup',$all_ec2_securitygroups,$ec2_securitygroups_defaults)
  }

}
