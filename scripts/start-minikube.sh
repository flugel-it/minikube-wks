#!/usr/bin/env bash

# Starts minikube
sudo minikube start --vm-driver=none

# Set Minikube to vagrant instead of root
sudo chown -R $USER $HOME/.kube
sudo chgrp -R $USER $HOME/.kube

sudo chown -R $USER $HOME/.minikube
sudo chgrp -R $USER $HOME/.minikube

# See status
minikube status

# Start dashboard and prints dashboard URL
minikube dashboard
minikube dashboard --url > $DASHBOARDURL
echo $DASHBOARDURL