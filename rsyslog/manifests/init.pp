class rsyslog::install {
	package { "rsyslog":
		ensure => present
	}

	package { "syslog-ng":
                ensure => absent
        }
}

class rsyslog::service {
	service { "rsyslog":
		ensure => running,
                enable => true
        }
	
	service { "syslog-ng":
                ensure => stopped,
                enable => false
        }
}

class rsyslog::config {
	file { 
		'/etc/rsyslog.conf':
                	ensure 	=> present,
			owner	=> "root",
			group	=> "root",
			mode	=> "644",
			source  => "puppet:///modules/rsyslog/rsyslog.conf";

		'/etc/rsyslog.d':
			ensure  => directory,
                	owner   => "root",
                	group   => "root",
                	mode    => "755",
			recurse => true,
        		purge   => true,
        }
}

class rsyslog {
        include rsyslog::install, rsyslog::config, rsyslog::service
	Class['rsyslog::install'] -> Class['rsyslog::config'] ~> Class['rsyslog::service']
}
