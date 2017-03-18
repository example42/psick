#
class profile::nfs::server () {

  tp::install { 'nfs-server': }

}
