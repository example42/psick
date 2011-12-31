class example42::role::foreman {
    $role="foreman"
    $puppet_server_local = true
$puppet_storeconfigs = "yes"
$puppet_db = "mysql"
$puppet_db_server = "localhost"
$puppet_db_user = "puppet"
$puppet_db_password = "mys3cr3tp4ss0rd"
$puppet_allow = [ "*.example42.com" , "10.42.20.*" ]
$puppet_nodetool = "foreman"
# $puppet_externalnodes = "no"

    include example42::role::general

}
