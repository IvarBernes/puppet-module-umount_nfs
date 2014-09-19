# Defines a resource that kills processes and unmounts areas supplied via an array
# exec fuser -> returns ["0","1"] due to that fuser exits with 1 if there are no processes to kill.

define puppet-module-umount_nfs::iterate (
) {
  if ! defined(Exec["fuser-$title"]) {
    exec { "fuser-$title" :
      command  => "fuser -k $title",
      path     => ["/sbin", "/usr/sbin"],
      returns  => ["0","1"],
      before   => Mount["unmount-$title"],
    }
  }
  if ! defined(Mount["unmount-$title"]) {
    mount { "unmount-$title" :
      name    => $title,
      ensure  => 'absent',
    }
  }
}
