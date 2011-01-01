# File managed by Puppet <%= puppetversion %> on <%= fqdn %>
CREATE DATABASE IF NOT EXISTS <%= cacti_mysqldbname %>;
GRANT ALL PRIVILEGES ON `<%= cacti_mysqldbname %>`.* TO '<%= cacti_mysqluser %>'@'localhost' IDENTIFIED BY '<%= cacti_mysqlpassword %>';
FLUSH PRIVILEGES ;
