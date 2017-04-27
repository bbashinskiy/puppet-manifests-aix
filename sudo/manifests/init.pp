class sudo::config {
	file {
		'/etc/sudoers':
                ensure => present,
                owner => 'root',
                group => system,
                mode => 440,
                source => 'puppet:///modules/sudo/sudoers';
		
		'/etc/sudo.env':
                ensure => present,
                owner => 'root',
                group => system,
                mode => 440,
                source => 'puppet:///modules/sudo/sudo.env';
	
		'/etc/sudoers.d':
	  	          purge => true,
                ensure => directory,
                owner => 'root',
                group => system,
                mode => 440;
		
		'/etc/sudoers.d/010_STD_ALIAS_GLB':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/010_STD_ALIAS_GLB',
                mode => 440;
	
		'/etc/sudoers.d/010_STD_NEG_GLB':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/010_STD_NEG_GLB',
                mode => 440;

		'/etc/sudoers.d/4aa_STD_ALIAS_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4aa_STD_ALIAS_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_BCP_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_BCP_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_COMMVAULT_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_COMMVAULT_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_CTOOLS_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_CTOOLS_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_DB2_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_DB2_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_IEM_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_IEM_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_ITM_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_ITM_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_LDAP_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_LDAP_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_NAS_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_NAS_LCL',	
                mode => 440;

		'/etc/sudoers.d/4xx_NCO_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_NCO_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_SAP_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_SAP_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_SCCD_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_SCCD_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_TAD4D_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_TAD4D_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_TADDM_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_TADDM_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_TEMP_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_TEMP_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_UNIX_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_UNIX_LCL',
                mode => 440;

		'/etc/sudoers.d/4xx_WME_LCL':
                ensure => present,
		owner => 'root',
                group => 'root',
                source => 'puppet:///modules/sudo/4xx_WME_LCL',
                    mode => 440;

    		'/etc/sudoers.d/4xx_NET_LCL':
      		ensure => present,
		owner => 'root',
                group => 'root',
      		source => 'puppet:///modules/sudo/4xx_NET_LCL',
                    mode => 440;

    		'/etc/sudoers.d/4xx_TCR_LCL':
      		ensure => present,
		owner => 'root',
                group => 'root',
      		source => 'puppet:///modules/sudo/4xx_TCR_LCL',
                mode => 440;

    		'/etc/sudoers.d/4xx_AWS_LCL':
      		ensure => present,
		owner => 'root',
                group => 'root',
      		source => 'puppet:///modules/sudo/4xx_AWS_LCL',
                mode => 440;

      		'/etc/sudoers.d/4xx_ECM_LCL':
      		ensure => present,
		owner => 'root',
                group => 'root',
      		source => 'puppet:///modules/sudo/4xx_ECM_LCL',
                mode => 440;

      		'/etc/sudoers.d/8000_sudoers_CUST':
      		ensure => present,
		owner => 'root',
                group => 'root',
      		source => 'puppet:///modules/sudo/8000_sudoers_CUST',
                mode => 440;

      		'/etc/sudoers.d/8998_sudoers_NA_CUST':
      		ensure => present,
		owner => 'root',
                group => 'root',
      		source => 'puppet:///modules/sudo/8998_sudoers_NA_CUST',
                mode => 440;
    }
}

class sudo {
		include sudo::config
	}
}
