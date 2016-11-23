# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.hostname = ENV["VM_HOSTNAME"] || "wl"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      owner: "_apt",
      group: "_apt",
      mount_options: ["dmode=777", "fmode=666"]
    }
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--nictype1', 'virtio']
    vb.customize [
      "modifyvm", :id,
      "--hwvirtex", "on",
      "--nestedpaging", "on",
      "--largepages", "on",
      "--ioapic", "on",
      "--pae", "on",
      "--paravirtprovider", "kvm",
    ]
  end

  config.vm.provision :shell, path: 'provision.sh'
  config.vm.provision :shell, path: 'provision-packages.sh'
  config.vm.provision :shell, path: 'provision-packages-emacs.sh'
  config.vm.provision :shell, path: 'provision-packages-misc.sh'
  config.vm.provision :shell, path: 'provision-nadoka.sh'
  config.vm.provision :shell, path: 'provision-anyenv.sh', privileged: false
  config.vm.provision :shell, path: 'provision-dot-shell.sh', privileged: false
  config.vm.provision :shell, path: 'provision-dot-emacs.sh', privileged: false
  config.vm.provision :shell, path: 'provision-go.sh', privileged: false
  config.vm.provision :shell, path: 'provision-libressl.sh', privileged: false
  config.vm.provision :shell, path: 'provision-ruby-git.sh', privileged: false
  config.vm.provision :shell, path: 'provision-ruby-svn.sh', privileged: false
  config.vm.provision :shell, path: 'provision-old-openssl.sh', privileged: false
  config.vm.provision :shell, path: 'provision-ruby-released.sh', privileged: false
  config.vm.provision :shell, path: 'provision-vim.sh', privileged: false

  config.ssh.forward_agent = true
end
