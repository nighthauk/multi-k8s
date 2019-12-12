docker build -t nighthauk/multi-client:latest -t nighthauk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nighthauk/multi-server:latest -t nighthauk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nighthauk/multi-worker:latest -t nighthauk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nighthauk/multi-client:latest
docker push nighthauk/multi-server:latest
docker push nighthauk/multi-worker:latest

docker push nighthauk/multi-client:$SHA
docker push nighthauk/multi-server:$SHA
docker push nighthauk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nighthauk/multi-server:$SHA
kubectl set image deployments/client-deployment client=nighthauk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nighthauk/multi-worker:$SHA