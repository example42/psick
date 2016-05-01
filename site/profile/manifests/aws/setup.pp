class profile::aws::setup (
  String $ensure     = 'present',
  Hash   $vpc_hash   = { },
) {

  $create_resources('profile::aws::setup::vpc', $vpc_hash)
  
}
