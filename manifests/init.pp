# == Class: umount_nfs
#
# Unmounts NFS shares and optionally kills processes using those shares.
#
class umount_nfs (
  $arealist = undef,
  $killprocs = undef,
){
  $mountpoint = hiera_array("umount_nfs::arealist", undef)
  $bool_killprocs = type($killprocs) ? {
    'String' => str2bool($killprocs),
    default  => $killprocs,
  }
  
  umount_nfs::umount {$mountpoint:
    fuser => $bool_killprocs,
  }
}
