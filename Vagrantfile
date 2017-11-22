# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provision :shell,
    inline: "sudo -u ubuntu /vagrant/bootstrap/install-mongodb-local.sh /vagrant/config.sh"
  
  config.vm.network :forwarded_port, host: 27017, guest: 27017

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 1
    v.name = "OL-Mongo"
  end
end
