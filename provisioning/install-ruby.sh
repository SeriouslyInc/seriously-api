#!/usr/bin/env bash

source $HOME/.rvm/scripts/rvm

# rvm requirements
rvm use --default --install --quiet-curl $1

shift

if (( $# ))
then gem install $@
fi

rvm cleanup all
