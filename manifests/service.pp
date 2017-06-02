# Class db2::service
# ===================================
#
# This class is meant to be called from db2.
# It ensure the service is running.
#
class db2::service {
  assert_private()

  # Create systemd unit file.
  file{"/etc/systemd/system/${db2::instance_name}.service":
    content => template('db2/db2inst1.service.erb'),
    mode    => '0644',
    notify  => Exec['db2_reload_units'],
  }

  exec{'db2_reload_units':
    command     => 'systemctl daemon-reload',
    provider    => 'shell',
    refreshonly => true,
  }
  ~> service{$db2::instance_name:
    ensure  => running,
    enable  => true,
    require => Exec["install_db2_${db2::instance_name}"],
  }

  Exec<| name == 'db2_reload_units' |> -> Service<| name == $db2::instance_name |>
}
