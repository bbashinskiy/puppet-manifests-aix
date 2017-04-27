class ssh::lnx_install {
	package {"openssh":
		ensure => present,
	}
}

class ssh::config {
	$sshdconfig = $operatingsystem ? {
		'RedHat' => 'lnx_sshd_config',
		'AIX' => 'aix_sshd_config',
	}

	$sshconfig = $operatingsystem ? {
                'RedHat' => 'lnx_ssh_config',
                'AIX' => 'aix_ssh_config',
        }

	$groupperm = $operatingsystem ? {
                'RedHat' => 'root',
                'AIX' => 'system',
        }	

	$fileset = $operatingsystem ? {
                'RedHat' => ['/usr/sbin/sshd','/usr/libexec/openssh/ssh-keysign','/usr/libexec/openssh/sftp-server','/usr/bin/ssh-keyscan','/usr/bin/ssh-agent','/usr/bin/ssh-keygen','/usr/bin/ssh-add','/usr/bin/ssh','/usr/bin/sftp','/usr/bin/scp',],
                'AIX' => ['/applications/ssh/6.60.11.0/bin/ssh-keyscan','/applications/ssh/6.60.11.0/bin/ssh','/applications/ssh/6.60.11.0/libexec/sftp-server','/applications/ssh/6.60.11.0/bin/sftp','/applications/ssh/6.60.11.0/sbin/sshd','/applications/ssh/6.60.11.0/bin/ssh-agent','/applications/ssh/6.60.11.0/bin/ssh-add','/applications/ssh/6.60.11.0/libexec/ssh-keysign','/applications/ssh/6.60.11.0/bin/ssh-keygen','/applications/ssh/6.60.11.0/bin/scp','/applications/ssh/6.60.11.0/libexec/ssh-pkcs11-helper'],
        }
	
	file {
		'/etc/ssh/sshd_config':
                ensure => present,
                owner => 'root',
                group => "$groupperm",
                mode => 600,
                source => "puppet:///modules/ssh/$sshdconfig";

		'/etc/ssh/ssh_config':
                ensure => present,
                owner => 'root',
                group => "$groupperm",
                mode => 644,
                source => "puppet:///modules/ssh/$sshconfig";
		
		$fileset:
                owner   => "root",
                group   => "$groupperm",
                mode    => "g-w,o-w",
	}
}

class ssh::lnx_service {
	service { "sshd":
		ensure => running,
		enable => true,
	}
}

class ssh::aix_service {
	/*file_line { 'enable sshd service':
                path  => '/etc/rc.tcpip',
                line  => 'start /applications/ssh/CURRENT/sbin/opensshd "$src_running"',
        }*/

        service { "opensshd":
                ensure => running,
        }
}

class ssh {
	if $operatingsystem == 'Linux' {
		include ssh::lnx_install, ssh::config, ssh::lnx_service
		Class['ssh::lnx_install'] -> Class['ssh::config'] ~> Class['ssh::lnx_service']
	} elsif $operatingsystem == 'AIX' {
		include ssh::config, ssh::aix_service
                Class['ssh::config'] ~> Class['ssh::aix_service']
	}
}
