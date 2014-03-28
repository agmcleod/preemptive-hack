# -*- mode: ruby -*-
# vi: set ft=ruby :

def Kernel.windows?
  RUBY_PLATFORM =~ /mingw32/
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "jruby-puma"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-puppet.box"
  config.vm.hostname = "preemptivehack.vm"

  config.vm.network "private_network", :ip => '192.168.1.105'

  ######################################################################
  # shared application folder at /vagrant
  ######################################################################
  config.vm.synced_folder ".", "/vagrant", :nfs => !Kernel.windows?
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
  end

  config.vm.provision :puppet

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
end
