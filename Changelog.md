# db2 changelog

## v.0.1.3
+ Added DBINSTANCE env variable to default bash profile.
+ Changed systemd unit file to forking type.
+ Added systemd_service_accounting parameter.
+ Changed default service name to match instance name.
+ Disabled db2 fault manager daemon in favor of using systemd.
+ Fixed false error when testing this module with Vagrant.

## v0.1.2
+ Added db2 bin directory to default path.
+ Fixed systemd unit file.
+ Added ksh package for adm scripts.

## v.0.1.1
+ Updated metadata.json to indicate that puppetlabs-stdlib 4.13.0 is required.

## v.0.1.0
+ Initial version.
