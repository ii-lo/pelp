#!/usr/bin/env bash

# Install required packages
apt-get update
apt-get --yes --force-yes install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libqt4-dev node

# Install ruby
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.3

# TODO From this line this script does not always work :(
rvm use 2.1.3 --default

cd /vagrant/
bundle install