# pelp (Public E-Learning Platform)
[ ![Codeship Status for ii-lo/pelp](https://www.codeship.io/projects/6a541580-39c8-0132-a05a-4664fd0eaf1d/status)](https://www.codeship.io/projects/42253)

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
