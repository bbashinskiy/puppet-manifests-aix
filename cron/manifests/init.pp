class cron::config {
  file {
    ['/var/spool/cron','/var/spool/cron/crontabs']:
      ensure => directory,
      owner  => 'bin',
      group  => 'cron',
      mode   => 755;

    '/var/spool/cron/crontabs/adm':
      ensure => present,
      owner  => 'adm',
      group  => 'cron',
      mode   => 644,
      source => 'puppet:///modules/cron/adm';

    '/var/spool/cron/crontabs/esaadmin':
      ensure => present,
      owner  => 'esaadmin',
      group  => 'cron',
      mode   => 644,
      source => 'puppet:///modules/cron/esaadmin';
    
    '/var/spool/cron/crontabs/root':
      ensure => present,
      owner  => 'root',
      group  => 'cron',
      mode   => 600,
      source => 'puppet:///modules/cron/root';

    '/var/spool/cron/crontabs/sys':
      ensure => present,
      owner  => 'sys',
      group  => 'cron',
      mode   => 644,
      source => 'puppet:///modules/cron/sys';

    '/var/spool/cron/crontabs/uucp':
      ensure => present,
      owner  => 'root',
      group  => 'cron',
      mode   => 644,
      source => 'puppet:///modules/cron/uucp';
    }
}

class cron::service {
  /*file_line { 'enable syslogd service':
    path => '/etc/inittab',
    line => 'cron:23456789:respawn:/usr/sbin/cron',
  }*/
} 

class cron {
    include cron::config, cron::service
    Class['cron::service'] ~> Class['cron::config']
}
