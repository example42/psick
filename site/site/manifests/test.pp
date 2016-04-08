# Some basic tests

class site::test {

  # include site::web::nginx
  package { 'git': }
  ::tp::install { 'apache': }
  ::tp::conf { 'apache::testlog':
    base_dir => 'log',
    content  => '# test ',
  }
  ::tp::conf { 'apache::testconf':
    content  => '# test ',
  }

  tp::dir { 'test':
    path        => '/opt/tp_self',
    source      => 'https://github.com/example42/puppet-tp/',
    vcsrepo     => 'git',
  }

}
