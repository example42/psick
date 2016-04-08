class site::repo {

  if $::osfamily == 'RedHat' {
    tp::repo3 { 'epel': }
  }

}
