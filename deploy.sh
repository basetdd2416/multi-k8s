docker build -t bluesaluman/multi-client:latest -t bluesaluman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bluesaluman/multi-server:latest -t bluesaluman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bluesaluman/multi-worker -t -t bluesaluman/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bluesaluman/multi-client:$SHA
docker push bluesaluman/multi-server$SHA
docker push bluesaluman/multi-worker$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bluesaluman/multi-server:$SHA
kubectl set image deployments/client-deployment client=bluesaluman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bluesaluman/multi-worker:$SHA