# Setup RDS
class psick::aws::puppet::rds (
  String  $default_master_user_password,

  String  $ensure                          = 'present',

  String  $region                          = $::psick::aws::region,
  String  $default_vpc_name                = $::psick::aws::default_vpc_name,
  Boolean $create_defaults                 = $::psick::aws::create_defaults,

  Boolean $multi_az                        = false,

  # Hashes of resources to create
  Hash    $rds_instances                   = { },
  Hash    $rds_db_securitygroups           = { },
  Hash    $rds_db_parameter_groups         = { },

  # Default settings
  String  $default_db_name                 = 'db',
  String  $default_db_instance_class       = 'db.t2.micro',
  String  $default_allocated_storage       = '100',
  String  $default_backup_retention_period = '7',
  String  $default_engine_version          = '5.7.11',
  String  $default_db_parameter_group      = 'default.mysql5.7',
  String  $default_engine                  = 'mysql',
  String  $default_storage_type            = 'gp2',
  String  $default_master_username         = 'admin',

  String  $default_family                  = 'mysql5.7',

) {

  if $ensure == 'absent' {
    Rds_db_securitygroup<|name == $title|>
    -> Rds_instance<|name == $title|>
  }

  # Default resources, if enabled
  if $create_defaults {
    $default_rds_instances = {
      "${default_vpc_name}-rds" => {
        ensure    => present,
        db_subnet => "${default_vpc_name}-rds", # TODO: Automate creation of
                                                  #       DB subnet groups
      },
    }
    $default_rds_db_securitygroups = {
      #    rds_sg => {
      #  description => 'Default security group',
      #  ip_ranges   => [{'ip_range' => '10.0.0.0/16', 'status' => 'authorized'}],
      #}
    }
    $default_rds_db_parameter_groups = {}

  } else {
    $default_rds_instances = {}
    $default_rds_db_securitygroups = {}
    $default_rds_db_parameter_groups = {}
  }
  $all_rds_instances = $rds_instances+$default_rds_instances
  $all_rds_db_securitygroups = $rds_db_securitygroups+$default_rds_db_securitygroups
  $all_rds_db_parameter_groups = $rds_db_parameter_groups+$default_rds_db_parameter_groups

  # RDS INSTANCES
  $rds_instances_defaults = {
    ensure                          => $ensure,
    region                          => $region,
    allocated_storage               => $default_allocated_storage,
    backup_retention_period         => $default_backup_retention_period,
    db_instance_class               => $default_db_instance_class,
    db_parameter_group              => $default_db_parameter_group,
    engine                          => $default_engine,
    engine_version                  => $default_engine_version,
    license_model                   => 'general-public-license',
    master_username                 => $default_master_username,
    master_user_password            => $default_master_user_password,
    multi_az                        => $multi_az,
    storage_type                    => $default_storage_type,
  }

  if $all_rds_instances != { } {
    create_resources('rds_instance',$all_rds_instances,$rds_instances_defaults)
  }


  # RDS SECURITYGROUPS
  $rds_db_securitygroups_defaults = {
    ensure     => $ensure,
    region     => $region,
  }
  if $all_rds_db_securitygroups != { } {
    create_resources('rds_db_securitygroup',$all_rds_db_securitygroups,$rds_db_securitygroups_defaults)
  }


  # RDS PARAMETER GROUPS
  $rds_db_parameter_groups_defaults = {
    ensure     => $ensure,
    region     => $region,
    family     => $default_family,
  }
  if $all_rds_db_parameter_groups != { } {
    create_resources('rds_db_parameter_group',$all_rds_db_parameter_groups,$rds_db_parameter_groups_defaults)
  }

}
