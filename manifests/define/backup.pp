define mysql::define::backup(
  $max_age = '2'
) {
  include mysql::params

  File {
    owner => 'root',
    group => 'root', 
    mode  => '0640',
  }

  file { "/etc/cron.daily/mysql-${name}-backup.sh":
    ensure  => file,
    mode    => '0750',
    content => template('mysql/mysql_backup.sh.erb'),
  }
}
