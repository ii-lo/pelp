Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  # config.vm.provision :shell, path: "VagrantBootstrap.sh"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
end
