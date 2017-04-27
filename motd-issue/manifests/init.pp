class motd-issue::config {
	file {
		'/etc/issue':
		ensure => present,
		mode => '644',
		owner => 'root',
		group => 'root',
		source => 'puppet:///modules/motd-issue/motd';
		
		'/etc/motd':
                ensure => present,
                mode => '644',
                owner => 'root',
                group => 'root',
                source => 'puppet:///modules/motd-issue/issue',
	}
}

class motd-issue {
	include motd-issue::config
}
