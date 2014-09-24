# == umount_nfs::umount
#
# This performs umount on given mount point and optionally exec:s fuser to kill processes using that area.
#
define umount_nfs::umount (
  $with_fuser = false,
) {
  $with_fuser_bool = type($with_fuser) ? {
    'String' => str2bool($with_fuser),
    default  => $with_fuser,
  }
  if $with_fuser_bool == true {
    exec { "umount_with_fuser-$title" :
      command  => "fuser -k $title",
      path     => ["/sbin", "/usr/sbin"],
      returns  => ["0","1"],
      before   => Mount["umount-$title"],
    }
  }
  mount { "umount-$title" :
    name    => $title,
    ensure  => 'absent',
  }
}
