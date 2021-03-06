# pelp (Public E-Learning Platform) [![Build Status](https://travis-ci.org/ii-lo/pelp.svg?branch=master)](https://travis-ci.org/ii-lo/pelp)
## Running development server using Vagrant

On host:
```
#!shell

$ cd /local/project/copy/directory
$ vagrant up
$ vagrant ssh
```


Then on Vagrant machine:

```
#!shell

$ cd /vagrant/
$ rails server
```


voila!


### Configuring RubyMine to work with Vagrant

> In rubymine:
>
> - go to options (command+`,`)
> - search `SDK` in options,
> - click `Add SDK` / `new remote`
> - click `Fill from Vagrant config` and select the folder where your Vagrantfile is located
> - **Very important**: In the field `Ruby interpreter path`, put `/home/vagrant/.rbenv/versions/2.1.4/bin/ruby` (your ruby version may change, check your versions with `ls /home/vagrant/.rbenv/versions` in your guest machine)
> - Click OK, grab a cofee
> - Your're done

Source: http://stackoverflow.com/a/19662310/3657395
