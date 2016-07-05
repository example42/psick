# Setup security groups
class profile::aws::setup::sg (
  String $region,
  String $ensure                    = 'present',
  String $default_vpc_name          = 'myvpc',
  Boolean $create_defaults          = false,

  Hash   $ec2_securitygroups        = { },

) {

  # Default resources, if enabled
  if $create_defaults {
    $default_ec2_securitygroups = {
      'public-ssh' => {
        description  => 'Public access to SSH TCP 22',
        ingress      => [{
          'cidr'      => '0.0.0.0/0',
          'from_port' => '22',
          'protocol'  => 'tcp',
          'to_port'   => '22',
        }],
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
      },
      'private-mysql' => {
        description  => 'Private access access to MYSQL 3306',
        ingress      => [{
          'cidr'      => '10.0.0.0/8',
          'from_port' => '3306',
          'protocol'  => 'tcp',
          'to_port'   => '3306',
        }],
      },
      'private-mongo' => {
        description  => 'Private access access to Mongo 27017',
        ingress      => [{
          'cidr'      => '10.0.0.0/8',
          'from_port' => '27017',
          'protocol'  => 'tcp',
          'to_port'   => '27017',
        }],
      },
      'private-ssh' => {
        description  => 'Access to SSH from internal nodes',
        ingress      => [{
          'cidr'      => '10.0.0.0/8',
          'from_port' => '22',
          'protocol'  => 'tcp',
          'to_port'   => '22',
        }],
      }
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
