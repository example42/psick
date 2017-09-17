# Setup a VPC
class psick::aws::puppet::vpc (
  String $region                    = $::psick::aws::region,
  String $ensure                    = 'present',
  String $default_cidr_block_prefix = $::psick::aws::default_cidr_block_prefix,
  String $default_vpc_name          = $::psick::aws::default_vpc_name,
  Boolean $create_defaults          = $::psick::aws::create_defaults,

  Hash   $ec2_vpcs                  = { },
  Hash   $ec2_vpc_subnets           = { },
  Hash   $ec2_vpc_routetables       = { },
  Hash   $ec2_vpc_internet_gateways = { },

) {

  if $ensure == 'absent' {
    #lint:ignore:spaceship_operator_without_tag
    Ec2_vpc_routetable<||>
    -> Ec2_vpc_internet_gateway<||>
    -> Ec2_vpc_subnet<||>
    -> Ec2_vpc<|name == $default_vpc_name|>
    #   Ec2_vpc<||>
    #lint:endignore 
  }

  # Default resources, if enabled
  if $create_defaults {
    $default_ec2_vpcs = {
      $default_vpc_name => {
        ensure       => 'present',
        region       => $region,
        cidr_block   => "${default_cidr_block_prefix}.0.0/16",
      },
    }

    $default_ec2_vpc_internet_gateways = {
      "${default_vpc_name}-igw" => {
        ensure       => $ensure,
        region       => $region,
        vpc          => $default_vpc_name,
      },
    }

    $default_ec2_vpc_routetables = {
      "${default_vpc_name}-public" => {
        ensure       => $ensure,
        region       => $region,
        vpc          => $default_vpc_name,
        routes => [
          {
            destination_cidr_block => '0.0.0.0/0',
            gateway                => "${default_vpc_name}-igw",
          },{
            destination_cidr_block => "${default_cidr_block_prefix}.0.0/16",
            gateway                => 'local'
          },
        ],
      },
    }

    $default_ec2_vpc_subnets = {
      "${default_vpc_name}_dmz_a" => {
        cidr_block        => "${default_cidr_block_prefix}.1.0/24",
        availability_zone => "${region}a",
        route_table       => "${default_vpc_name}-public",
      },
      "${default_vpc_name}_dmz_b" => {
        cidr_block        => "${default_cidr_block_prefix}.2.0/24",
        availability_zone => "${region}b",
        route_table       => "${default_vpc_name}-public",
      },
      "${default_vpc_name}_rds_a" => {
        cidr_block        => "${default_cidr_block_prefix}.41.0/24",
        availability_zone => "${region}a",
      },
      "${default_vpc_name}_rds_b" => {
        cidr_block        => "${default_cidr_block_prefix}.42.0/24",
        availability_zone => "${region}b",
      },
      "${default_vpc_name}_mgmt_a" => {
        cidr_block        => "${default_cidr_block_prefix}.11.0/24",
        availability_zone => "${region}a",
      },
      "${default_vpc_name}_mgmt_b" => {
        cidr_block        => "${default_cidr_block_prefix}.12.0/24",
        availability_zone => "${region}b",
      },
    }
  } else {
    $default_ec2_vpcs = {}
    $default_ec2_vpc_subnets = {}
    $default_ec2_vpc_routetables = {}
    $default_ec2_vpc_internet_gateways = {}
  }
  $all_ec2_vpcs = $ec2_vpcs+$default_ec2_vpcs
  $all_ec2_vpc_subnets = $ec2_vpc_subnets+$default_ec2_vpc_subnets
  $all_ec2_vpc_routetables = $ec2_vpc_routetables+$default_ec2_vpc_routetables
  $all_ec2_vpc_internet_gateways = $ec2_vpc_internet_gateways+$default_ec2_vpc_internet_gateways

  # VPC
  $ec2_vpcs_defaults = {
    ensure                  => $ensure,
    region                  => $region,
  }
  if $all_ec2_vpcs != { } {
    create_resources('Ec2_vpc',$all_ec2_vpcs,$ec2_vpcs_defaults)
  }

  # Subnets
  $ec2_vpc_subnets_defaults = {
    ensure                  => $ensure,
    region                  => $region,
    vpc                     => $default_vpc_name,
    availability_zone       => "${region}a",
    map_public_ip_on_launch => false,
    route_table             => $default_vpc_name,
  }
  if $all_ec2_vpc_subnets != { } {
    create_resources('ec2_vpc_subnet',$all_ec2_vpc_subnets,$ec2_vpc_subnets_defaults)
  }


  $ec2_vpc_internet_gateways_defaults = {
    ensure     => $ensure,
    region     => $region,
    vpc        => $default_vpc_name,
  }
  if $all_ec2_vpc_internet_gateways != { } {
    create_resources('ec2_vpc_internet_gateway',$all_ec2_vpc_internet_gateways,$ec2_vpc_internet_gateways_defaults)
  }


  $ec2_vpc_routetables_defaults = {
    ensure     => $ensure,
    region     => $region,
    vpc        => $default_vpc_name,
  }
  if $all_ec2_vpc_routetables != { } {
    create_resources('ec2_vpc_routetable',$all_ec2_vpc_routetables,$ec2_vpc_routetables_defaults)
  }

}
