class setup {
  $jruby_home = '/opt/jruby-1.7.11'
  exec { "install_bundler":
    cwd => '/vagrant',
    path => $path,
    command => "/opt/jruby-1.7.11/bin/jruby -S gem install bundler",
    logoutput => true
  }

  exec { 'bundle':
    command => '/opt/jruby-1.7.11/bin/jruby -S bundle install --path=vendor/bundle',
    cwd => '/vagrant',
    user => 'vagrant',
    path => $path,
    logoutput => true,
    require => [Exec['createuser'], Exec['install_bundler']]
  }

  exec { 'dbcreate':
    command => "jruby -S bundle exec rake db:create",
    cwd => '/vagrant',
    user => 'vagrant',
    path => "${path}:${jruby_home}/bin",
    logoutput => true,
    require => Exec['bundle']
  }

  exec { 'dbmigrate':
    command => "jruby -S bundle exec rake db:migrate",
    cwd => '/vagrant',
    user => 'vagrant',
    path => "${path}:${jruby_home}/bin",
    logoutput => true,
    require => Exec['dbcreate']
  }

  exec { 'dbseed':
    command => "jruby -S bundle exec rake db:seed",
    cwd => '/vagrant',
    user => 'vagrant',
    path => "${path}:${jruby_home}/bin",
    logoutput => true,
    require => Exec['dbmigrate']
  }
}