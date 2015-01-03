# Based on https://gorails.com/guides/using-vagrant-for-rails-development

$script = <<SCRIPT
  cd /vagrant/
  bundle install
  rake db:create
  rake db:migrate
  rake db:populate
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    #chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "libqt4::dev"
    chef.add_recipe "imagemagick"
    chef.add_recipe "imagemagick::devel"

  end

   config.vm.provision :shell, :path => "install-rvm.sh",  :args => "stable", privileged: false
   config.vm.provision :shell, :path => "install-ruby.sh", :args => "2.2.0", privileged: false
  config.vm.provision :shell, run: :always, privileged: false, inline: $script
end
