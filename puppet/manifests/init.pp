class puppet::params {
	$puppetserver = "dee1ans013ccpra.cmsalz.ibm.allianz"
}

class puppet::lnx_install {
	package {"puppet":
		ensure => present,
	}
}

class puppet::lnx_config {
	include puppet::params
		
	file { "/etc/puppet/puppet.conf":
		ensure => present,
		content => template("puppet/puppet.conf.erb"),
		owner => "root",
		group => "root",
		mode    => "644",
	}
	
	file { "/etc/puppet/auth.conf":
                ensure => present,
                owner => "root",
                group => "root",
		mode	=> "644",
		source	=> "puppet:///modules/puppet/auth.conf"
        }
	
	file { "/etc/rsyslog.d/puppet.conf":
                ensure => present,
                owner => "root",
                group => "root",
                mode    => "644",
                source  => "puppet:///modules/puppet/puppet-syslog"
        }
	
	file { "/etc/logrotate.d/puppet":
		ensure	=> present,
		owner	=> "root",
		group	=> "root",
		mode	=> "644",
		source	=> "puppet:///modules/puppet/puppet-logrotate"
	}
	/*
	file_line { 'add pupssh user under protection from erec ldap':
                path  => '/opt/eregldap/uar/configure/protectedid.dat',
                line  => 'pupssh',
        }

	file_line { 'add ip and host name of puppet server to /etc/hosts':
                path  => '/etc/hosts',
                line  => '10.17.163.175 dee1ans013ccpra.cmsalz.ibm.allianz dee1ans013ccpra',
        }
	*/
}

class puppet::aix_config {
	include puppet::params

	file { 
		'/etc/puppetlabs/puppet/puppet.conf':
		ensure => present,
		content => template('puppet/puppet.conf.erb'),
		owner => "root",
		group => "system",
		mode    => "644";

		"/etc/rc.d/init.d/puppet_agentd":
                ensure => present,
                owner => "root",
                group => "system",
		mode => 755,
		source => "puppet:///modules/puppet/puppet-agentd";

		'/etc/init.d/puppet':
                ensure => "/etc/rc.d/init.d/puppet_agentd";

		'/usr/bin/puppet':
                ensure => "/opt/puppet/bin/puppet",
        }
	/*
	file_line { 'add pupssh user under protection from erec ldap':
  		path  => '/opt/eregldap/uar/configure/protectedid.dat',
  		line  => 'pupssh',
	}

	file_line { 'add ip and host name of puppet server to /etc/hosts':
                path  => '/etc/hosts',
                line  => '10.17.163.175 dee1ans013ccpra.cmsalz.ibm.allianz dee1ans013ccpra',
        }
	*/
}

class puppet::puppetssh {
        group { 'pupssh':
                          ensure => 'present',
                          gid    => '2222',
        }

	if $operatingsystem == 'RedHat' {
		user { 'pupssh':
			ensure           => 'present',
                	gid              => '2222',
                	home             => '/home/pupssh',
                	password         => '!!',
                	password_max_age => '99999',
                	password_min_age => '0',
                	uid              => '2222',
                        shell            => '/bin/bash',
		}
        } elsif $operatingsystem == 'AIX' {
		user { 'pupssh':
			ensure           => 'present',
                	gid              => '2222',
                	home             => '/home/pupssh',
                	password         => '!!',
                	password_max_age => '99999',
                	password_min_age => '0',
                	uid              => '2222',
                        shell            => '/bin/sh',
		}
        }

        file {
                '/home/pupssh':
                ensure => directory,
                owner => '2222',
                group => '2222';

                '/home/pupssh/.ssh':
                ensure => directory,
                owner => '2222',
                group => '2222',
                mode => 700;

                '/home/pupssh/.ssh/authorized_keys':
                ensure => present,
                owner => '2222',
                group => '2222',
                mode => 600,
                source => 'puppet:///modules/puppet/id_rsa.pub';
        }
}

class puppet::lnx_service {
	service { "puppet":
		ensure => running,
		enable => true,
	}
}

class puppet::aix_service {
	exec {"enable puppet service":
		command => "ln -s /etc/rc.d/init.d/puppet_agentd /etc/rc.d/rc2.d/Spuppet_agentd",
        	logoutput => "on_failure",
        	path => "/bin",
        	unless => 'ls -la /etc/rc.d/rc2.d/Spuppet_agentd',
	}

	service { "puppet":
		ensure => running,
		provider => init,
	}
}


class puppet {
	if $operatingsystem == 'RedHat' {
		include puppet::puppetssh, puppet::lnx_install, puppet::lnx_config, puppet::lnx_service
		Class['puppet::lnx_install'] -> Class['puppet::puppetssh'] -> Class['puppet::lnx_config'] ~> Class['puppet::lnx_service']
	} elsif $operatingsystem == 'AIX' {
		include puppet::puppetssh, puppet::aix_config, puppet::aix_service
		Class['puppet::puppetssh'] -> Class['puppet::aix_config'] ~> Class['puppet::aix_service'] 
	}
}
