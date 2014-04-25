class nginx {
  package { "nginx":
    ensure => 'installed'
  }

  exec { "restart":
    command => 'service nginx restart',
    path => $path,
    require => [Package['nginx'], Exec['puma-restart']]
  }
}