# puppet-module-umount_nfs
# kills processes using a specified area and then unmounts that area.

class puppet-module-umount_nfs (
  $arealist = undef,
){
  $mountpoint = hiera_array("puppet-module-umount_nfs::arealist", undef)
  puppet-module-umount_nfs::umount {$mountpoint:}
}
