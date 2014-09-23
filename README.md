# puppet-module-umount_nfs
===

Puppet module for unmounting nfs shares and optionally kill any process using these shares.

===

# Compatibility
---------------
-

===

# Parameters
------------

arealist
--------------
Array listing the NFS shares that is going to be unmounted.

- *Default*: undef

killprocs
------------
Boolean to indicate if processes should be killed or not.

- *Default*: false
