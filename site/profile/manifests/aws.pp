#
class profile::aws (
  String $setup_class        = '::profile::aws::setup',
  String $autoscaling_class  = '',
  String $ec2_class        = '',
) {

  if $setup_class and $setup_class != '' {
    include $setup_class
    contain $setup_class
  }
  if $autoscaling_class and $autoscaling_class != '' {
    contain $autoscaling_class
  }
  if $ec2_class and $stack_class != '' {
    contain $ec2_class
  }
  
}
