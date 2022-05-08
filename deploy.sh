docker build -t anugrahpal84/multi-client:latest -t anugrahpal84/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anugrahpal84/multi-server:latest -t anugrahpal84/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anugrahpal84/multi-worker:latest -t anugrahpal84/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anugrahpal84/multi-client:latest
docker push anugrahpal84/multi-server:latest
docker push anugrahpal84/multi-worker:latest

docker push anugrahpal84/multi-client:$SHA
docker push anugrahpal84/multi-server:$SHA
docker push anugrahpal84/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anugrahpal84/multi-server:$SHA
kubectl set image deployments/client-deployment client=anugrahpal84/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anugrahpal84/multi-worker:$SHA