docker build -t handzel/multi-client:latest -t handzel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t handzel/multi-server:latest -t handzel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t handzel/multi-worker:latest -t handzel/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push handzel/multi-client:latest
docker push handzel/multi-server:latest
docker push handzel/multi-worker:latest

docker push handzel/multi-client:$SHA
docker push handzel/multi-server:$SHA
docker push handzel/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=handzel/multi-server:$SHA
kubectl set image deployments/client-deployment client=handzel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=handzel/multi-worker:$SHA