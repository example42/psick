# Custom project nagios classes

class nagios::example42 inherits nagios {
}

class nagios::example42::client inherits nagios::client {
}

class nagios::example42::server inherits nagios::server {
}

class nagios::example42::monitor inherits nagios::monitor {
}

