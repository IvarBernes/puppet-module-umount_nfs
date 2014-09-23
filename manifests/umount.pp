# == Type: umount_nfs::umount
#
# This type performs umount of a given nfs share and exec:s fuser to kill processes using that area.
#
define umount_nfs::umount (
  $fuser = false,
) {
  $bool_fuser = type($fuser) ? {
    'String' => str2bool($fuser),
    default  => $fuser,
  }
  if $bool_fuser == true {
    if ! defined(Exec["fuser-$title"]) {
      exec { "fuser-$title" :
        command  => "fuser -k $title",
        path     => ["/sbin", "/usr/sbin"],
        returns  => ["0","1"],
        before   => Mount["umount-$title"],
      }
    }
  }
  if ! defined(Mount["umount-$title"]) {
    mount { "umount-$title" :
      name    => $title,
      ensure  => 'absent',
    }
  }
}
