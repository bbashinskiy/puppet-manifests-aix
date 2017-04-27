class syslog::aix_config {
	file { 
		'/etc/syslog.conf':
                ensure 	=> present,
		owner	=> "root",
		group	=> "system",
		mode	=> "644",
		source  => "puppet:///modules/syslog/syslog.conf";

		'/etc/syslog-ng':
		ensure => directory,
		owner   => "root",
                group   => "system",
                mode    => "755";


		'/etc/syslog-ng/syslog-ng.conf':
                ensure  => present,
                owner   => "root",
                group   => "system",
                mode    => "644",
                source  => "puppet:///modules/syslog/syslog-ng.conf",
        }
	
	
}

class syslog::aix_service {
	/*file_line { 'enable syslogd service':
                path  => '/etc/rc.tcpip',
                line  => 'start /usr/sbin/syslogd "$src_running"',
        }*/
}

class syslog {
        include syslog::aix_config, syslog::aix_service
	Class['syslog::aix_config'] ~> Class['syslog::aix_service']
}
