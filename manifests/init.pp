# puppet-module-umount_nfs
# kills processes using a specified area and then unmounts that area.

class puppet-module-umount_nfs (
  $mountpoint = undef,
){
  $arealist = hiera_array("puppet-module-umount_nfs::mountpoint", undef)
  puppet-module-umount_nfs::iterate {$arealist:}
}
