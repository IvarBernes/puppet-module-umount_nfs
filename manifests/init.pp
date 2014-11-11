# == Class: umount_nfs
#
# Unmounts specified mount point and optionally kills processes making it busy.
#
class umount_nfs (
  $mount_points = undef,
  $kill_procs   = false,
  $hiera_merge  = true,
){
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
