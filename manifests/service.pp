# Class db2::service
# ===================================
#
# This class is meant to be called from db2.
# It ensure the service is running.
#
class db2::service {
  assert_private()

  # Create systemd unit file.
  file{'/etc/systemd/system/db2fmcd.service':
    content => template('db2/db2fmcd.service'),
    mode    => '0644',
    notify  => Exec['db2_reload_units'],
  }
  exec{'db2_reload_units':
    command     => 'systemctl daemon-reload',
    provider    => 'shell',
    refreshonly => true,
  }
  ~> service{'db2fmcd':
    ensure  => running,
    enable  => true,
    require => Exec['install_db2'],
  }
}
