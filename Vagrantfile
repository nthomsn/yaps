# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "vagrant.sh"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.synced_folder ".", "/home/vagrant/yaps"
end
