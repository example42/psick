class postgresql::augeas {

    file { "/usr/share/augeas/lenses/contrib":
	ensure => directory,
	mode => 0755, owner => root, group => root,
    }

    file { "pg_hba.aug":
	path => "/usr/share/augeas/lenses/contrib/pg_hba.aug",
	mode => 0644, owner => root, group => root,
	source => "puppet:///modules/postgresql/pg_hba.aug",
	require => File["/usr/share/augeas/lenses/contrib"],
	replace => false,
    }

}
