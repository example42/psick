# This class automatically includes ::psick::hardware::hp on HP servers
#
class psick::hardware {

  if $::manufacturer == 'HP' { contain ::psick::hardware::hp }

}
