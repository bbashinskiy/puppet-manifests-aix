class xinet::install {
	package { "xinetd":
		ensure => present
	}
}

class xinet::service {
	service { "xinetd":
		ensure => running,
                enable => true
        }
}

class xinet::config {
	file { 
		'/etc/xinetd.conf':
                	ensure 	=> present,
			owner	=> "root",
			group	=> "root",
			mode	=> "644",
			source  => "puppet:///modules/xinet/xinetd.conf";

		'/etc/xinet.d':
			ensure  => directory,
                	owner   => "root",
                	group   => "root",
                	mode    => "755",
			recurse => true,
        		purge   => true;
		
		'/etc/xinetd.d/chargen-dgram':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/chargen-dgram";

		'/etc/xinetd.d/daytime-dgram':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/daytime-dgram";

		'/etc/xinetd.d/discard-dgram':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/discard-dgram";

		'/etc/xinetd.d/echo-dgram':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/echo-dgram";

		'/etc/xinetd.d/rsync':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/rsync";

		'/etc/xinetd.d/time-dgram':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/time-dgram";

		'/etc/xinetd.d/chargen-stream':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/chargen-stream";

		'/etc/xinetd.d/daytime-stream':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/daytime-stream";

		'/etc/xinetd.d/discard-stream':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/discard-stream";

		'/etc/xinetd.d/echo-stream':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/echo-stream";

		'/etc/xinetd.d/tcpmux-server':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/tcpmux-server";

		'/etc/xinetd.d/time-stream':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/xinet/time-stream";
        }
}

class xinet {
        include xinet::install, xinet::config, xinet::service
	Class['xinet::install'] -> Class['xinet::config'] ~> Class['xinet::service']
}
