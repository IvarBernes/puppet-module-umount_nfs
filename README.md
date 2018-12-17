# umount_nfs
===

Puppet module for unmounting nfs shares and optionally kill any process using these shares.

It will try to unmount the resource given to it, but will fail if the resource is "busy" unless the 'kill_procs' parameter is set to 'true', since it will then first kill (SIGKILL) any processes making the resource busy. Also, the moint point will be removed from the fstab if it is listed there.

===


# Compatibility
---------------
This module has been tested to work on the following systems with Puppet v3 (with and without the future parser, ruby 1.8.7, 1.9.3, 2.0.0 and 2.1.9) and Puppet v4 (2.1.9)

 * CentOS 6
 * RHEL 5
 * RHEL 6
 * SLES 10
 * SLES 11
 * Solaris 10
 * Ubuntu 12.04 LTS
 * Ubuntu 14.04 LTS

Since it is a quite basic module, no issues are expected in these OS families and no check for untested OS families or releases is performed.

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
umount_nfs::kill_procs: 'true'
umount_nfs::hiera_merge: 'true'
umount_nfs::mount_points:
  - '/proj/some_area'
  - '/proj/some_other_area'
  - '/test/mnt'
</pre>

