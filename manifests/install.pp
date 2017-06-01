# Class db2::install
# ===================================
#
# This class is called from db2 for install.
#
# class db2::install {
#   assert_private()
#
#   package { $::db2::package_name:
#     ensure => present,
#   }
# }
# Class: profile::db2
# ===========================
#
# Configure db2 module
class db2::install {

  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::instance_name,
    ['^[a-zA-Z0-9]{1,8}$']
  )
  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::instance_user,
    ['^[a-zA-Z0-9]{1,8}$'] #CHAR(8) && !/w
  )
  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::instance_group,
    ['^[a-zA-Z0-9]{1,30}$'] #CHAR(30) && !/w
  )
  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::fenced_user,
    ['^[a-zA-Z0-9]{1,8}$'] #CHAR(8) && !/w
  )
  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::fenced_group,
    ['^[a-zA-Z0-9]{1,30}$'] #CHAR(30) && !/w
  )
  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::installer_source_dir,
    ['(?<!\/)$'] # Must not end in trailing slash
  )
  validate_legacy(
    Optional[String],
    'validate_re',
    $db2::installer_target_dir,
    ['(?<!\/)$'] # Must not end in trailing slash
  )

  # If we're not in vagrant, then assert that our passwords aren't 'vagrant'.
  if $::is_vagrant != 'true' { # lint:ignore:quoted_booleans
    validate_legacy(Optional[String], 'validate_re', $db2::instance_user_password, ['^(?!vagrant$).*$'])
    validate_legacy(Optional[String], 'validate_re', $db2::fenced_user_password, ['^(?!vagrant$).*$'])
    validate_legacy(Optional[String], 'validate_re', $db2::password_salt, ['^(?!vagrant$).*$'])
    # TODO: installer_source_dir != *vagrant*
  }

  # Notes: https://bernhard.hensler.net/ibm-db2-install-uninstall-update/
  # TODO: (Long-term) Break instances to def at profile::db2::instance.

  # Groups
  group{$db2::instance_group:
    gid => $db2::instance_group_gid,
  }
  group{$db2::fenced_group:
    gid => $db2::fenced_group_gid,
  }
  group{$db2::instance_user:
    gid => $db2::instance_user_uid,
  }
  group{$db2::fenced_user:
    gid => $db2::fenced_user_uid,
  }

  # Users
  user{$db2::fenced_user:
    uid      => $db2::fenced_user_uid,
    groups   => $db2::fenced_group,
    shell    => $db2::fenced_user_shell,
    password => pw_hash($db2::fenced_user_password,'sha-512', $db2::password_salt),
    comment  => 'db2 fenced user',
    home     => $db2::fenced_user_home,
    require  => Group[$db2::fenced_group],
  }

  user{$db2::instance_user:
    uid      => $db2::instance_user_uid,
    groups   => $db2::instance_group,
    shell    => $db2::instance_user_shell,
    password => pw_hash($db2::instance_user_password,'sha-512', $db2::password_salt),
    comment  => 'instance user',
    home     => $db2::instance_user_home,
    require  => Group[$db2::instance_group],
  }

  file{$db2::instance_user_home:
    ensure  => directory,
    owner   => $db2::instance_user,
    group   => $db2::instance_group,
    require => User[$db2::instance_user],
  }

  file{$db2::fenced_user_home:
    ensure  => directory,
    owner   => $db2::fenced_user,
    group   => $db2::fenced_group,
    require => User[$db2::fenced_user],
  }

  # DB2 response file
  $db2_response_file_path = "${db2::installer_source_dir}/exp/db2exp.rsp"
  file{$db2_response_file_path:
    content => template('db2/db2exp.rsp.erb'),
  }

  # Install db2
  $exec_cmd_install_db2 = "${db2::installer_source_dir}/exp/db2setup -r ${db2_response_file_path}"
  $db2ilist_path = "${db2::installer_target_dir}/bin/db2ilist"
  $exec_unless_install_db2 = "${db2ilist_path} | grep -c ${db2::instance_name}"
  exec{'install_db2':
    command  => $exec_cmd_install_db2,
    unless   => $exec_unless_install_db2,
    before   => Service['db2fmcd'],
    provider => 'shell',
    timeout  => $db2::setup_timeout,
    require  => [
      User[$db2::instance_user],
      User[$db2::fenced_user],
      File[$db2::instance_user_home],
      File[$db2::fenced_user_home],
      ],
  }
}
