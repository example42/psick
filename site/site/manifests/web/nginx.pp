class site::web::nginx {

  ::tp::install3 { 'nginx' : }
  $nginx_options = {
    'worker_processes'   => '12',
    'worker_connections' => '512',
  }
  tp::conf3 { 'nginx':
    template     => 'site/nginx/nginx.conf.erb',
    options_hash => $nginx_options,
  }

}
