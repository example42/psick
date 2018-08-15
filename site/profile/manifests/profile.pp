class profile::profile (
  	String $template  = '',
  	Hash   $scripts = {},
){

      $scripts.each |$k,$v| {
        psick::profile::script { $k:
          * => $v,
        }
  }
}
