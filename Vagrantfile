# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "puppetlabs/centos-7.2-64-puppet"

    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP.
    config.vm.provider 'virtualbox' do |vb|
        vb.customize ["modifyvm", :id, "--natnet1", "172.31.9/24"]
        vb.gui = false
        vb.memory = 2048
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--hpet", "on"]
    end

    # Second network interface, vm's will all exist on this network
    ip = "192.168.44.25"
    config.vm.network :private_network, ip: ip

    $script = <<SCRIPT
echo I am provisioning...
export FACTER_is_vagrant='true'
[ -d /tmp/modules/db2 ] || mkdir -p /tmp/modules/db2
mount | grep /tmp/modules/db2 || mount --bind /vagrant /tmp/modules/db2
puppet module install puppetlabs-stdlib
puppet apply --modulepath '/tmp/modules:/etc/puppetlabs/code/environments/production/modules' -e "include '::db2'"
SCRIPT

    config.vm.provision "shell", inline: $script

end
