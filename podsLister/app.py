from kubernetes import client, config

# Configs can be set in Configuration class directly or using helper utility
config.load_kube_config()
configuration = kubernetes.client.Configuration()
configuration.api_key['authorization'] = 'YOUR_API_KEY'

# Set API Version
v1 = client.CoreV1Api()

# Set RBAC
#api_instance = kubernetes.client.RbacAuthorizationV1Api(kubernetes.client.ApiClient(configuration))

# List all pods (kubectl get pods --all-namespaces)
print("Listing pods with their IPs:")
ret = v1.list_pod_for_all_namespaces(watch=False)
for i in ret.items:
    print("%s\t%s\t%s" % (i.status.pod_ip, i.metadata.namespace, i.metadata.name))