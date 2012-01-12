class example42::role::ci {
    $role="ci"

    include example42::role::general
    
    class { "tomcat":
        monitor => true,
        puppi   => true,
    }
    class { "jenkins":
        install => 'puppi',
        monitor => true,
    }

# QUick packages 
    package { "rubygems": ensure => present }
    package { "rake": ensure => present }
    package { "git": ensure => present }
    package { "puppet": ensure => present , provider => gem }
    package { "rspec-puppet": ensure => present , provider => gem }
    package { "puppet-lint": ensure => present , provider => gem }
    file { "/usr/share/tomcat6/.gitconfig": ensure => present , source => "puppet://modules/example42/role/ci/gitconfig" }
}
