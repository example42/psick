# File managed by Puppet <%= puppetversion %> on <%= fqdn %>
CREATE USER '<%= mailwatch_mysqluser %>'@'<%= mailwatch_mysqlhost %>' IDENTIFIED BY '<%= mailwatch_mysqlpassword %>';
GRANT ALL PRIVILEGES ON `<%= mailwatch_mysqldbname %>` . * TO '<%= mailwatch_mysqluser %>'@'<%= mailwatch_mysqlhost %>';
FLUSH PRIVILEGES ;
