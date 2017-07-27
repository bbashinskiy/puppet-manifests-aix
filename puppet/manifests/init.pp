class puppet::params {
	$puppetserver = "dee1ans013ccpra.cmsalz.ibm.allianz"
}

class puppet::config {
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

class puppet::service {
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
		include puppet::puppetssh, puppet::config, puppet::service
		Class['puppet::puppetssh'] -> Class['puppet::config'] ~> Class['puppet::service'] 
}
