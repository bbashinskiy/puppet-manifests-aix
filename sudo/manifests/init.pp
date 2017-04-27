class sudo::install {
	package {"sudo":
		ensure => present,
	}
}

class sudo::config {
	$groupperm = $operatingsystem ? {
                'RedHat' => 'root',
                'AIX' => 'system',
        }

	file {
		'/etc/sudoers':
                ensure => present,
                owner => 'root',
                group => "$groupperm",
                mode => 440,
                source => 'puppet:///modules/sudo/sudoers';
		
		'/etc/sudo.env':
                ensure => present,
                owner => 'root',
                group => "$groupperm",
                mode => 440,
                source => 'puppet:///modules/sudo/sudo.env';
	
		'/etc/sudoers.d':
		recurse => true,
		purge => true,
                ensure => directory,
                owner => 'root',
                group => "$groupperm",
                mode => 440;
		
		'/etc/sudoers.d/010_STD_ALIAS_GLB':
                ensure => present,
                source => 'puppet:///modules/sudo/010_STD_ALIAS_GLB';
	
		'/etc/sudoers.d/010_STD_NEG_GLB':
                ensure => present,
                source => 'puppet:///modules/sudo/010_STD_NEG_GLB';
		
		'/etc/sudoers.d/4aa_STD_ALIAS_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4aa_STD_ALIAS_LCL';

		'/etc/sudoers.d/4xx_BCP_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_BCP_LCL';

		'/etc/sudoers.d/4xx_COMMVAULT_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_COMMVAULT_LCL';

		'/etc/sudoers.d/4xx_CTOOLS_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_CTOOLS_LCL';

		'/etc/sudoers.d/4xx_DB2_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_DB2_LCL';

		'/etc/sudoers.d/4xx_IEM_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_IEM_LCL';

		'/etc/sudoers.d/4xx_ITM_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_ITM_LCL';

		'/etc/sudoers.d/4xx_LDAP_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_LDAP_LCL';

		'/etc/sudoers.d/4xx_NAS_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_NAS_LCL';	

		'/etc/sudoers.d/4xx_NCO_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_NCO_LCL';

		'/etc/sudoers.d/4xx_SAP_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_SAP_LCL';

		'/etc/sudoers.d/4xx_SCCD_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_SCCD_LCL';

		'/etc/sudoers.d/4xx_TAD4D_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_TAD4D_LCL';

		'/etc/sudoers.d/4xx_TADDM_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_TADDM_LCL';

		'/etc/sudoers.d/4xx_TEMP_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_TEMP_LCL';

		'/etc/sudoers.d/4xx_UNIX_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_UNIX_LCL';

		'/etc/sudoers.d/4xx_WME_LCL':
                ensure => present,
                source => 'puppet:///modules/sudo/4xx_WME_LCL';
    
    		'/etc/sudoers.d/4xx_NET_LCL':
      		ensure => present,
      		source => 'puppet:///modules/sudo/4xx_NET_LCL';
    
    		'/etc/sudoers.d/4xx_TCR_LCL':
      		ensure => present,
      		source => 'puppet:///modules/sudo/4xx_TCR_LCL';

    		'/etc/sudoers.d/4xx_AWS_LCL':
      		ensure => present,
      		source => 'puppet:///modules/sudo/4xx_AWS_LCL';

      		'/etc/sudoers.d/4xx_ECM_LCL':
      		ensure => present,
      		source => 'puppet:///modules/sudo/4xx_ECM_LCL';

      		'/etc/sudoers.d/8000_sudoers_CUST':
      		ensure => present,
      		source => 'puppet:///modules/sudo/8000_sudoers_CUST';

      		'/etc/sudoers.d/8998_sudoers_NA_CUST':
      		ensure => present,
      		source => 'puppet:///modules/sudo/8998_sudoers_NA_CUST';

    }
}

class sudo {
	if $operatingsystem == 'RedHat' {
		include sudo::install, sudo::config
		Class['sudo::install'] -> Class['sudo::config']
	} elsif $operatingsystem == 'AIX' {
		include sudo::config
	}
}
