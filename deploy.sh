docker build -t arturkociuba/multi-client:latest -t arturkociuba/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arturkociuba/multi-server:latest -t arturkociuba/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arturkociuba/multi-worker:latest -t arturkociuba/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push arturkociuba/multi-client:latest
docker push arturkociuba/multi-server:latest
docker push arturkociuba/multi-worker:latest
docker push arturkociuba/multi-client:$SHA
docker push arturkociuba/multi-server:$SHA
docker push arturkociuba/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=arturkociuba/multi-client:$SHA
kubectl set image deployments/server-deployment server=arturkociuba/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=arturkociuba/multi-worker:$SHA
