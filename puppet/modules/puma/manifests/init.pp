class puma {
  file { "/var/run":
    ensure => "directory",
    owner => 'vagrant',
    group => 'vagrant',
    mode => '755'
  }

  exec { "puma-restart":
    path => "${path}:/opt/jruby-1.7.11/bin",
    cwd => '/vagrant',
    user => 'vagrant',
    command => 'chmod a+x /vagrant/puppet/modules/puma/restart.sh && /vagrant/puppet/modules/puma/restart.sh',
    require => File['/var/run']
  }
}