class oracle::params  {

# Basic settings
$user = "oracle"

#  Primary group for user
$group = "oinstall" 

#  Secondary groups for user
$groups = "dba" 
# $groups = ["dba","asmadmin"]

# Oracle Base
$oraclebase = "/u01/app/oracle" 

# Work dir (used by Puppet). Be sure that it already exists
$workdir = "/var/tmp"

$version = $oracle_version ? {
    "11"    => "11.2.0",
    "10"    => "10.2.0",
    "9"    => "9.2.0",
    default => "11.2.0",
}

$sid = $oracle_sid ? {
    ""    => "ORC1",
    default => "$oracle_sid",
}

# Default password for oracle user is "oracle"
$password = $oracle_password ? {
    ""    => '$1$KRXrbDA9$bCW48X6Z8lxjbCF9zan8V1', 
    default => "$oracle_password",
}

}
