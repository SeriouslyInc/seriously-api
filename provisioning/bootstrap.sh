#!/bin/bash

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

export DEBIAN_FRONTEND=noninteractive

#####################
# Basic Preparation #
#####################
echo "seriously" > /etc/hostname
hostname seriously

# Setup External Repositories
apt-get update && apt-get install -y --fix-missing software-properties-common

# Postgresql
PG_REPO_APT_SOURCE=/etc/apt/sources.list.d/pgdg.list
if [ ! -f "$PG_REPO_APT_SOURCE" ]
then
  # Add PG apt repo:
  echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > "$PG_REPO_APT_SOURCE"

  # Add PGDG repo key:
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
fi

# Update the System
apt-get update
aptitude upgrade --safe -y

# Uninstall annoying things (ubuntu MOTD)
apt-get remove --purge landscape-common -y
rm /run/motd.dynamic

# Install the things we need
# g++ used to compile unf_ext native extensions
apt-get install -y \
    imagemagick \
    git \
    vim \
    build-essential \
    g++ \
    libssl-dev \
    openssl \
    postgresql \
    postgresql-contrib \
    libpq-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    redis-server \
    curl

# Setup the Database
sudo -u postgres /usr/bin/createuser -s vagrant

# helpful vagrant ssh login message
ln -sf /vagrant/provisioning/motd /etc/motd

# add our own sub-bashrc to configure ssh env
cat << EOF >> /home/vagrant/.bashrc

# run seriously login tasks
source /vagrant/provisioning/bashrc.sh
EOF
