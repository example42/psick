class profile::aws::vpc (
  Hash $vpc_hash,
) {

  create_resources('profile::aws::::vpc', $vpc_hash)
  
}
