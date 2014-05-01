#!/bin/sh

apt-get update
apt-get install -y openjdk-7-jre

JRUBY_HOME=/opt/jruby-1.7.11
if [ ! -f $JRUBY_HOME/bin/jruby ]; then
  cd /home/vagrant
  wget http://jruby.org.s3.amazonaws.com/downloads/1.7.11/jruby-bin-1.7.11.tar.gz
  tar -xzf jruby-bin-1.7.11.tar.gz -C /opt && rm jruby-bin-1.7.11.tar.gz
  chown -RH vagrant:vagrant $JRUBY_HOME
  echo "export PATH=$PATH:/opt/jruby-1.7.11/bin" > .bashrc
fi

export PATH=$PATH:$JRUBY_HOME/bin

apt-get install -y postgresql

echo "Setting up postgres"
service postgresql start
sudo -iu postgres createuser -s vagrant
sudo -iu postgres psql -d postgres -c "alter role vagrant superuser createdb replication"
sudo -iu postgres psql -d postgres -c "alter user vagrant with password ''"

cd /vagrant

jruby -S gem install bundler
jruby -S bundle install --path=vendor/bundle

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:setup

# install and setup nginx
apt-get install -y nginx
ln -sf /vagrant/config/vhosts/development.conf /etc/nginx/conf.d/development.conf

# Get puma going
PID=`cat /var/run/puma.pid`  
if ps -p $PID > /dev/null
then
  kill -s SIGUSR2 $PID
else
  bundle exec puma -b unix:///var/run/preemptivehack.sock --pidfile /var/run/puma.pid -d
fi

/etc/init.d/nginx restart