class profile::aws::setup (
  Hash vpc_hash,
) {

  create_resources('profile::aws::setup::vpc', $vpc_hash)
  
}
