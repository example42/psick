#
class psick::oracle::resources (
  # Resource types provided by hajee/oracle module
  Hash $ora_listeners       = { },
  Hash $ora_users           = { },
  Hash $ora_tablespaces     = { },
  Hash $ora_roles           = { },
  Hash $ora_services        = { },
  Hash $ora_init_params     = { },
  Hash $ora_asm_diskgroups  = { },
  Hash $ora_execs           = { },
  Hash $ora_threads         = { },
  Hash $ora_databases       = { },

  # Resource types provided by biemond/oradb module
  Hash $db_opatchs          = { },
  Hash $db_rcus             = { },
  Hash $db_controls         = { },
  Hash $db_listeners        = { },

) {

  # Resource types provided by hajee/oracle module
  if $ora_listeners != '{ }' {
    create_resources('ora_listener',$ora_listeners)
  }
  if $ora_users != '{ }' {
    create_resources('ora_users',$ora_users)
  }
  if $ora_tablespaces != '{ }' {
    create_resources('ora_tablespaces',$ora_tablespaces)
  }
  if $ora_roles != '{ }' {
    create_resources('ora_roles',$ora_roles)
  }
  if $ora_services != '{ }' {
    create_resources('ora_services',$ora_services)
  }
  if $ora_init_params != '{ }' {
    create_resources('ora_init_params',$ora_init_params)
  }
  if $ora_asm_diskgroups != '{ }' {
    create_resources('ora_asm_diskgroups',$ora_asm_diskgroups)
  }
  if $ora_execs != '{ }' {
    create_resources('ora_execs',$ora_execs)
  }
  if $ora_threads != '{ }' {
    create_resources('ora_threads',$ora_threads)
  }
  if $ora_databases != '{ }' {
    create_resources('ora_databases',$ora_databases)
  }


  # Resource types provided by biemond/oradb module
  if $db_opatchs != '{ }' {
    create_resources('db_opatchs',$db_opatchs)
  }
  if $db_rcus != '{ }' {
    create_resources('db_rcus',$db_rcus)
  }
  if $db_controls != '{ }' {
    create_resources('db_controls',$db_controls)
  }
  if $db_listeners != '{ }' {
    create_resources('db_listeners',$db_listeners)
  }

}
