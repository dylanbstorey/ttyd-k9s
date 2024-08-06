# ttyd-k9s
--- 

K9s in a container that can be exposed through ttyd. 


## Usage 

### Docker 
Just run it, make sure to mount your kubernetes credentials. 

`docker run -it --rm -v ~/.kube:/root/.kube -p 7681:7681 dylanbstorey/ttyd-k9s:latest`

Navigate to `localhost:7681`.


### Kubernetes
There's a provided [example deployment](k8s_deployment) but the gist is create objects for: 
- your normal service/deployment/ingress
- create a secret that contains your kube config
- create service-account, role, and role-bindings
