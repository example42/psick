# Subclass for a managed application

$apache_processname = $operatingsystem ?{
  	             default => "httpd",
               },

$apache_port = "80"


class apache::managed inherits apache {

	backup {
		"wwwdata": 
		frequency => daily,
		path	=> $operatingsystem ?{
                                default => "/var/www/html",
                        },		
		enabled	=> "yes",
	}
	
	monitor {
		"Port_$apache_port":
		type	=> "port",
		proto	=> "tcp",
		port 	=> $apache_port,
		address => "localhost",
		enabled	=> "yes",
	}

	monitor {
		"Service_$apache_processname":
		type	=> "process",
		name	=> $apache_processname,
		enabled	=> "yes",
	}

	audit {
		"Service_$apache_processname":
		type	=> "process",
		name	=> $apache_processname,
	}

	docs {
		"Apache_Documentation":
		url => "http://httpd.apache.org",
	}
	
}
