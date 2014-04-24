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
include setup
include puma