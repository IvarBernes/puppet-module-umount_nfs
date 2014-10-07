# == Class: umount_nfs
#
# Unmounts specified mount point and optionally kills processes making it busy.
#
class umount_nfs (
  $mount_points = undef,
  $kill_procs   = false,
  $hiera_merge  = true,
){
  case $::osfamily {
    'RedHat': {
      case $::lsbmajdistrelease {
        '5','6': {
          #noop
        }
        default: {
          fail("The umount_nfs module is supported by release 5 and 6 of the RedHat Family. Your release is ${::lsbmajdistrelease}.")
        }
      }
    }
    'Suse': {
      case $::lsbmajdistrelease {
        '10','11': {
          #noop
        }
        default: {
          fail("The umount_nfs module is supported by release 10 and 11 of the Suse Family. Your release is ${::lsbmajdistrelease}.")
        }
      }
    }
    'Debian': {
      case $::lsbdistrelease {
        '12.04','14.04': {
          #noop
        }
        default : {
          fail("The umount_nfs module is supported by LTS release 12.04 and 14.04 of the Ubuntu Family. Your release is ${::lsbdistrelease}.")
        }
      }
    }
    'Solaris': {
      case $::kernelrelease {
        '5.10': {
          #noop
        }
        default: {
          fail("The umount_nfs module supports Solaris kernel release 5.10. You are running ${::kernelrelease}.")
        }
      }
    }
    default: {
      fail("The umount_nfs module is supported by the Redhat, Suse, Solaris and Ubuntu Families. Your Family is ${::osfamily}.")
    }
  }
  
  $hiera_merge_bool = type($hiera_merge) ? {
    'String' => str2bool($hiera_merge),
    default  => $hiera_merge,
  }
  validate_bool($hiera_merge_bool)

  $kill_procs_bool = type($kill_procs) ? {
    'String' => str2bool($kill_procs),
    default  => $kill_procs,
  }
  validate_bool($kill_procs_bool)
  
  if $mount_points != undef {
    if $hiera_merge_bool == true {
      $mount_points_real = hiera_array('umount_nfs::mount_points')
    } else {
      $mount_points_real = unique($mount_points)
    }
    validate_array($mount_points_real)
    umount_nfs::umount {$mount_points_real:
      with_fuser => $kill_procs_bool,
    }
  }
}
