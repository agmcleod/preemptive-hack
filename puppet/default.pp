exec { "update":
  command => "apt-get update",
  path => $path,
}

exec { "java":
  command => "apt-get install -y openjdk-7-jre",
  path => $path,
}

exec { "jruby_download":
  cwd => "/home/vagrant",
  path => $path,
  command => "wget http://jruby.org.s3.amazonaws.com/downloads/1.7.11/jruby-bin-1.7.11.tar.gz",
  require => Exec["update"],
}

exec { "jruby_unzip":
  cwd => "/home/vagrant",
  path => $path,
  command => "tar -xzf jruby-bin-1.7.11.tar.gz -C /opt && rm jruby-bin-1.7.11.tar.gz",
  require => Exec["jruby_download"],
}

exec { "add_jruby_to_path":
  cwd => "/home/vagrant",
  path => $path,
  command => 'echo "export PATH=$PATH:/opt/jruby-1.7.11/bin" > .bashrc',
  require => Exec["jruby_unzip"],
}

exec { "install_bundler":
  cwd => '/vagrant',
  path => $path,
  command => "gem install bundler",
  require => Exec['add_jruby_to_path'],
  logoutput => true,
}

class postgres {
  package { "postgresql":
    ensure => 'present',
  }

  user { 'postgres':
    ensure => 'present',
    require => Package['postgresql'],
  }

  group { 'postgres':
    ensure => 'present',
    require => User['postgres']
  }

  exec { "createuser":
    command => "createuser -U postgres -SdRw vagrant",
    user   => 'postgres',
    path   => $path,
    unless => "psql -c \
      \"select * from pg_user where usename='vagrant'\" | grep -c vagrant",
    require => Group['postgres']
  }
}

include postgres

exec { 'bundle':
  command => 'bundle install --path=vendor/bundle',
  cwd => '/vagrant',
  path => $path,
  logoutput => true,
  require => [Exec['createuser'], Exec['add_jruby_to_path']]
}