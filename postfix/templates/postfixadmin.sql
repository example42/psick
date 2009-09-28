# File managed by Puppet <%= puppetversion %> on <%= fqdn %>
CREATE DATABASE <%= postfix_mysqldbname %> ;
CREATE USER '<%= postfix_mysqluser %>'@'localhost' IDENTIFIED BY '<%= postfix_mysqlpassword %>';
GRANT ALL PRIVILEGES ON `<%= postfix_mysqldbname %>` . * TO '<%= postfix_mysqluser %>'@'localhost';
FLUSH PRIVILEGES ;
