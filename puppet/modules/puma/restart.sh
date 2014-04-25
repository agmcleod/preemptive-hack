#!/bin/sh
PID=`cat /var/run/puma.pid`
if ps -p $PID > /dev/null
then
   sudo kill -s SIGUSR2 cat `/var/run/puma.pid`
fi
cd /vagrant
jruby -S bundle exec puma -b unix:///var/run/preemptivehack.sock --pidfile /var/run/puma.pid