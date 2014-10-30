# umount_nfs
===

Puppet module for unmounting nfs shares and optionally kill any process using these shares.

Will try to unmount the resource given to it, but will fail if the resource is "busy" unless the 'kill_procs' parameter is set to 'true', since it will then first kill (SIGKILL) any processes making the resource busy.

===


# Compatibility
---------------
This module is supported on the following systems.

 * CentOS 6
 * RHEL 5
 * RHEL 6
 * SLES 10
 * SLES 11
 * Solaris 10
 * Ubuntu 12.04 LTS
 * Ubuntu 14.04 LTS


# Parameters
------------

mount_points
------------
Array listing the mount points that needs to be unmounted.

- *Default*: undef

kill_procs
----------
Boolean to control if processes making the mount point busy should be killed or not. Note that if set to true, a SIGKILL will be sent to the offending process, thus there is a possibility for data loss!

- *Default*: false

hiera_merge
-----------
Boolean to control merges of all found instances of umount_nfs::mount_points in Hiera.

- *Default*: true

===


# Hiera
-------

## Example:
<pre>
umount_nfs::kill_procs: "true"
umount_nfs::hiera_merge: "true"
umount_nfs::mount_points:
  - "/proj/some_area/"
  - "/proj/some_other_area/"
  - "/test/mnt/"
</pre>
