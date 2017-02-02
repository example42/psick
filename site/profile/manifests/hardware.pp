# This class automatically includes ::profile::hardware::hp on HP servers
#
class profile::hardware {

  if $::manufacturer == 'HP' { contain ::profile::hardware::hp }

}
