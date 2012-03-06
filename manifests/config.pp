class mysql::config {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  File {
    owner => 'mysql',
    group => 'mysql',
    mode  => '0644',
  }

  file { $mysql::params::ml_mysql_conf:
    ensure  => 'file',
    content => template('mysql/standard_config.mysql.erb'),
  }

  exec { 'set-mysql-root-password':
    unless  => "mysqladmin status -uroot -p${mysql::params::ml_root_password}",
    command => "mysqladmin -uroot password ${mysql::params::ml_root_password}",
  }

  exec { 'setup-mysql-backup-user':
    command => "mysql -uroot -p${mysql::params::ml_root_password} -e 'GRANT SHOW DATABASES, SELECT, LOCK TABLES, RELOAD ON *.* to ${mysql::params::ml_backup_user}@localhost IDENTIFIED BY ${mysql::params::ml_backup_password};'",
    unless  => "mysql -u${mysql::params::ml_backup_user} -p${mysql::params::ml_backup_password} -e 'SHOW DATABASES'",
  }
}
