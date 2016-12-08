# = Define tools::yum::repo
# Derived from example42-yum module
#
define tools::yum::repo (
  String $descr           = 'absent',
  String $baseurl         = 'absent',
  String $mirrorlist      = 'absent',
  Integer $enabled        = 0,
  Integer $gpgcheck       = 0,
  String $gpgkey          = 'absent',
  String $gpgkey_source   = '',
  String $gpgkey_name     = '',
  String $failovermethod  = 'absent',
  Integer $priority       = 99,
  String $protect         = 'absent',
  String $exclude         = 'absent',
  String $autokeyimport   = 'no',
  String $includepkgs     = 'absent',
  String $metadata_expire = 'absent',
  String $include         = 'absent',
  String $sslcacert       = 'absent',
  String $sslclientcert   = 'absent',
  String $sslclientkey    = 'absent',
  String $sslverify       = 'absent',
  ) {

  if $protect != 'absent' {
    if ! defined(Tools::Yum::Plugin['protectbase']) {
      tools::yum::plugin { 'protectbase': }
    }
  }

  if ! defined(File["/etc/yum.repos.d/${name}.repo"]) {
    file { "/etc/yum.repos.d/${name}.repo":
      ensure  => file,
      replace => false,
      before  => Yumrepo[ $name ],
      mode    => '0644',
      owner   => 'root',
      group   => 0,
    }

    $gpgkey_real_name = $gpgkey_name ? {
      ''      => url_parse($gpgkey_source,'filename'),
      default => $gpgkey_name,
    }

    if $gpgkey_source != '' {
      if ! defined(File["/etc/pki/rpm-gpg/${gpgkey_real_name}"]) {
        file { "/etc/pki/rpm-gpg/${gpgkey_real_name}":
          ensure  => file,
          replace => false,
          before  => Yumrepo[ $name ],
          source  => $gpgkey_source,
          mode    => '0644',
          owner   => 'root',
          group   => 0,
        }
      }
    }
  }

  if ! defined(Yumrepo[$name]) {
    yumrepo { $name:
      descr           => $descr,
      baseurl         => $baseurl,
      mirrorlist      => $mirrorlist,
      enabled         => $enabled,
      gpgcheck        => $gpgcheck,
      gpgkey          => $gpgkey,
      failovermethod  => $failovermethod,
      priority        => $priority,
      protect         => $protect,
      exclude         => $exclude,
      includepkgs     => $includepkgs,
      metadata_expire => $metadata_expire,
      include         => $include,
      sslcacert       => $sslcacert,
      sslclientcert   => $sslclientcert,
      sslclientkey    => $sslclientkey,
      sslverify       => $sslverify
    }

    if $autokeyimport == 'yes' and $gpgkey != '' {
      exec { "rpmkey_add_${gpgkey}":
        command     => "rpm --import ${gpgkey}",
        before      => Yumrepo[ $name ],
        refreshonly => true,
        path        => '/sbin:/bin:/usr/sbin:/usr/bin',
      }
    }
  }
}
