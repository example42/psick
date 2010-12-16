        nrpe_command{"check_mysqldump":
                command => "check_file_age",
                parameters => "-f /srv/backup/mysql/mysql.dump -w 86400 -c 90000 -W 8000 -C 8000"
        }


        nrpe_command{"check_mysqldump":
                command => "check_file.pl",
                parameters => "--file /srv/backup/mysql/latest  --warnage=89999 --critage=90000 --critsize=300000000 --warnsize=60000000 --larger",
                cplugdir => "/usr/local/bin",
        }


