# ttyd-k9s
--- 

K9s in a container that can be exposed through ttyd. 


### Usage 

Just run it, make sure to mount your kubernetes credentials. 

`docker run -it --rm -v ~/.kube:/root/.kube -p 7681:7681 dylanbstorey/ttyd-k9s:latest`

Navigate to `localhost:7681`.
