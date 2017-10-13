# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, host: 3000, guest: 3000
  config.vm.network :forwarded_port, host: 4567, guest: 4567

  config.vm.provider "virtualbox" do |vb|
    # several vbox performance optimizations
    vb.customize ["modifyvm", :id,
      "--paravirtprovider", "kvm",
      "--memory", "2048",
      "--cpus", "2",
    ]
  end

  config.vm.provision :shell, path: "provisioning/bootstrap.sh"
  config.vm.provision :shell, path: "provisioning/install-rvm.sh", args: "stable", privileged: false
  config.vm.provision :shell, path: "provisioning/install-ruby.sh", args: "2.4.2 bundler foreman", privileged: false
  
end