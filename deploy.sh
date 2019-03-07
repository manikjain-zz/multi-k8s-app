docker build -t manikjain/multi-client:latest -t manikjain/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t manikjain/multi-server:latest -t manikjain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t manikjain/multi-worker:latest -t manikjain/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push manikjain/multi-client:latest
docker push manikjain/multi-server:latest
docker push manikjain/multi-worker:latest

docker push manikjain/multi-client:$SHA
docker push manikjain/multi-server:$SHA
docker push manikjain/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=manikjain/multi-server:$SHA
kubectl set image deployments/client-deployment client=manikjain/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=manikjain/multi-worker:$SHA