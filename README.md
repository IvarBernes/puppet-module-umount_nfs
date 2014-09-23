# umount_nfs
===

Puppet module for unmounting nfs shares and optionally kill any process using these shares.

Will try to unmount the resource given to it, but will fail if the resource is "busy" unless the 'killprocs' parameter is set to 'true', since it will then first kill any processes making the resource busy.


===

# Parameters
------------

arealist
--------------
String or array listing the NFS shares that is going to be unmounted.

- *Default*: undef

killprocs
------------
Boolean that indicate if processes making the share busy should be killed or not.

- *Default*: false

===

# Defines

## `umount_nfs::umount`
The title must be a full path to a nfs share, for example: /proj/area

### Parameters required or with defaults

fuser
-----
Boolean that indicate if processes making the share busy should be killed or not.

- *Default*: false


===

# Hiera

## Example:
<pre>
umount_nfs::killprocs: "true"
umount_nfs::arealist:
  - "/proj/some_area/"
  - "/proj/some_other_area/"
  - "/test/mnt/"
</pre>
