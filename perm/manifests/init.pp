class perm::config {
    file {
    ['/usr/bin','/usr/etc','/usr/local']:
                ensure => directory,
                mode => 'o-w',
                recurse => true;

		'/etc':
                ensure => directory,
                mode => 'o-w',
                recurse => true,
                ignore => 'cluster';
		
		['/var','/var/adm']:
                ensure => directory,
                mode => 'o-w';

                ['/tmp','/var/tmp']:
                ensure => directory,
                mode => '1777';
		
		'/bin':
		ensure => '/usr/bin';
    }

	exec {'/var File Permissions LINUX-MULTI':
                command => 'find /var -type f -perm -o=wx -exec chmod -x,o-w {} \;',
                onlyif => 'test $(find /var -type f -perm -o=wx|wc -l) -gt 0',
                path => '/bin:/usr/bin',
        }

	exec {'/tmp File Permissions LINUX-MULTI':
                command => 'find /tmp -type f -perm -o=wx -exec chmod -x,o-w {} \;',
                onlyif => 'test $(find /tmp -type f -perm -o=wx|wc -l) -gt 0',
                path => '/bin:/usr/bin',
        }

	exec {'/opt File Permissions LINUX-MULTI':
                command => 'find /opt -type f -perm -o=wx -exec chmod -x,o-w {} \;',
                onlyif => 'test $(find /opt -type f -perm -o=wx|wc -l) -gt 0',
                path => '/bin:/usr/bin',
        }
}

class perm {
		include perm::config
}

