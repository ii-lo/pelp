pelp
====

**Public E-Learning Platform**

Running server using Vagrant
----------------------------

On host:
 -  `vagrant up`
 -  `vagrant ssh`

Then on Vagrant machine:
 -  `$ bundle install`
 -  `$ rake db:create && rake db:migrate`
 -  `$ bin/rails server`

voila!

