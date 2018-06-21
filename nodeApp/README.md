
## How to use local docker images with Minikube?


#### Build inside kubernetes 

```bash
eval $(minikube docker-env)

docker build -t node-app .

docker images
```


#### Run on kubernetes

with arg [ --image-pull-policy=Never ] ,  so that local image is used

```
kubectl run node-app --image=node-app:latest --image-pull-policy=Never --port=3000

## to verify

kubectl exec -it node-app-645694df7-wbvqz curl localhost:3000   # node-app-645694df7-wbvqz is pod name

# Hello from server !
                                                                

```

#### How to expose Kubernetes applications outside the cluster using the kubectl expose command?
 

```bash
kubectl expose deployment/node-app --type="NodePort" --port 3000

kubectl get services                               # list for services deployed

# NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
# kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          3d
# node-app     NodePort    10.105.117.60   <none>        3000:30073/TCP   6s

//visit port
open http://192.168.99.100:30073/


kubectl describe services/node-app 

```


### Attaching label to pod

```bash
kubectl get po

# NAME                       READY     STATUS    RESTARTS   AGE
# node-app-645694df7-wbvqz   1/1       Running   0          13h

kubectl label pod node-app-645694df7-wbvqz app=v1

# pod "node-app-645694df7-wbvqz" labeled

```


### Scaling node app

```bash
 kubectl scale deployments/node-app --replicas=4
 
 ## verify
 kubectl get po

```


### How to update a deployed application and rollback 

```bash
# Create new image with version tage v2 

kubectl set image deployments/node-app node-app=node-app:v2

# verify

kubectl get po


```


### How to deploy using deployment.yaml

```bash

kubectl apply -f NodeApp/deployment.yaml 

#verify 
kubectl describe deployment node-app-v1

```