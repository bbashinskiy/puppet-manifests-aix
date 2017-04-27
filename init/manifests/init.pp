class init::config {
	$initfname = $operatingsystem ? {
		'RedHat' => 'lnx_inittab',
		'AIX' => 'aix_inittab',
	}

	$groupperm = $operatingsystem ? {
                'RedHat' => 'root',
                'AIX' => 'system',
        }

	file {
		'/etc/rc.d':
                ensure => directory,
		mode => 'g-w,o-w',
		owner => 'root',
                group => "$groupperm",
		recurse => true;

		'/etc/inittab':
                ensure => present,
		owner => 'root',
		group => "$groupperm",
                mode => 'g-w,o-w',
		source  => "puppet:///modules/init/$initfname";

		'/etc/init.d':
    		ensure => 'link',
    		target => '/etc/rc.d/init.d',
        }
	
	if $operatingsystem == 'AIX' {
		file { '/etc/inetd.conf':
			ensure => present,
                	owner => 'root',
                	group => "system",
                	mode => '600',
                	source  => "puppet:///modules/init/inetd.conf",
		}
	}
}

class init {
	include init::config
}
