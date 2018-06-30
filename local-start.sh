#!/usr/bin/env bash

echo "Creating a new private key"
ssh-keygen -f key/id_rsa -t rsa -b 4096 -C "ubuntu@minikube-ks"
chmod 600 key/id_rsa

echo "Creating Vagrant machine"
vagrant up

echo "Loging into vagrant machine"
vagrant ssh