class profile::config {
	file { 
		'/etc/profile':
                	ensure 	=> present,
			owner	=> "root",
			group	=> "root",
			mode	=> "644",
			source  => "puppet:///modules/profile/profile";

		'/etc/csh.login':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/csh.login";

		['/etc/profile.d','/etc/skel']:
			ensure  => directory,
                	owner   => "root",
                	group   => "root",
                	mode    => "755",
			recurse => true,
        		purge   => true;

		'/etc/skel/.bash_logout':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/bash_logout";

		'/etc/skel/.bash_profile':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/bash_profile";

		'/etc/skel/.bashrc':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/bashrc";

		'/etc/skel/.kshrc':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/kshrc";

		'/etc/profile.d/IBMsinit.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "755",
                        source  => "puppet:///modules/profile/IBMsinit.sh";

		'/etc/profile.d/IBMsinit.csh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "755",
                        source  => "puppet:///modules/profile/IBMsinit.csh";

		'/etc/profile.d/colorls.csh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/colorls.csh";

		'/etc/profile.d/colorls.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/colorls.sh";

		'/etc/profile.d/glib2.csh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/glib2.csh";

		'/etc/profile.d/glib2.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/glib2.sh";

		'/etc/profile.d/hist_time_format.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/hist_time_format.sh";

		'/etc/profile.d/lang.csh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/lang.csh";

		'/etc/profile.d/lang.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/lang.sh";

		'/etc/profile.d/less.csh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/less.csh";

		'/etc/profile.d/less.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/less.sh";

		'/etc/profile.d/vim.csh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/vim.csh";

		'/etc/profile.d/vim.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/vim.sh";

		'/etc/profile.d/which2.sh':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/profile/which2.sh";
        }
}

class profile {
        include profile::config
}
