class mysql {
  include stdlib
  include mysql::params

  anchor { 'mysql::begin': }
  -> class { 'mysql::package': }
  -> class { 'mysql::config': }
  -> class { 'mysql::service' : }
  -> anchor { 'mysql::end': }
}
