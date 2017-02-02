#
class profile::nfs::client () {

  tp::install { 'nfs-client': }

}
