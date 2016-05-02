define profile::aws::setup::vpc (
  String $ensure     = 'present',
  String $vpc        = $title,
  String $region     = 'us-east-1',
  String $cidr_block = '10.0.0.0/16',
) {

  ec2_vpc { $vpc:
    ensure       => $present,
    region       => $region,
    cidr_block   => $cidr_block,
  }

  ec2_securitygroup { "ssh-${vpc}":
    ensure       => $present,
    region       => $region,
    vpc          => $vpc,
    description  => "SSH to ${vpc}",
    ingress     => [{
      security_group => "ssh-${vpc}",
    },{
      protocol => 'tcp',
      port     => 22,
      cidr     => '0.0.0.0/0'
    }]
  }
  
  ec2_vpc_subnet { "eternal-${vpc}-1a":
    ensure       => $present,
    region       => $region,
    vpc               => $vpc,
    cidr_block        => $cidr_block,
    availability_zone => "${vpc}-1a",
    route_table       => "${vpc}-default",
  }
  
  ec2_vpc_internet_gateway { "${vpc}-igw":
    ensure       => $present,
    region       => $region,
    vpc          => $vpc,
  }
  
  ec2_vpc_routetable { "${vpc}-default":
    ensure       => $present,
    region       => $region,
    vpc    => $vpc,
    routes => [
      {
        destination_cidr_block => $cidr_block,
        gateway                => 'local'
      },{
        destination_cidr_block => '0.0.0.0/0',
        gateway                => "${vpc}-igw",
      },
    ],
  }

}
