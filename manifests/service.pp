# Class db2::service
# ===================================
#
# This class is meant to be called from db2.
# It ensure the service is running.
#
class db2::service {
  assert_private()

  # service { $::db2::service_name:
  #   ensure     => running,
  #   enable     => true,
  #   hasstatus  => true,
  #   hasrestart => true,
  # }
}
