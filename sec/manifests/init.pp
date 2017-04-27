class sec::config {
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
    include sec::config
}
