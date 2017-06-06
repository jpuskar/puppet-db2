# Class: db2
# ===========================
#
# Full description of class db2 here.
#
# Requires
# --------
#
# * puppetlabs/stdlib >= 4.6
#
class db2 (
  $product                     = 'EXPRESS_EDITION', #for v11 use DB2_SERVER_EDITION
  $systemd_service_description = 'DB2 Instance',
  $systemd_service_accounting  = true,
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
  $installer_source_dir        = '/vagrant/vagrant/v10',
  $installer_target_dir        = '/opt/ibm/db2/V10.1',
  $setup_timeout               = 900,
  $install_ksh                 = true,
  ) {

  class { 'db2::install': }
  ~> class { 'db2::service': }
}
