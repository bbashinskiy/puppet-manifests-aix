class syslog::config {
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

class syslog::service {
	/*file_line { 'enable syslogd service':
                path  => '/etc/rc.tcpip',
                line  => 'start /usr/sbin/syslogd "$src_running"',
        }*/
}

class syslog {
        include syslog::config, syslog::service
	Class['syslog::config'] ~> Class['syslog::service']
}
