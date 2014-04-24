class jruby {
  $jruby_home = '/opt/jruby-1.7.11'

  exec { "jruby_download":
    cwd => "/home/vagrant",
    path => $path,
    user => 'vagrant',
    command => "wget http://jruby.org.s3.amazonaws.com/downloads/1.7.11/jruby-bin-1.7.11.tar.gz",
  }

  exec { "jruby_unzip":
    cwd => "/home/vagrant",
    path => $path,
    command => "tar -xzf jruby-bin-1.7.11.tar.gz -C /opt && rm jruby-bin-1.7.11.tar.gz",
    creates => "${jruby_home}",
    require => Exec["jruby_download"],
  }

  exec { "chwon_jruby":
    cwd => '/home/vagrant',
    path => $path,
    command => "chown -RH vagrant:vagrant ${jruby_home}",
    require => Exec["jruby_unzip"],
  }

  exec { "add_jruby_to_path":
    cwd => "/home/vagrant",
    path => $path,
    user => 'vagrant',
    command => 'echo "export PATH=$PATH:/opt/jruby-1.7.11/bin" > .bashrc',
    require => Exec["jruby_unzip"],
  }
}