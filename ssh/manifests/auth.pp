# Fake null class 

class ssh::auth {

define key ($ensure = "present", $filename = "", $force = false, $group = "puppet", $home = "", $keytype = "rsa", $length = 2048, $maxdays = "", $mindate = "", $options = "", $user = "") {

} 


class keymaster {
} # class keymaster


define client ($ensure = "", $filename = "", $group = "", $home = "", $user = "") {
} # define client


define server ($ensure = "", $group = "", $home = "", $options = "", $user = "") {
} # define server

} # class ssh::auth


define ssh_auth_key_master ($ensure, $force, $keytype, $length, $maxdays, $mindate) {

} # define ssh_auth_key_master

define ssh_auth_key_client ($ensure, $filename, $group, $home, $user) {

} # define ssh_auth_key_client

define ssh_auth_key_server ($ensure, $group, $home, $options, $user) {

} # define ssh_auth_key_server


define ssh_auth_key_namecheck ($parm, $value) {
} # define namecheck

