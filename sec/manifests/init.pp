class sec::lnx_config {
	file { 
		'/etc/security/opasswd':
			owner	=> "root",
			group	=> "root",
			mode	=> "600";

		'/etc/shadow':
      owner   => "root",
      group   => "root",
      mode    => "600";

		'/etc/pam.d':
			ensure  => directory,
      owner   => "root",
                	group   => "root",
                	mode    => "755";

		'/etc/pam.d/system-auth-ac':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/system-auth-ac";

		'/etc/pam.d/system-auth':
                        ensure => link,
                        target => 'system-auth-ac';

		'/etc/pam.d/passwd':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/passwd";

		'/etc/pam.d/login':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/login";

		'/etc/pam.d/password-auth-ac':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/password-auth-ac";
		
		'/etc/pam.d/password-auth':
                        ensure => link,
                        target => 'password-auth-ac';

		'/etc/pam.d/other':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/other";

		'/etc/pam.d/sshd':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/sshd";

		'/etc/pam.d/su':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/su";

		'/etc/login.defs':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/login.defs";
        }
}

class sec::aix_config {
  file_line { 
    "root in ftpusers file":
      ensure => 'present',
      line  => 'root',
      path  => '/etc/ftpusers';

    "user in in dict":
      ensure => 'present',
      line   => '$USER',
      path   => '/usr/share/dict/words',
  }

  chsec { 
    "default_maxage":
      ensure => present,
      attribute => 'maxage',
      value => '13',
      file  => '/etc/security/user',
      stanza => 'default';

    "default_minage": 
      ensure => present, 
      attribute => 'minage', 
      value => '1', 
      file => '/etc/security/user', 
      stanza => 'default';

    "default_minalpha":
      ensure    => present,
      attribute => 'minalpha',
      value     => '1',
      file      => '/etc/security/user',
      stanza    => 'default';

    "default_histsize":
      ensure    => present,
      attribute => 'histsize',
      value     => '10',
      file      => '/etc/security/user',
      stanza    => 'default';

    "default_minlen":
      ensure    => present,
      attribute => 'minlen',
      value     => '8',
      file      => '/etc/security/user',
      stanza    => 'default';

    "default_minother":
      ensure    => present,
      attribute => 'minother',
      value     => '1',
      file      => '/etc/security/user',
      stanza    => 'default';
      
    "default_loginretries":
      ensure    => present,
      attribute => 'loginretries',
      value     => '5',
      file      => '/etc/security/user',
      stanza    => 'default';

    "default_dictionlist":
      ensure    => present,
      attribute => 'dictionlist',
      value     => '/usr/share/dict/words',
      file      => '/etc/security/user',
      stanza    => 'default';

    "root_rlogin":
      ensure    => present,
      attribute => 'rlogin',
      value     => 'false',
      file      => '/etc/security/user',
      stanza    => 'root';

    "usw_pwd_algorithm":
      ensure    => present,
      attribute => 'pwd_algorithm',
      value     => 'ssha512',
      file      => '/etc/security/login.cfg',
      stanza    => 'usw';
  }
}

class sec {
  if $operatingsystem == 'RedHat' {
    include sec::lnx_config
  } elsif $operatingsystem == 'AIX' {
    include sec::aix_config
  }
}
