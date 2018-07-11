Start minikube
````
/vagrant/scripts/start-minikube.sh
````

To minitor with the dashboard
````
minikube dashboard --url
````

To start the job

````
cd /vagrant/podsLister
kubectl create -f k8s-pod-lister.job.yml
````

To see job information
````
kubectl describe jobs/pod-lister
````

````
pods=$(kubectl get pods --selector=job-name=pod-lister --output=jsonpath={.items..metadata.name})
kubectl logs $pods
````

To delete job
````
kubectl delete job pod-lister
````