VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network :private_network, type: :dhcp
  config.vm.network :forwarded_port, guest: 9200, host: 9200

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'provisioning/fnb-parser.yml'
  end
end
