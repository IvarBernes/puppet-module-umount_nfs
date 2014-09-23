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
Boolean to indicate if processes should be killed or not.

- *Default*: false

===

# Defines

## `umount_nfs::umount`


### Parameters required or with defaults

fuser
-----
Boolean to indicate if processes should be killed or not.

- *Default*: false
