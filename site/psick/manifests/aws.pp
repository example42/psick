#
class psick::aws (
  String $region = chop($::ec2_placement_availability_zone),

  String $default_vpc_name = 'myvpc',
  String $default_cidr_block_prefix = '10.0',
  Boolean $create_defaults = false,

  String $cli_class        = '::psick::aws::cli',
  String $vpc_class        = '',
  String $sg_class         = '',
  String $ec2_class        = '',
  String $rds_class        = '',
) {

  if $cli_class != '' {
    contain $cli_class
  }
  if $vpc_class != '' {
    contain $vpc_class
  }
  if $sg_class != '' {
    contain $sg_class
  }
  if $ec2_class != '' {
    contain $ec2_class
  }
  if $rds_class != '' {
    contain $rds_class
  }

}
