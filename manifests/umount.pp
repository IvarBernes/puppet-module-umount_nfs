# == umount_nfs::umount
#
# This performs umount on given mount point and optionally exec:s fuser to kill processes using that area.
#
define umount_nfs::umount (
  $with_fuser = false,
) {
  $with_fuser_bool = is_string($with_fuser) ? {
    true => str2bool($with_fuser),
    default  => $with_fuser,
  }
  validate_bool($with_fuser_bool)

  if $with_fuser_bool == true {
    exec { "umount_with_fuser-${title}" :
      command => "fuser -k ${title}",
      path    => ['/bin', '/sbin', '/usr/sbin'],
      returns => ['0','1'],
      before  => Mount["umount-${title}"],
    }
  }
  mount { "umount-${title}" :
    ensure => 'absent',
    name   => $title,
  }
}
