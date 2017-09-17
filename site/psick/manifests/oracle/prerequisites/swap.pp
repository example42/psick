#
class psick::oracle::prerequisites::swap (

  String $dev_shm_size                      = '3500m',
  String $swapfile_path                     = '/var/swap.1',
  String $swapfile_size                     = '2560MB',
  Enum['present','absent'] $swapfile_ensure = present,
  Boolean $swapfile_mount                      = true,
  String $swapfile_options                  = 'defaults',

) {

  mount { '/dev/shm':
    ensure  => present,
    atboot  => true,
    device  => 'tmpfs',
    fstype  => 'tmpfs',
    options => "size=${dev_shm_size}",
  }

  ::swap_file::files { $swapfile_path:
    ensure       => $swapfile_ensure,
    swapfile     => $swapfile_path,
    swapfilesize => $swapfile_size,
    add_mount    => $swapfile_mount,
    options      => $swapfile_options,
  }

}
