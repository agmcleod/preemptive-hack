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

  config.vm.network "private_network", :ip => '172.27.27.18'

  ######################################################################
  # shared application folder at /vagrant
  ######################################################################
  config.vm.synced_folder ".", "/vagrant", :nfs => !Kernel.windows?
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
  end

  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "puppet/manifests"
  #   puppet.module_path = "puppet/modules"
  #   puppet.manifest_file = "default.pp"
  # end

  config.vm.provision :shell, :path => "config/vagrant/setup.sh"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
end
