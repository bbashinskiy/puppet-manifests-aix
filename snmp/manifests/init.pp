class snmp::lnx_install {
	package {"net-snmp":
		ensure => present,
	}
}

class snmp::lnx_config {
	file {
		'/etc/sysconfig/snmptrapd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmptrapd';

		'/etc/sysconfig/snmpd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmpd';
		
		'/etc/snmp/snmpd.conf':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmpd.conf';

		'/etc/snmp/snmptrapd.conf':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmptrapd.conf';

		'/etc/rc.d/init.d/snmptrapd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/snmp/snmptrapd-init';

		'/etc/rc.d/init.d/snmpd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/snmp/snmpd-init';	
        }
}

class snmp::aix_config {
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

class snmp::lnx_service {
	service { "snmpd":
		ensure => running,
		enable => true,	
	}
}

class snmp::aix_service {
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
	if $operatingsystem == 'RedHat' {	
		include snmp::lnx_install, snmp::lnx_config, snmp::lnx_service
		Class['snmp::lnx_install'] -> Class['snmp::lnx_config'] ~> Class['snmp::lnx_service']
	} elsif $operatingsystem == 'Aix' {
		include snmp::aix_config, snmp::aix_service
                Class['snmp::aix_config'] ~> Class['snmp::aix_service']
	}
}
