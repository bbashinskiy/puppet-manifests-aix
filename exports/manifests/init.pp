class exports::config {
	file {'/etc/exports':
		mode => '644',
		owner => 'root',
		group => 'system',
	}
}

class exports {
	include exports::config
}
