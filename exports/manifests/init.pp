class exports::config {
	file {'/etc/exports':
		mode => '644',
		owner => 'root',
		group => 'root',
	}
}

class exports {
	include exports::config
}
