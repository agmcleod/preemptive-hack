group { "puppet":
  ensure => "present"
}

exec { "apt-update":
  command => "/usr/bin/apt-get update",
  require => Group[puppet],
}

Exec['apt-update'] -> Package <| |>

package { "openjdk-7-jre":
  ensure => "present"
}

include jruby
include postgres

exec { "install_bundler":
  cwd => '/vagrant',
  path => $path,
  command => "/opt/jruby-1.7.11/bin/jruby -S gem install bundler",
  logoutput => true,
  require => Exec['add_jruby_to_path'],
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
  command => 'jruby -e \'puts "hi"\'',
  cwd => '/vagrant',
  user => 'vagrant',
  path => $path,
  logoutput => true,
  require => Exec['bundle']
}

exec { 'dbmigrate':
  command => '/opt/jruby-1.7.11/bin/jruby -S bundle exec rake db:migrate',
  cwd => '/vagrant',
  user => 'vagrant',
  path => $path,
  logoutput => true,
  require => Exec['dbcreate']
}

exec { 'dbseed':
  command => '/opt/jruby-1.7.11/bin/jruby -S bundle exec rake db:seed',
  cwd => '/vagrant',
  user => 'vagrant',
  path => $path,
  logoutput => true,
  require => Exec['dbmigrate']
}