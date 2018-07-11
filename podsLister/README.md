# Python script to list pods

This python script runs in a Docker container managed by Kubernetes and list all the pods in all namespaces.


## How to use:

### Requirements:

* Docker
* Kubernetes or minikube


### Usage:

#### Step 1:
Start minikube *(if not running)*
````
/vagrant/scripts/start-minikube.sh
````

Monitor with the minikube dashboard *(optional)*
````
minikube dashboard --url
````

#### Step 2:

Start the job
````
cd /vagrant/podsLister
kubectl create -f k8s-pod-lister.job.yml
````

To see job information if needed
````
kubectl describe jobs/pod-lister
````

#### Step 3:

Get the script info trought STDOUT

````
pods=$(kubectl get pods --selector=job-name=pod-lister --output=jsonpath={.items..metadata.name})
kubectl logs $pods
````

#### Delete job:

````
kubectl delete job pod-lister
````