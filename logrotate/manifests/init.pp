class logrotate::install {
	package { "logrotate":
		ensure => present
	}
}

class logrotate::config {
	file {
		'/etc/cron.daily/logrotate':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "700",
                        source  => "puppet:///modules/logrotate/logrotate";

		'/etc/logrotate.conf':
                	ensure 	=> present,
			owner	=> "root",
			group	=> "root",
			mode	=> "644",
			source  => "puppet:///modules/logrotate/logrotate.conf";

		'/etc/logrotate.d':
			ensure  => directory,
                	owner   => "root",
                	group   => "root",
                	mode    => "755",
			recurse => true,
        		purge   => true;

		'/etc/logrotate.d/dracut':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/dracut";

		'/etc/logrotate.d/psacct':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/psacct";

		'/etc/logrotate.d/sssd':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/sssd";

		'/etc/logrotate.d/subscription-manager':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/subscription-manager";

		'/etc/logrotate.d/syslog':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/syslog";

		'/etc/logrotate.d/up2date':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/up2date";

		'/etc/logrotate.d/yum':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/yum";

		'/etc/logrotate.d/btmp':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/btmp";

		'/etc/logrotate.d/wtmp':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/wtmp";

		'/etc/logrotate.d/auth':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/auth";

		'/etc/logrotate.d/secure':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/secure";

		'/etc/logrotate.d/tallylog':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/tallylog";

		'/etc/logrotate.d/sudo':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/logrotate/sudo";
        }
}

class logrotate {
        include logrotate::install, logrotate::config
	Class['logrotate::install'] -> Class['logrotate::config']
}
