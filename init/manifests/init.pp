class init::config {
	file {
		'/etc/rc.d':
          ensure => directory,
		      mode => 'g-w,o-w',
		      owner => 'root',
          group => "system",
		      recurse => true;

		'/etc/inittab':
          ensure => present,
		      owner => 'root',
		      group => "system",
          mode => 'g-w,o-w',
		      source  => "puppet:///modules/init/aix_inittab";

		'/etc/init.d':
    		  ensure => 'link',
    		  target => '/etc/rc.d/init.d',
  }
	
	file { '/etc/inetd.conf':
			    ensure => present,
          owner => 'root',
          group => "system",
          mode => '600',
          source  => "puppet:///modules/init/inetd.conf",
		}
}

class init {
	include init::config
}
