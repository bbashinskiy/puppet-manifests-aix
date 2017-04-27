class cron::lnx_install {
	package {"crontabs":
		ensure => present,
	}
}

class cron::lnx_config {
	file {
		'/etc/crontab':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 644,
                source => 'puppet:///modules/cron/crontab';
		
		['/etc/cron.d','/etc/cron.daily','/etc/cron.hourly','/etc/cron.monthly','/etc/cron.weekly']:
                ensure => directory,
                owner => 'root',
                group => 'root',
                mode => 755;
		
		'/etc/cron.d/0hourly':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 644,
                source => 'puppet:///modules/cron/0hourly';
		
		'/etc/cron.d/raid-check':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => 'puppet:///modules/cron/raid-check';

		'/etc/cron.d/sysstat':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => 'puppet:///modules/cron/sysstat';

		'/etc/cron.daily/logcontrols':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 740,
                source => 'puppet:///modules/cron/logcontrols';
	
		'/etc/cron.daily/makewhatis.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/makewhatis.cron';

		'/etc/cron.daily/mlocate.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/mlocate.cron';

		'/etc/cron.daily/prelink':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/prelink';
		
		'/etc/cron.daily/readahead.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/readahead.cron';

		'/etc/cron.daily/rhsmd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 700,
                source => 'puppet:///modules/cron/rhsmd';

		'/etc/cron.daily/tmpwatch':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/tmpwatch';

		'/etc/cron.hourly/0anacron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/0anacron';

		'/etc/cron.monthly/readahead-monthly.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/readahead-monthly.cron';

		'/etc/cron.deny':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => 'puppet:///modules/cron/cron.deny';
        }
}

class cron::aix_config {
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

class cron::lnx_service {
	service { "crond":
		ensure => running,
		enable => true,	
	}
}

class cron::aix_service {
  /*file_line { 'enable syslogd service':
    path => '/etc/inittab',
    line => 'cron:23456789:respawn:/usr/sbin/cron',
  }*/
} 

class cron {
  if $operatingsystem == 'RedHat' {
	  include cron::lnx_install, cron::lnx_config, cron::lnx_service
  	Class['cron::lnx_install'] -> Class['cron::lnx_config'] ~> Class['cron::lnx_service']
  } elsif $operatingsystem == 'AIX' {
    include cron::aix_config, cron::aix_service
    Class['cron::aix_service'] ~> Class['cron::aix_config']
  }
}
