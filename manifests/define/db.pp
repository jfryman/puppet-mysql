define mysql::define::db(
  $username,
  $password,
  $backup = 'false'
) {
  include mysql

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  exec { "create-${name}-mysql-db":
    unless  => "mysql ${name} -u${username} -p${password}",
    command => "mysql -uroot -p${mysql::params::ml_root_password} -e \"create database ${name}; grant all on ${name}.* to ${username}@localhost identified by '${password}';\"",
    require => Service["mysql"],
  }

  # Do backups if requested
  if $backup == 'true' {
    mysql::define::backup { $name: }
  }
}
