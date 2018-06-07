class profile::route53 (
	String $domain		='graduway.com.',
	String $environment	= undef,
	String $hostname	= undef,
	String $ip_address	= undef,
){

  route53_a_record { "${hostname}.${environment}.${domain}":
    ensure => present,
    zone   => "${environment}.${domain}",
    ttl    => 300,
    values => ["${ip_address}"],
  }
}
