class sysctl::config {
	file {'/etc/sysctl.conf':
		ensure => present,
		mode => '644',
		owner => 'root',
		group => 'root',
		source => 'puppet:///modules/sysctl/sysctl.conf',
		
	}
}

class sysctl {
	include sysctl::config
}
