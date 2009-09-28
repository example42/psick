USE mysql;
DELETE FROM user WHERE User="sysloguser" ;
DELETE FROM user WHERE User="syslogadmin" ;
DELETE FROM db WHERE db="syslog" ;
DELETE FROM host WHERE db="syslog" ;

GRANT SELECT,DELETE,INSERT,UPDATE,LOCK TABLES ON syslog.* TO 'sysloguser'@'localhost' IDENTIFIED BY 'oituser';
GRANT RELOAD ON *.* TO sysloguser IDENTIFIED BY 'password';
GRANT ALL ON syslog.* TO 'syslogadmin'@'localhost' IDENTIFIED BY 'password';
GRANT RELOAD ON *.* TO 'syslogadmin'@'localhost' IDENTIFIED BY 'password';
GRANT USAGE ON *.* TO syslogadmin IDENTIFIED BY 'password';

FLUSH PRIVILEGES;
COMMIT;
