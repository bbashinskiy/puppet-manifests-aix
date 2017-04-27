class nfs::config {
	file {'/etc/resolv.conf':
		ensure => present,
		mode => '644',
		owner => 'root',
		group => 'root',
		source => 'puppet:///modules/nfs/resolv.conf',
		
	}
}

class nfs {
	include nfs::config
}
