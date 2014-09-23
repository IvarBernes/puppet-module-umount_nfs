# Defines a resource that kills processes and unmounts areas supplied via an array
# exec fuser -> returns ["0","1"] due to that fuser exits with 1 if there are no processes to kill.

define puppet-module-umount_nfs::umount (
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
