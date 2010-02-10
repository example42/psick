class apache::debian {

# Quick'n'dirt fix for logs directory in apache::virtualhost base template
	file {	
             	"Apache_loglink":
			path   => "/etc/apache2/logs",
			ensure => "/var/log/apache2/",
	}
}

