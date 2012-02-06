class mysql::package {
  package { $mysql::params::ml_packages:
    ensure => present
  }
}
