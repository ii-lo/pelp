# pelp (Public E-Learning Platform)

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
$ bundle install
$ rake db:create && rake db:migrate
$ rails server
```


voila!