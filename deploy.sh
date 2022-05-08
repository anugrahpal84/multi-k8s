docker build -t anugrahpal/multi-client:latest -t anugrahpal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anugrahpal/multi-server:latest -t anugrahpal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anugrahpal/multi-worker:latest -t anugrahpal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anugrahpal/multi-client:latest
docker push anugrahpal/multi-server:latest
docker push anugrahpal/multi-worker:latest

docker push anugrahpal/multi-client:$SHA
docker push anugrahpal/multi-server:$SHA
docker push anugrahpal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anugrahpal/multi-server:$SHA
kubectl set image deployments/client-deployment client=anugrahpal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anugrahpal/multi-worker:$SHA