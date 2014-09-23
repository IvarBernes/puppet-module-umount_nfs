# puppet-module-umount_nfs
# kills processes using a specified area and then unmounts that area.

class puppet-module-umount_nfs (
  $arealist = undef,
  $killprocs = undef,
){
  $mountpoint = hiera_array("puppet-module-umount_nfs::arealist", undef)
  $bool_killprocs = type($killprocs) ? {
    'String' => str2bool($killprocs),
    default  => $killprocs,
  }
  
  puppet-module-umount_nfs::umount {$mountpoint:
    fuser => $bool_killprocs,
  }
}
