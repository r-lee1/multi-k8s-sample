docker build -t rlee1/multi-client:latest -t rlee1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rlee1/multi-server:latest -t rlee1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rlee1/multi-worker:latest -t rlee1/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rlee1/multi-client:latest
docker push rlee1/multi-client:$SHA
docker push rlee1/multi-server:latest
docker push rlee1/multi-server:$SHA
docker push rlee1/multi-worker:latest
docker push rlee1/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rlee1/multi-server:$SHA
kubectl set image deployments/client-deployment client=rlee1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rlee1/multi-worker:$SHA
