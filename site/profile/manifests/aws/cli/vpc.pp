# Setup a VPC via aws cli
class profile::aws::cli::vpc (
  String  $region                    = $::profile::aws::region,
  String  $ensure                    = 'present',
  String  $default_cidr_block_prefix = $::profile::aws::default_cidr_block_prefix,
  String  $default_vpc_name          = $::profile::aws::default_vpc_name,
  Boolean $create_defaults           = $::profile::aws::create_defaults,
  Boolean $autorun                   = true,
  Hash    $aws_scripts               = { },
) {


  if $create_defaults {
    $default_aws_scripts = {
      "vpc_${default_vpc_name}" => {
        template    => 'profile/aws/cli/vpc.erb',
      },
    }
  } else {
    $default_aws_scripts = {}
  }
  $all_aws_scripts = $aws_scripts+$default_aws_scripts

  $aws_scripts_defaults = {
    ensure                  => $ensure,
    region                  => $region,
    autorun                 => $autorun,
  }
  if $all_aws_scripts != { } {
    create_resources('Profile::Aws::Script',$all_aws_scripts,$aws_scripts_defaults)
  }
}
