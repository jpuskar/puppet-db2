# Class: db2
# ===========================
# TODO: Parameter descriptions
# TODO: Tests
#
# Full description of class db2 here.
#
# Parameters
# ----------
#
# * `package_name`
#   (string) Name of package to install. Defaults to OS default name.
#
# * `service_name`
#   (string) Name of the service to start. Defaults to OS default name.
#
# Requires
# --------
#
# * puppetlabs/stdlib >= 4.6
#
class db2 (
  $product                     = 'EXPRESS_EDITION',
  $systemd_service_description = 'DB2V101',
  $instance_name               = 'db2inst1',
  $instance_group              = 'db2iadm1',
  $instance_group_gid          = '4977',
  $instance_user               = 'db2inst1',
  $instance_user_uid           = '4981',
  $instance_user_shell         = '/bin/bash',
  $instance_user_password      = 'vagrant',
  $instance_user_home          = '/home/db2inst1',
  $fenced_group                = 'db2fsdm1',
  $fenced_group_gid            = '4976',
  $fenced_user                 = 'db2sdfe1',
  $fenced_user_uid             = '4978',
  $fenced_user_shell           = '/bin/bash',
  $fenced_user_password        = 'vagrant',
  $fenced_user_home            = '/home/db2sdfe1',
  $password_salt               = 'vagrant',
  $installer_source_dir        = '/vagrant/vagrant',
  $installer_target_dir        = '/opt/ibm/db2/V10.1',
  $install_prereqs             = true,
  ) inherits ::db2::params {

  class { 'db2::install': } ->
  class { 'db2::config': } ~>
  class { 'db2::service': }
}
