Vagrant.configure("2") do |config|
  config.vm.box = "debian-70rc1-dotclear"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"

 
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.hostname = 'dotclear.local'
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--name", "debian-70rc1-dotclear"]
  end

  
  config.vm.synced_folder "./behat-dotclear", "/home/vagrant/behat-dotclear", id: "v-behat-dotclear" 

  config.vm.provision :shell, :inline => "sudo apt-get update"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file = "debian-dotclear.pp"
    puppet.options = ['--verbose --debug']
  end
  
end
