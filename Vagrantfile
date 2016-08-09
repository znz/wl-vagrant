# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.hostname = ENV["VM_HOSTNAME"] || "wl.127.0.0.1.xip.io"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ['modifyvm', :id, '--nictype1', 'virtio']
  end

  config.vm.provision :shell, path: 'provision.sh'
  config.vm.provision :shell, path: 'provision-packages.sh'
  config.vm.provision :shell, path: 'provision-packages-emacs.sh'
  config.vm.provision :shell, path: 'provision-packages-misc.sh'
  config.vm.provision :shell, path: 'provision-nadoka.sh'
  config.vm.provision :shell, path: 'provision-anyenv.sh', privileged: false
  config.vm.provision :shell, path: 'provision-dot-shell.sh', privileged: false
  config.vm.provision :shell, path: 'provision-dot-emacs.sh', privileged: false
  config.vm.provision :shell, inline: 'install -d /home/vagrant/.byobu && install -m644 /vagrant/.byobu/keybindings.tmux /home/vagrant/.byobu/keybindings.tmux', privileged: false

  config.ssh.forward_agent = true
end
