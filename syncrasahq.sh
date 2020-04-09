#!/bin/bash

#Sync master branch from RasaHQ to this branch

# 1. git remote add rasahq git@github.com:RasaHQ/rasa.git
# 2. pull rasahq
git fetch rasahq

# 3. merge rasahq/master
git merge rasahq/master

# 4. commit
