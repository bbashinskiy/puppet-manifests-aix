class ssh::config {
	file {
		'/etc/ssh/sshd_config':
                ensure => present,
                owner => 'root',
                group => "system",
                mode => 600,
                source => "puppet:///modules/ssh/sshd_config";

		'/etc/ssh/ssh_config':
                ensure => present,
                owner => 'root',
                group => "system",
                mode => 644,
                source => "puppet:///modules/ssh/ssh_config";
		
		['/applications/ssh/6.60.11.0/bin/ssh-keyscan','/applications/ssh/6.60.11.0/bin/ssh','/applications/ssh/6.60.11.0/libexec/sftp-server','/applications/ssh/6.60.11.0/bin/sftp','/applications/ssh/6.60.11.0/sbin/sshd','/applications/ssh/6.60.11.0/bin/ssh-agent','/applications/ssh/6.60.11.0/bin/ssh-add','/applications/ssh/6.60.11.0/libexec/ssh-keysign','/applications/ssh/6.60.11.0/bin/ssh-keygen','/applications/ssh/6.60.11.0/bin/scp','/applications/ssh/6.60.11.0/libexec/ssh-pkcs11-helper']:
                owner   => "root",
                group   => "system",
                mode    => "g-w,o-w",
	}
}

class ssh::service {
	/*file_line { 'enable sshd service':
                path  => '/etc/rc.tcpip',
                line  => 'start /applications/ssh/CURRENT/sbin/opensshd "$src_running"',
        }*/

        service { "opensshd":
                ensure => running,
        }
}

class ssh {
		include ssh::config, ssh::service
    Class['ssh::config'] ~> Class['ssh::service']
}
