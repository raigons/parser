# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box

    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder ".", "/vagrant_data"

  config.ssh.insert_key = false

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "infra/provisioning/site.yml"
    ansible.inventory_path = "infra/provisioning/dev"
    ansible.sudo = true
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end
