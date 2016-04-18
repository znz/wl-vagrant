# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/wily64"
  config.vm.hostname = ENV["VM_HOSTNAME"] || "wanderlust.127.0.0.1.xip.io"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :shell, path: 'provision1.sh'
  config.vm.provision :shell, path: 'provision2.sh', privileged: false
end
