class mysql::params {
  $ml_root_password = password_lookup('frymanet-db-root')

  case $::operatingsystem {
    ubuntu,debian: {
      $ml_packages = [ 'libdbd-mysql-perl', 'libdbi-perl', 'libhtml-template-perl',
                       'libmysqlclient16', 'libnet-daemon-perl', 'libplrpc-perl',
                       'mysql-client-5.1', 'mysql-common',
                       'mysql-server', 'mysql-server-5.1', 'mysql-server-core-5.1',
        ]
      $ml_mysql_conf = '/etc/mysql/my.cnf'
    }
  }
}
