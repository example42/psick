# Setup ec2 instances and related stuff
# Important Params:
# *region* On which AWS region operate (mandatory)
# *ensure* Valid values: present, absent, running, stopped
# *create_defaults* Boolean to define it to automatically create a set of
#                   default resources
# *ec2_instances* An hash of (extra) ec2_instances to create
# *ec2_launchconfigurations* An hash of (extra) ec2_launchconfigurations create
# *ec2_autoscalinggroups* An hash of (extra) ec2_autoscalinggroups to create
# 
# A list of parameters setting the default values for default and extra
# ec2_instance resources. You can override them either setting the default value
# via the parameters, or in the $ec2_instances hash for each extra instance
# *default_instance_type* , *default_image_id* , *default_ebs_optimized*,
# *default_monitoring*, *default_vpc_name*
#
# A similar list of parameters for the defaults of ec2_launchconfigurations
# *default_autoscaling_instance_type* , *default_autoscaling_image_id*
#
class profile::aws::setup::ec2 (
  String  $region,
  String  $default_key_name,

  String  $ensure                  = 'present',

  Boolean $create_defaults         = false,

  # Hashes of resources to create
  Hash    $ec2_instances           = { },
  Hash    $ec2_launchconfigurations   = { },
  Hash    $ec2_autoscalinggroups = { },

  # Default settings
  String  $default_instance_type  = 't2.micro',
  String  $default_autoscaling_instance_type       = 't2.small',

  Variant[Undef,String] $default_image_id = undef,
  Variant[Undef,String] $default_autoscaling_image_id = undef,

  Boolean $default_ebs_optimized       = false,
  Boolean $default_monitoring          = false,

  String  $default_vpc_name            = $::profile::aws::setup::vpc::default_vpc_name,
) {

  # Amazon AMI used by default
  $calculated_image_id = $region ? {
    'eu-west-1'    => 'ami-b0ac25c3',
    'eu-central-1' => 'ami-ea26ce85',
    'us-west-1'    => 'ami-b0ac25c3', # TODO: Find correct one
    'us-west-2'    => 'ami-b0ac25c3', # TODO: Find correct one
    'us-east-1'    => 'ami-b0ac25c3', # TODO: Find correct one
    default        => 'ami-b0ac25c3',
  }
  $calculated_autoscaling_image_id = $region ? {
    'eu-west-1'    => 'ami-b0ac25c3',
    'eu-central-1' => 'ami-ea26ce85',
    'eu-central-1' => 'ami-b0ac25c3', # TODO: Find correct one
    'us-west-1'    => 'ami-b0ac25c3', # TODO: Find correct one
    'us-west-2'    => 'ami-b0ac25c3', # TODO: Find correct one
    'us-east-1'    => 'ami-b0ac25c3', # TODO: Find correct one
    default        => 'ami-b0ac25c3',
  }

  $plain_ensure = $ensure ? {
    'absent' => 'absent',
    default  => 'present',
  }
  if $ensure == 'absent' {
    Rds_db_securitygroup<|name == $title|> ->
    Rds_instance<|name == $title|> 
  }

  # Default resources, if enabled
  if $create_defaults {
    $default_ec2_instances = {
      "${default_vpc_name}-bastion" => {
        subnet                      => "${default_vpc_name}_dmz_a",
        associate_public_ip_address => true,
        security_groups             => [ 'public-ssh' ],
      },
      "${default_vpc_name}-app01" => {
        subnet            => "${default_vpc_name}_app_application_a",
        security_groups   => [ 'public-http' ],
      },
      "${default_vpc_name}-mongo01" => {
        subnet            => "${default_vpc_name}_app_mongo_a",
        security_groups   => [ 'private-mongo' ],
      },
      "${default_vpc_name}-mongo02" => {
        subnet            => "${default_vpc_name}_app_mongo_b",
        availability_zone => "${region}b",
        security_groups   => [ 'private-mongo' ],
      },
      "${default_vpc_name}-ci" => {
        subnet            => "${default_vpc_name}_mgmt_a",
        security_groups   => [ 'private-ssh' , 'public-http' ],
      },
      "${default_vpc_name}-mon" => {
        subnet            => "${default_vpc_name}_mgmt_a",
        security_groups   => [ 'private-ssh' , 'public-http' ],
      }
    }
    $default_ec2_launchconfigurations = {}
    $default_ec2_autoscalinggroups = {}

  } else {
    $default_ec2_instances = {}
    $default_ec2_launchconfigurations = {}
    $default_ec2_autoscalinggroups = {}
  }
  $all_ec2_instances = $ec2_instances+$default_ec2_instances
  $all_ec2_launchconfigurations = $ec2_launchconfigurations+$default_ec2_launchconfigurations
  $all_ec2_autoscalinggroups = $ec2_autoscalinggroups+$default_ec2_autoscalinggroups

  # EC2 INSTANCES
  $ec2_instances_defaults = {
    ensure               => $ensure,
    region               => $region,
    availability_zone    => "${region}a",
    image_id             => pick($default_image_id,$calculated_image_id),
    instance_type        => $default_instance_type,
    ebs_optimized        => $default_ebs_optimized,
    monitoring           => $default_monitoring,
    key_name             => $default_key_name,
  }

  if $all_ec2_instances != { } {
    create_resources('ec2_instance',$all_ec2_instances,$ec2_instances_defaults)
  }


  # EC2 AUTOSCALING
  $ec2_launchconfigurations_defaults = {
    ensure        => $plain_ensure,
    region        => $region,
    image_id      => pick($default_autoscaling_image_id,$calculated_autoscaling_image_id),
    instance_type => $default_autoscaling_instance_type,
    key_name      => $default_key_name,
  }
  if $all_ec2_launchconfigurations != { } {
    create_resources('ec2_launchconfiguration',$all_ec2_launchconfigurations,$ec2_launchconfigurations_defaults)
  }


  $ec2_autoscalinggroups_defaults = {
    ensure     => $plain_ensure,
    region     => $region,
  }
  if $all_ec2_autoscalinggroups != { } {
    create_resources('ec2_autoscalinggroup',$all_ec2_autoscalinggroups,$ec2_autoscalinggroups_defaults)
  }

}
