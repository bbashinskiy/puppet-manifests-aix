class snmp::config {
	file {
		'/etc/snmpd.conf':
         	ensure => present,
                owner => 'root',
                group => 'system',
                mode => 640,
                source => 'puppet:///modules/snmp/snmpd-aix.conf';

		'/etc/snmpdv3.conf':
                ensure => present,
                owner => 'root',
                group => 'system',
                mode => 640,
                source => 'puppet:///modules/snmp/snmpdv3.conf';
	}
}

class snmp::service {
	  file_line { 'enable snmpd service':
      ensure => absent,
  		path   => '/etc/rc.tcpip',
  		line   => 'start /usr/sbin/snmpd "$src_running"',
	  }
	
        service { "snmpd":
                ensure => running,
		            /*enable => true,*/
		            provider => src, 
        }       
}


class snmp {
		include snmp::config, snmp::service
    Class['snmp::config'] ~> Class['snmp::service']
}
