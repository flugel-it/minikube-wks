#!/usr/bin/env bash

# Starts minikube
sudo minikube start --vm-driver=none

# Set Minikube to vagrant instead of root
sudo mv /root/.kube $HOME/.kube # this will write over any previous configuration
sudo chown -R $USER $HOME/.kube
sudo chgrp -R $USER $HOME/.kube

sudo mv /root/.minikube $HOME/.minikube # this will write over any previous configuration
sudo chown -R $USER $HOME/.minikube
sudo chgrp -R $USER $HOME/.minikube

# See status
minikube status

# Start dashboard
minikube dashboard