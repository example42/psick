# This class installs and configures via tp the gitlab-cli tool, used to
# compare Puppet catalogs from different sources
#
# @param ensure Define if to install (present), remove (absent) or the version
#               of the gitlab-cli gem
# @param auto_prerequisites Define if to automatically install the prerequisites
#                           needed by gitlab-cli
# @param template The path of the erb template (as used in template()) to use
#                 as content for the gitlab-cli configuration file. Note that
#                 this file is not a real official file for gitlab-cli, but just
#                 a fie where are exported the needed environment variables.
# @param options An open hash of options you can use in your template. Note that
#                this hash is merged with an hash of default options provided in
#                the class
#
class profile::gitlab::cli (
  String           $ensure,
  Boolean          $auto_prerequisites,
  Optional[String] $template,
  Hash             $config_hash,

) {

  ::tp::install { 'gitlab-cli' :
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }
  if $template {
    file { '/etc/gitlab-cli.conf':
      ensure  => $ensure,
      content => epp($template),
    }
  }

}
